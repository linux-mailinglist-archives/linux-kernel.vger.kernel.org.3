Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5B535D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350593AbiE0Ja2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiE0JaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:30:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611B81059C8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:30:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED58C1F967;
        Fri, 27 May 2022 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653643820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=lChZ3kfPqOiQIGBbbKOf5O0euzOQVluYptAu5MuJjmI=;
        b=Lo4mTgACrwbxXdGNT/W10C9bRQnbNP+3IlsK9S1gaGC4gYgwKOAGx7aJrbbO+XzDJUpEgJ
        ESqo0OC2Rnax6bZ0QWWjN+IF5oWVwFL5TcHbEYoTJZWxMYFA57j6yRm0dIZhw2Lsb0bHyh
        jhQuxFQ5wORG0yc3kjNZwgd2nTS99NI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653643820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=lChZ3kfPqOiQIGBbbKOf5O0euzOQVluYptAu5MuJjmI=;
        b=XpHwPSiLRvXuW5MIh3rkqaUQURfvmJ0ulgL1CAoHYh410ePKZcojrFZ037MTuqbAefw3rI
        QQlIOqi+A5+pbUBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CA7F139C4;
        Fri, 27 May 2022 09:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QNCiJCyakGK1VAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 27 May 2022 09:30:20 +0000
Date:   Fri, 27 May 2022 11:32:27 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     lwn@lwn.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [ANNOUNCE] The Linux Test Project has been released for MAY 2022 
Message-ID: <YpCaq7VEb6d5HPBF@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news everyone,

the Linux Test Project test suite stable release for *May 2022* has been
released.

Since the last release 298 patches by 25 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests
  - kvm_pagefault01: aka CVE-2021-38198
  - fcntl39: test for DN_RENAME (dnotify)
  - io_control01: first cgroup IO controller test
  - keyctl09: test encrypted keys with provided decrypted data
  - memcontrol03, memcontrol04: tests that cgroup memory is partitioned correctly under pressure
  - setsockopt09: regression test for use-after-free in prb_retire_rx_blk_timer_expired()
  - setsockopt09: regression test for double free of rx_owner_map aka CVE-2021-22600
  - pty07: regression test for use-after-free in vt_ioctl()
  - pty06: regression test for VT_DISALLOCATE freeing in-use virtual console
  - pidfd_getfd01 basic functional test
  - pidfd_getfd02 basic error test
  - pidfd_open04 test with PIDFD_NONBLOCK flag
  - futex_waitv01 error tests
  - futex_waitv02 basic functional test with private memory
  - futex_waitv03 basic functional test with shared memory
  - inotify11: test opening files after receiving IN_DELETE
               regression test for a37d9a17f099 (fsnotify: invalidate dcache before IN_DELETE event)
  - statx09 test for STATX_ATTR_VERITY
  - wqueue09 tests WATCH_META_LOSS_NOTIFICATION event
  - wqueue08 tests WATCH_META_REMOVAL_NOTIFICATION event
  - wqueue07 tests NOTIFY_KEY_SETATTR event
  - wqueue06 tests NOTIFY_KEY_CLEARED event
  - wqueue05 tests NOTIFY_KEY_INVALIDATED event
  - wqueue04 tests NOTIFY_KEY_LINKED event
  - wqueue03 tests NOTIFY_KEY_REVOKED event
  - wqueue02 tests NOTIFY_KEY_UNLINKED event
  - wqueue01 tests NOTIFY_KEY_UPDATED event

* Increased coverage
  - fanotify14, fanotify16: Add tests for FAN_REPORT_TARGET_FID and FAN_RENAME
  - futex_waitv01: Add test verifies EINVAL for invalid nr_futexes
  - getcontext01: Test rewritten so that it actually jumps back
  - fstat02: Validate st_nlink as well
  - sched_get_priority_max01, sched_get_priority_min01: Add missing policies

* KVM library was written for LTP
  - a simple library that can spin up a VM and execute payload
  - see also https://github.com/linux-test-project/ltp/wiki/KVM-Test-API

