Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BA49835F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiAXPPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiAXPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:15:49 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2CC061401
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:15:48 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id r15so31594839uao.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRUzzoLYxlrhGNgxBbOH7Wf9YtHCiK8fKYwn8zs5y4E=;
        b=kRd7RLQ6DZaZsDSwZG6IrW8fBKZzw8WKkUR/Htawx7nfgY16HcFFDyYhl0If1a+qr2
         a/Ica6wIYcD5UHh8CgJiSaTfASAxF8SADpAMFqoux/LhFVf0cl+VUjxFyGHbJl1Z0jum
         1d4+A3sW2YDpdPZ4S7e//DXoJ1c+124b9/7RJsbVW9RRLgn1dcIe+SEL4BJqUAkckqjo
         1DmU3HCqfqeWUv5WLgYjpNgfIObiaai0jqP0OAL+eqOtkKK1xhInyIHXNC/JOpuxFIx8
         WUwkJFfDVLQDvZdnJo6c/X39ns67C/DAlbSKWFVn6AAHSiwvFWyv16VRj2LfmDSLzo2M
         wQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRUzzoLYxlrhGNgxBbOH7Wf9YtHCiK8fKYwn8zs5y4E=;
        b=3CEu78qb7qCUaUFKXIpMgZoujl3IdNoNoOLCLC3QcoewpzBTtTmIq1Wf58+BPA55QS
         4DuCqaaxadpBz7kvSLQokgA/wjO2kPjtGq1C05UOXjzbjmlgDOUwMNdzuwGi0K10mOwp
         XIos8jPlp6h7GD/6lR8eSJQCbFZIZplCiG4M8pl1PgMgOiTqNkiPl4eCY/6ZKrwm+lTa
         D9V++kcRNIVwZA7cDeu67hcaepfvhS8cdoCXzjAd8FYI/4GFX3dWaCiTIlLpYM4RDfJq
         f1Yn65BsJ6FrLHe7Tftd7y9tVEUOJnbWP3FXS6Y+QBe8ag1XCo+jNkTPghN+BhbP9LKh
         U83w==
X-Gm-Message-State: AOAM533j++rRy7xQN7zmTcmaicFvKE4BhE2TgSTUmlk9BmoVWkd3a+/Q
        8otwoscGE2TXN6j3r1wuNnSGTzgd3ur0pTiGnxE=
X-Google-Smtp-Source: ABdhPJysRryK28CWGBwFmEnDVftwXkJv9OITYLzCkMDfLG4UIDevFjkLtOWjAsn27sxOHMi5eingh4MsAvEv0fIiHfI=
X-Received: by 2002:a9f:234a:: with SMTP id 68mr5685579uae.49.1643037347911;
 Mon, 24 Jan 2022 07:15:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642526745.git.khalid.aziz@oracle.com> <CANe_+UhrcQO0mwB2KJtm69+MDVJuD-r5Cbyqt8AkWdtfY55CCQ@mail.gmail.com>
 <ef356f12-5eef-a92e-a816-ab853f2d369a@oracle.com> <CANe_+Ui4x7xz_QtG1iXr6J3dbKyja3-T=2tTTg+yqsacrTUYNw@mail.gmail.com>
 <f0939948-51c4-eacb-0b20-dd31e0a8b92c@oracle.com>
