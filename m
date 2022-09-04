Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012DC5AC404
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiIDKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiIDKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:52:51 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B426940E17;
        Sun,  4 Sep 2022 03:52:49 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oUnFA-0006pA-8I; Sun, 04 Sep 2022 12:52:48 +0200
Message-ID: <c558a247-4d12-daf6-f475-526eaaf3e700@leemhuis.info>
Date:   Sun, 4 Sep 2022 12:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     lkp@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org
References: <20220823012849.GA57011@inn2.lkp.intel.com>
 <db909f88-3f5c-afc8-424c-ced3f371037f@intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [xfs] 1aa91d9c99: xfstests.generic.471.fail
In-Reply-To: <db909f88-3f5c-afc8-424c-ced3f371037f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662288769;bebdfc6f;
X-HE-SMSGID: 1oUnFA-0006pA-8I
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

As per recent general discussions with the 0-day folks, I'm dropping
below regression from the list of tracked issues, as this report didn't
gain any traction. That for example can happen if the developers
considered the regression of no practical relevance, as they assume it
only materializes in micro-benchmarks, is due to a broken test case, or
some fluke.

Not sure if that or something else is the reason why this particular
report  didn't gain any traction, but I lack the bandwidth to follow-up
on each and every regression some CI system found and reported. At the
same time I don't want to keep these reports in the list of tracked
issues forever, as that creates noise and makes it harder to spot the
important issues in regzbot's reports and lists. That's why I hereby
remove it:

#regzbot invalid: 0-day report that didn't get traction; might be of no
relevance

Ciao, Thorsten

On 23.08.22 03:39, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 1aa91d9c993397858a50c433933ea119903fdea2 ("xfs: Add async
> buffered write support")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: xfstests
> version: xfstests-x86_64-c1144bf-1_20220808
> with following parameters:
> 
>     disk: 4HDD
>     fs: xfs
>     test: generic-group-23
>     ucode: 0xf0
> 
> test-description: xfstests is a regression test suite for xfs and other
> files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz
> (Skylake) with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> generic/471       - output mismatch (see
> /lkp/benchmarks/xfstests/results//generic/471.out.bad)
>     --- tests/generic/471.out    2022-08-08 17:00:46.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/471.out.bad   
> 2022-08-22 16:16:45.895663503 +0000
>     @@ -2,12 +2,10 @@
>      pwrite: Resource temporarily unavailable
>      wrote 8388608/8388608 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -RWF_NOWAIT time is within limits.
>     +pwrite: Resource temporarily unavailable
>     +(standard_in) 1: syntax error
>     +RWF_NOWAIT took  seconds
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/471.out
> /lkp/benchmarks/xfstests/results//generic/471.out.bad'  to see the
> entire diff)
> 
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/disk/fs/test/ucode:
>  
> lkp-skl-d06/xfstests/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/4HDD/xfs/generic-group-23/0xf0
> 
> commit:
>   9641506b2deed1 ("xfs: Specify lockmode when calling
> xfs_ilock_for_iomap()")
>   1aa91d9c993397 ("xfs: Add async buffered write support")
> 
> 9641506b2deed1bb 1aa91d9c993397858a50c433933
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6           33%           2:2     xfstests.generic.471.fail
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <yujie.liu@intel.com>
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached
> in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file
> for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> #regzbot introduced: 1aa91d9c99
> 