* The concept of test runtime was introduced
  - for details see https://people.kernel.org/metan/test-timeout-and-runtime

* Removed tests
  - syslog tests as these were testing mostly userspace syslog daemon
    and were broken for most of the syslog daemon implementations

* The test library was fixed to terminate all leftover processes in the case
  that the main test process dies or exits

* New sparse check for {} terminator for struct arrays in tst_test has been
  implemented

* Shell library improvements
  - added support for $TST_FORMAT_DEVICE (.format_device in C API)
  - preparations for shell API get support for testing on all filesystems (.all_filesystems in C API)
  - getopts cleanup and changes how is the library sources,
    which resulted in much simpler library code

* Userns tests were rewritten into the new test API

* Mountns tests were rewritten into the new test API

* 33 tests were rewritten to the new library

+ The usual amount of fixes and cleanups

WHAT IS IN THE QUEUE
====================

In-flight patches include:

- CGroup shell test rewrite that should fix many problems


NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

* Several fixes (e.g. important nfs_lib: Fix fsid randomisation)

* Ongoing discussion where should be SCTP testsuite home


DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20220527

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

https://github.com/linux-test-project/ltp/wiki/C-Test-API

https://github.com/linux-test-project/ltp/wiki/C-Test-Network-API

https://github.com/linux-test-project/ltp/wiki/Shell-Test-API

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.

CREDITS
=======

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20220121..

    72  Petr Vorel <pvorel@suse.cz>
    51  Cyril Hrubis <chrubis@suse.cz>
    42  Andrea Cervesato <andrea.cervesato@suse.de>
    22  Li Wang <liwang@redhat.com>
    21  Richard Palethorpe <rpalethorpe@suse.com>
    17  Martin Doucha <mdoucha@suse.cz>
    15  Yang Xu <xuyang2018.jy@fujitsu.com>
    10  Jan Stancek <jstancek@redhat.com>
    10  Zhao Gongyi <zhaogongyi@huawei.com>
     7  Amir Goldstein <amir73il@gmail.com>
     6  Dai Shili <daisl.fnst@fujitsu.com>
     6  Bogdan Lezhepekov <blezhepekov@suse.de>
     4  tangmeng <tangmeng@uniontech.com>
     2  Chunyu Hu <chuhu@redhat.com>
     2  Kushal Chand <kushalkataria5@gmail.com>
     2  xiaoshoukui <xiaoshoukui@ruijie.com.cn>
     1  Alexander Ivanov <alexander.ivanov@virtuozzo.com>
     1  Alexander Kanavin <alex@linutronix.de>
     1  Andrea Arcangeli <aarcange@redhat.com>
     1  Edward Liaw via ltp <ltp@lists.linux.it>
     1  Fabrice Fontaine <fontaine.fabrice@gmail.com>
     1  Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
     1  Wang Kunfeng via ltp <ltp@lists.linux.it>
     1  Yael Tzur via ltp <ltp@lists.linux.it>
     1  ihsinme <ihsinme@gmail.com>

And also thanks to patch reviewers:

git log 20220121.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    148 Cyril Hrubis <chrubis@suse.cz>
    105 Petr Vorel <pvorel@suse.cz>
     73 Li Wang <liwang@redhat.com>
     21 Yang Xu <xuyang2018.jy@fujitsu.com>
     17 Richard Palethorpe <rpalethorpe@suse.com>
     10 Martin Doucha <mdoucha@suse.cz>
      6 Jan Stancek <jstancek@redhat.com>
      1 Waiman Long <longman@redhat.com>
      1 Jan Kara <jack@suse.cz>
      1 Gabriel Krisman Bertazi <krisman@collabora.com>
      1 Andrea Cervesato <andrea.cervesato@suse.de>
      1 Alexey Kodanev <aleksei.kodanev@bell-sw.com>

-- 
Cyril Hrubis
chrubis@suse.cz