In-Reply-To: <f0939948-51c4-eacb-0b20-dd31e0a8b92c@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Mon, 24 Jan 2022 15:15:36 +0000
Message-ID: <CANe_+Uiw1mSnFFBW3n5qBJ+V9EDaqY1PAEXFTXF9mkwM73x0-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 at 19:15, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 1/20/22 05:49, Mark Hemment wrote:
> > On Wed, 19 Jan 2022 at 17:02, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >>
> >> On 1/19/22 04:38, Mark Hemment wrote:
> >>> On Tue, 18 Jan 2022 at 21:20, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >>>>
> >>>> Page tables in kernel consume some of the memory and as long as
> >>>> number of mappings being maintained is small enough, this space
> >>>> consumed by page tables is not objectionable. When very few memory
> >>>> pages are shared between processes, the number of page table entries
> >>>> (PTEs) to maintain is mostly constrained by the number of pages of
> >>>> memory on the system. As the number of shared pages and the number
> >>>> of times pages are shared goes up, amount of memory consumed by page
> >>>> tables starts to become significant.
> >>>>
> >>>> Some of the field deployments commonly see memory pages shared
> >>>> across 1000s of processes. On x86_64, each page requires a PTE that
> >>>> is only 8 bytes long which is very small compared to the 4K page
> >>>> size. When 2000 processes map the same page in their address space,
> >>>> each one of them requires 8 bytes for its PTE and together that adds
> >>>> up to 8K of memory just to hold the PTEs for one 4K page. On a
> >>>> database server with 300GB SGA, a system carsh was seen with
> >>>> out-of-memory condition when 1500+ clients tried to share this SGA
> >>>> even though the system had 512GB of memory. On this server, in the
> >>>> worst case scenario of all 1500 processes mapping every page from
> >>>> SGA would have required 878GB+ for just the PTEs. If these PTEs
> >>>> could be shared, amount of memory saved is very significant.
> >>>>
> >>>> This is a proposal to implement a mechanism in kernel to allow
> >>>> userspace processes to opt into sharing PTEs. The proposal is to add
> >>>> a new system call - mshare(), which can be used by a process to
> >>>> create a region (we will call it mshare'd region) which can be used
> >>>> by other processes to map same pages using shared PTEs. Other
> >>>> process(es), assuming they have the right permissions, can then make
> >>>> the mashare() system call to map the shared pages into their address
> >>>> space using the shared PTEs.  When a process is done using this
> >>>> mshare'd region, it makes a mshare_unlink() system call to end its
> >>>> access. When the last process accessing mshare'd region calls
> >>>> mshare_unlink(), the mshare'd region is torn down and memory used by
> >>>> it is freed.
> >>>>
> >>>>
> >>>> API Proposal
> >>>> ============
> >>>>
> >>>> The mshare API consists of two system calls - mshare() and mshare_unlink()
> >>>>
> >>>> --
> >>>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
> >>>>
> >>>> mshare() creates and opens a new, or opens an existing mshare'd
> >>>> region that will be shared at PTE level. "name" refers to shared object
> >>>> name that exists under /sys/fs/mshare. "addr" is the starting address
> >>>> of this shared memory area and length is the size of this area.
> >>>> oflags can be one of:
> >>>>
> >>>> - O_RDONLY opens shared memory area for read only access by everyone
> >>>> - O_RDWR opens shared memory area for read and write access
> >>>> - O_CREAT creates the named shared memory area if it does not exist
> >>>> - O_EXCL If O_CREAT was also specified, and a shared memory area
> >>>>     exists with that name, return an error.
> >>>>
> >>>> mode represents the creation mode for the shared object under
> >>>> /sys/fs/mshare.
> >>>>
> >>>> mshare() returns an error code if it fails, otherwise it returns 0.
> >>>>
> >>>> PTEs are shared at pgdir level and hence it imposes following
> >>>> requirements on the address and size given to the mshare():
> >>>>
> >>>> - Starting address must be aligned to pgdir size (512GB on x86_64)
> >>>> - Size must be a multiple of pgdir size
> >>>> - Any mappings created in this address range at any time become
> >>>>     shared automatically
> >>>> - Shared address range can have unmapped addresses in it. Any access
> >>>>     to unmapped address will result in SIGBUS
> >>>>
> >>>> Mappings within this address range behave as if they were shared
> >>>> between threads, so a write to a MAP_PRIVATE mapping will create a
> >>>> page which is shared between all the sharers. The first process that
> >>>> declares an address range mshare'd can continue to map objects in
> >>>> the shared area. All other processes that want mshare'd access to
> >>>> this memory area can do so by calling mshare(). After this call, the
> >>>> address range given by mshare becomes a shared range in its address
> >>>> space. Anonymous mappings will be shared and not COWed.
> >>>>
> >>>> A file under /sys/fs/mshare can be opened and read from. A read from
> >>>> this file returns two long values - (1) starting address, and (2)
> >>>> size of the mshare'd region.
> >>>>
> >>>> --
> >>>> int mshare_unlink(char *name)
> >>>>
> >>>> A shared address range created by mshare() can be destroyed using
> >>>> mshare_unlink() which removes the  shared named object. Once all
> >>>> processes have unmapped the shared object, the shared address range
> >>>> references are de-allocated and destroyed.
> >>>>
> >>>> mshare_unlink() returns 0 on success or -1 on error.
> >>>>
> >>>>
> >>>> Example Code
> >>>> ============
> >>>>
> >>>> Snippet of the code that a donor process would run looks like below:
> >>>>
> >>>> -----------------
> >>>>           addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
> >>>>                           MAP_SHARED | MAP_ANONYMOUS, 0, 0);
> >>>>           if (addr == MAP_FAILED)
> >>>>                   perror("ERROR: mmap failed");
> >>>>
> >>>>           err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
> >>>>                           GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
> >>>>           if (err < 0) {
> >>>>                   perror("mshare() syscall failed");
> >>>>                   exit(1);
> >>>>           }
> >>>>
> >>>>           strncpy(addr, "Some random shared text",
> >>>>                           sizeof("Some random shared text"));
> >>>> -----------------
> >>>>
> >>>> Snippet of code that a consumer process would execute looks like:
> >>>>
> >>>> -----------------
> >>>>           fd = open("testregion", O_RDONLY);
> >>>>           if (fd < 0) {
> >>>>                   perror("open failed");
> >>>>                   exit(1);
> >>>>           }
> >>>>
> >>>>           if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
> >>>>                   printf("INFO: %ld bytes shared at addr %lx \n",
> >>>>                                   mshare_info[1], mshare_info[0]);
> >>>>           else
> >>>>                   perror("read failed");
> >>>>
> >>>>           close(fd);
> >>>>
> >>>>           addr = (char *)mshare_info[0];
> >>>>           err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
> >>>>                           mshare_info[1], O_RDWR, 600);
> >>>>           if (err < 0) {
> >>>>                   perror("mshare() syscall failed");
> >>>>                   exit(1);
> >>>>           }
> >>>>
> >>>>           printf("Guest mmap at %px:\n", addr);
> >>>>           printf("%s\n", addr);
> >>>>           printf("\nDone\n");
> >>>>
> >>>>           err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
> >>>>           if (err < 0) {
> >>>>                   perror("mshare_unlink() failed");
> >>>>                   exit(1);
> >>>>           }
> >>>> -----------------
> >>> ...
> >>> Hi Khalid,
> >>>
> >>> The proposed mshare() appears to be similar to POSIX shared memory,
> >>> but with two extra (related) attributes;
> >>> a) Internally, uses shared page tables.
> >>> b) Shared memory is mapped at same address for all users.
> >>
> >> Hi Mark,
> >>
> >> You are right there are a few similarities with POSIX shm but there is one key difference - unlike shm, shared region
> >> access does not go through a filesystem. msharefs exists to query mshare'd regions and enforce access restrictions.
> >> mshare is meant to allow sharing any existing regions that might map a file, may be anonymous or map any other object.
> >> Any consumer process can use the same PTEs to access whatever might be mapped in that region which is quite different
> >> from what shm does. Because of the similarities between the two, I had started a prototype using POSIX shm API to
> >> leverage that code but I found myself special casing mshare often enough in shm code that it made sense to go with a
> >> separate implementation.
> >
> > Ah, I jumped in assuming this was only for anon memory.
> >
> >> I considered an API very much like POSIX shm but a simple mshare() syscall at any time to share
> >> a range of addresses that may be fully or partially mapped in is a simpler and more versatile API.
> >
> > So possible you have already considered the below...which does make
> > the API a little more POSIX shm like.
> >
> > The mshare() syscall does two operations;
> > 1) create/open mshare object
> > 2) export/import the given memory region
> >
> > Would it be better if these were seperate operations?  That is,
> > mshare_open() (say) creates/opens the object returning a file
> > descriptor.  The fd used as the identifier for the export/import after
> > mmap(2); eg.
> > addr = mshare_op(EXPORT, fd, addr, size);
> > addr = mshare_op(IMPORT, fd, NULL, 0);
> > (Not sure about export/import terms..)
> >
> > The benefit of the the separate ops is the file descriptor.  This
> > could be used for fstat(2) (and fchown(2)?), although not sure how
> > much value this would add.
>
> Hi Mark,
>
> That is the question here - what would be the value of fd to mshare_op? The file in msharefs can be opened like a
> regular file and supports fstat, fchown etc which can be used to query/set permissions for the mshare'd region.

