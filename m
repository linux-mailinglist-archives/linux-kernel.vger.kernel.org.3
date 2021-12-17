Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB904794C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbhLQT0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:26:55 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:58384 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbhLQT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:26:53 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:60264)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1myIsU-003GVL-G5; Fri, 17 Dec 2021 12:26:50 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:43512 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1myIsT-004Mxi-0v; Fri, 17 Dec 2021 12:26:50 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
Date:   Fri, 17 Dec 2021 13:26:41 -0600
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com> (Mike
        Christie's message of "Mon, 29 Nov 2021 13:46:57 -0600")
Message-ID: <87tuf79gni.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1myIsT-004Mxi-0v;;;mid=<87tuf79gni.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX180LvusV5/qqDk8bOZub2tqU2IJcgsy1HU=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 655 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.4%), parse: 1.14 (0.2%),
         extract_message_metadata: 22 (3.3%), get_uri_detail_list: 3.4 (0.5%),
        tests_pri_-1000: 30 (4.5%), tests_pri_-950: 1.40 (0.2%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 130 (19.8%), check_bayes:
        124 (19.0%), b_tokenize: 11 (1.7%), b_tok_get_all: 14 (2.1%),
        b_comp_prob: 4.0 (0.6%), b_tok_touch_all: 90 (13.8%), b_finish: 1.02
        (0.2%), tests_pri_0: 442 (67.4%), check_dkim_signature: 0.90 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.83 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 11 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> The following patches made over Linus's tree, allow the vhost layer to do
> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
> io_uring does a copy_process against its userspace app. This allows the
> vhost layer's worker threads to inherit cgroups, namespaces, address
> space, etc and this worker thread will also be accounted for against that
> owner/parent process's RLIMIT_NPROC limit.
>
> If you are not familiar with qemu and vhost here is more detailed
> problem description:
>
> Qemu will create vhost devices in the kernel which perform network, SCSI,
> etc IO and management operations from worker threads created by the
> kthread API. Because the kthread API does a copy_process on the kthreadd
> thread, the vhost layer has to use kthread_use_mm to access the Qemu
> thread's memory and cgroup_attach_task_all to add itself to the Qemu
> thread's cgroups.
>
> The problem with this approach is that we then have to add new functions/
> args/functionality for every thing we want to inherit. I started doing
> that here:
>
> https://lkml.org/lkml/2021/6/23/1233
>
> for the RLIMIT_NPROC check, but it seems it might be easier to just
> inherit everything from the beginning, becuase I'd need to do something
> like that patch several times.

I read through the code and I don't see why you want to make these
almost threads of a process not actually threads of that process
(like the io_uring threads are).

As a separate process there are many things that will continue to be
disjoint.  If the thread changes cgroups for example your new process
won't follow.

If you want them to be actually processes with an lifetime independent
of the creating process I expect you want to reparent them to the local
init process.  Just so they don't confuse the process tree.  Plus init
processes know how to handle unexpected children.

What are the semantics you are aiming for?

I can see sense in generalizing some of the pieces of create_io_thread
but I think generalizing create_io_thread itself is premature.  The code
lives in kernel/fork.c because it is a very special thing that we want
to keep our eyes on.

Some of your generalization makes it much more difficult to tell what
your code is going to use because you remove hard codes that are there
to simplify the analysis of the situation.

My gut says adding a new create_vhost_worker and putting that in
kernel/fork.c is a lot safer and will allow much better code analysis.

If there a really are commonalities between creating a userspace process
that runs completely in the kernel and creating an additional userspace
thread we refactor the code and simplify things.

I am especially nervous about generalizing the io_uring code as it's
signal handling just barely works, and any generalization will cause it
to break.  So you are in the process of generalizing code that simply
can not handle the general case.  That scares me.

Eric

>
> V6:
> - Rename kernel_worker to user_worker and fix prefixes.
> - Add better patch descriptions.
> V5:
> - Handle kbuild errors by building patchset against current kernel that
>   has all deps merged. Also add patch to remove create_io_thread code as
>   it's not used anymore.
> - Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
>   case added in 5.16-rc1.
> - Add PF_USER_WORKER flag so we can check it later after the initial
>   thread creation for the wake up, vm and singal cses.
> - Added patch to auto reap the worker thread.
> V4:
> - Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
> - Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
>   added the new kernel worker functions.
> - Fixed extra "i" issue.
> - Added PF_USER_WORKER flag and added check that kernel_worker_start users
>   had that flag set. Also dropped patches that passed worker flags to
>   copy_thread and replaced with PF_USER_WORKER check.
> V3:
> - Add parentheses in p->flag and work_flags check in copy_thread.
> - Fix check in arm/arm64 which was doing the reverse of other archs
>   where it did likely(!flags) instead of unlikely(flags).
> V2:
> - Rename kernel_copy_process to kernel_worker.
> - Instead of exporting functions, make kernel_worker() a proper
>   function/API that does common work for the caller.
> - Instead of adding new fields to kernel_clone_args for each option
>   make it flag based similar to CLONE_*.
> - Drop unused completion struct in vhost.
> - Fix compile warnings by merging vhost cgroup cleanup patch and
>   vhost conversion patch.
> ~                              
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
