
import { BehaviorSubject, debounceTime, switchMap } from 'rxjs';

const searchQuery$ = new BehaviorSubject('');

export const results$ = searchQuery$.pipe(
  debounceTime(300),
  switchMap((query) => {
    
  })
);

export const setSearchQuery = (value) => searchQuery$.next(value);