Hi Khalid,

In your proposed API, the 'importer' of the mshared region does not
open the mshared backing object (when a file being mapped) instead it
does an open on the msharefs file.
From the code sample in your initial email (simplified), where a
process attaches to the mshared region;
    fd = open("testregion", O_RDONLY);
    read(fd, &mshare_info, sizeof (mshare_info));
    mshare("testregion", addr, len, RDWR, 0600);

Open permission checks are done by the mshare() system call against
the msharefs file ("testregion").

From the code sample in your initial email (simplified), where a
process creates a msharefs file with the anonymous mmap()ed region to
be shared;
    addr = mmap(RDWR, ANON);
    mshare("testregion", addr, len, CREAT|RDWR|EXCL, 0600);

Now, consider the case where the mmap() is named (that is, against a
file).  I believe this is the usecase for Oracle's SGA.
My (simplified) code for msharing a named file ("SGA") using your
proposed API (does not matter if the mapping is PRIVATE or SHARED);
    fd = open("SGA", RDWR);
    addr = mmap(RDWR, ..., fd);
    mshare("SGA-region", addr, len, CREAT|RDWR|EXCL, 0600);

If the permissions (usr/grp+perms+ACL) between the "SGA" file and the
"SGA-region" msharefs are different, then it is very likely a serious
security issue.
That is, a user who could not open(2) the "SGA" file might be able to
open the "SGA-region" msharefs file, and so gain at least read
permission on the file.

