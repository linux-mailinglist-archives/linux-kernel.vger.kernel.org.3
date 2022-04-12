Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4347E4FEB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiDLXhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiDLXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:33:24 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A31DCB035;
        Tue, 12 Apr 2022 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1649795811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WIUxSILGoa621kLouaI9IDPNclUbXv2ynq7QIv21bM=;
        b=KFFNZN2iWcO1Y/CgUgrQ92KJQL0qEbb0Fe5iFrZevng+xVaPFf65uhtUVRIwgJ1vCeGWfc
        bHQz9/6w3ZeJ0Bq8xb+3tuLec/a3bIs1nHidAFsnpOaVgZgkIc4zKf28PE569yMc9855xC
        9+eoe7ZCWKx99x6/Cdsx0Dozpf81MtVcu96R/eqdLhJ87wlHSkf9z/LPTtiBtqIoVk32Ok
        irjI2cTn1zPwvX8LIwhnfxW9r6xaLY+77I4j7lAsTiGQkZ0HEg1Wxi+HJcCM0/POpiua7m
        quReXUCno71MBKkrfCOnTKPcU6sniMeHw86pTBGahsErW0R5L6a5V9kmZ0GWILdjxTDiau
        AyqTlzYUZslQiQ2rIQhPfsRjlfa2YHZpReonqrJMDEue/2ArJVkidjeOgEPkBs9h4Psf2P
        BhSfRwKCMfzEnEo0ll5QOo78GyweCrqIMQrPK0RkZd5t9tEEbZAgMMqjo/UFhqNhpYFDTu
        rcHJJvCOWamUt4OzlK2MjNegYjpKV4jiXey2PFCsLn3hcxm2Gn6nKj0SrDX9Jo8LKl6KAw
        A3dQfSBJ/46+oGlEDq4xWHL0+FkgUdCvwa3l5hdABoac5/cyhbUA+Qr1IXJLmM3t0TvMeE
        TGRg8pcFYPQBdC1rER+jCxqfV0gyhEuU9s4QyOaNcj5o8fWuS16XU=
Received: from hp-amd-paul (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 247ba27f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 12 Apr 2022 20:36:51 +0000 (UTC)
Date:   Tue, 12 Apr 2022 15:36:47 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [crypto]  8505b026c9: hwsim.fils_sk_hlp_oom.fail
Message-ID: <YlXi3wmj30rM258J@hp-amd-paul>
References: <20220326172051.14722-1-thepaulodoom@thepaulodoom.com>
 <20220411103421.GC21954@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411103421.GC21954@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 06:34:21PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 8505b026c91a3e6d6c562a1fe46c2b8c20835de8 ("[PATCH] crypto: aes_generic: fixed styling warnings")

According to the following emails, it was agreed to drop this patch:
https://lore.kernel.org/linux-crypto/CAMj1kXHCR1nD24WDnYpD4Nu23x9+hw+=7EXOpq7y7m9LDk2J0w@mail.gmail.com/
https://lore.kernel.org/linux-crypto/20220328125137.bsbvroyxcjw6rl5m@hp-amd-paul/

Regards,
Paul

> url: https://github.com/intel-lab-lkp/linux/commits/Paul-Lemmermann/crypto-aes_generic-fixed-styling-warnings/20220327-014837
> base: https://git.kernel.org/cgit/linux/kernel/git/herbert/cryptodev-2.6.git master
> patch link: https://lore.kernel.org/linux-crypto/20220326172051.14722-1-thepaulodoom@thepaulodoom.com
> 
> in testcase: hwsim
> version: hwsim-x86_64-717e5d7-1_20220325
> with following parameters:
> 
> 	test: group-36
> 	ucode: 0x21
> 
> 
> 
> on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> 
> 2022-04-07 14:59:07 ./run-tests.py fils_sk_hlp_oom
> DEV: wlan0: 02:00:00:00:00:00
> DEV: wlan1: 02:00:00:00:01:00
> DEV: wlan2: 02:00:00:00:02:00
> APDEV: wlan3
> APDEV: wlan4
> START fils_sk_hlp_oom 1/1
> Test: FILS SK HLP and hostapd OOM
> Starting AP as-erp
> Starting AP wlan3 (old add_ap argument type)
> Connect STA wlan0 to AP
> Connection timed out
> Traceback (most recent call last):
>   File "./run-tests.py", line 531, in main
>     t(dev, apdev, params)
>   File "/lkp/benchmarks/hwsim/tests/hwsim/test_fils.py", line 919, in test_fils_sk_hlp_oom
>     dev[0].wait_connected()
>   File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 1411, in wait_connected
>     raise Exception(error)
> Exception: Connection timed out
> FAIL fils_sk_hlp_oom 10.282646 2022-04-07 14:59:18.241254
> passed 0 test case(s)
> skipped 0 test case(s)
> failed tests: fils_sk_hlp_oom
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