This is why I was proposing a file descriptor, so the msharefs file
could be set to have the same permissions as the backing file it is
exporting (but I got this wrong).
This would still leave a window between the msharefs file being
creating and the permissions being set, where a rogue process could
attach to a region when they should not have the permission (this
could be closed by failing a non-creating mshare() if the region is of
zero len - nothing yet shared - until permission are set and the
region shared).
But relying on userspace to always set the correct permissions on the
msharefs file is dangerous - likely to get it wrong on occasion - and
isn't sufficient.  The msharefs API needs to be bullet proof.

Looking at the patches, I cannot see where extra validation is being
done for a named mapping to ensure any 'importer' has the necessary
permission against the backing file.
The 'struct file' (->vm_file, and associated inode) in the VMA is
sufficient to perform required access checks against the file's perms
- the posted patches do not check this (but they are for an RFC, so
don't expect all cases to be handled).  But what about a full path
permission check?  That is, the 'importer' has necessary permissions
on the backing file, but would not be able to find this file due to
directory permissions?  msharefs would bypass the directory checks.


> >
> > The 'importer' would use the address/size of the memory region as
> > exported (and stored in msharefs), so no need for /sys file (except
> > for human readable info).
>
> I think we still need /sys/fs/msharefs files, right? Since you said msharefs stores information about address and size,
> I assume you are not proposing eliminating msharefs.

The 'exporter' of the mshared region specifies the address and length,
and is therefore is known by the mshare code.
An 'import' needs to only pass NULL/0 for addr/len and is told by
mshare where the region has been attached in its address-space.  With
this, the /sys file is no longer part of the API.


> >
> > If the set-up operations are split in two, then would it make sense to
> > also split the teardown as well?  Say, mshare_op(DROP, fd) and
> > mshare_unlink(fd)?
>
> A single op is simpler. Every process can call mshare_unlink() and if last reference is dropped, kernel should take care
> of cleaning up mshare'd region by itself. One of my goals is for mshare to continue to work even if the process that
> created the mshare region dies. In a database context, such mshare'd regions can live for very long time. As a result I
> would rather not make any process be responsible for cleaning up the mshare'd region. It should be as simple as the
> mshare'd region disappearing on its own when all references to it are dropped.
>
> Thanks,
> Khalid

Cheers,
Mark

>
> >
> >>
> >> Does that rationale sound reasonable?
> >
> > It doesn't sound unreasonable.  As msharefs is providing a namespace
> > and perms, it doesn't need much flexibility.  Being able to modifying
> > the perms post namespace creation (fchown(2)), before exporting the
> > memory region, might be useful in some cases - but as I don't have any
> > usecases I'm not claiming it is essential.
> >
> >>
> >> Thanks,
> >> Khalid
> >
> > Cheers,
> > Mark
> >>
> >>>
> >>> Rather than introduce two new system calls, along with /sys/ file to
> >>> communicate global addresses, could mshare() be built on top of shmem
> >>> API?  Thinking of something like the below;
> >>> 1) For shm_open(3), add a new oflag to indicate the properties needed
> >>> for mshare() (say, O_SHARED_PTE - better name?)
> >>> 2) For ftruncate(2), objects created with O_SHARED_PTE are constrained
> >>> in the sizes which can be set.
> >>> 3) For mmap(2), NULL is always passed as the address for O_SHARED_PTE
> >>> objects.  On first mmap()ing an appropiate address is assigned,
> >>> otherwise the current 'global' address is used.
> >>> 4) shm_unlink(3) destroys the object when last reference is dropped.
> >>>
> >>> For 3), might be able to weaken the NULL requirement and validate a
> >>> given address on first mapping to ensure it is correctly aligned.
> >>> shm_open(3) sets FD_CLOEXEC on the file descriptor, which might not be
> >>> the default behaviour you require.
> >>>
> >>> Internally, the handling of mshare()/O_SHARED_PTE memory might be
> >>> sufficiently different to shmem that there is not much code sharing
> >>> between the two (I haven't thought this through, but the object
> >>> naming/refcounting should be similiar), but using shmem would be a
> >>> familiar API.
> >>>
> >>> Any thoughts?
> >>>
> >>> Cheers,
> >>> Mark
> >>>
> >>
>
