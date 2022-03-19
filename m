Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED81E4DE7CE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 13:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbiCSMP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiCSMP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 08:15:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E792710
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647692067;
        bh=L9gQIAMbN+V9GevRugsHOEP8kZm7fCQRXiGNeNH5ZUE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gRhKifDoUUe1SBUDq9fPIi4CnfD38BkgcQ8hEQk4kAP09qPM8v0qfldOQlTKt3cmm
         p2BNjPX4ZsARo8PKr3K02rQG2+fOUBWQ5KFEdawTx0f2h6wx4RP14KjMGVt1ZxNPXW
         pWIpXfuWoa1O5wQIIn/ZLjAgixQHdTNLvIHGkzUM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.141.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUqL-1nO9a01XNX-00CzbR; Sat, 19
 Mar 2022 13:14:27 +0100
Message-ID: <089e25bb-805d-81ac-2f91-69f03c716b0d@gmx.de>
Date:   Sat, 19 Mar 2022 13:12:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [deller-parisc:for-next 23/24] include/linux/jump_label.h:266:16:
 error: implicit declaration of function 'atomic_read'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202203191125.4vT2F6La-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202203191125.4vT2F6La-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kkOXtj/FYF8DN/1oSHRkrPA4wYNa4MlQgVD3bhzcmGg04knsS1p
 29Kkvp9xST/d8r7ZFSUM2O274eo0fI4pkK5zMIjnAYLiiTZKrwkmrvb8rsue4Db62kDEXsx
 U5QVZrpaWPVHUyuMYNDoiHJMvNLWK3FXuCyoXsU7CUn7dGekqzP/1r4L2O6ODV/bK2928cz
 gUI0b01XWvZNLf/6ZY8dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fUfJEZzc4KY=:Tjn7Txf50fKA/1Yj33KAKd
 XXHkJBmWhMBhfbNqDnoDSQ7DZtGMCRcjt8aVhss7+Gc4Ui8wbP2m51Glek0gKsnhKHWWYo7U4
 Ry5Egvavsa7NMf7fFQxlXNxhhmwkeYI82t/JvlzCg/1w6AJ75n/l/7g4TFjtOzdvnD8cNIYK+
 78fDgWMwxSztLZSIyUXrVWTelI7tJF+pBtGEzyrzQtA+plCLk4qliPlyO3hqPEJl5a8uUyidV
 XyXdzcm5z4VR3F1PVzk0Pj/J4iZrQIDRr6fiKcI/vzFLsRyj0fqmHW4Gjw/sCDiNj9WlXjHtx
 B8jsamug4dKmTqViJKXN1bpTk9BnWscgc7M+pqkDLF5fxFYqJqA14GnKXYJSGB4zG7T/jBQns
 yK8GKi+NQMIwAqPi7rGEGXvzTZZWnn4Z2gs640NHY7aapjj7SqndIfL/+H4YXo9UailaUMWND
 m0SWLPwvF2qlYvR0nyufrBNNrAPA5akct8mVIuqHuMMBShcrHG6f07/tiA5qm0OqomfRzedI8
 s7/PBB2LGJRdPeNT6QcMM4Iq7WCJy6azSdxiDGITyqc3W5k9kzWxj3W2gWuOFk0D4LUALriOM
 dL4PM0kI0ofJO8XdoZpNFlhkIARkEagcgBsTXoIVkLCk8BMdOxMrndsLlcADJc/wRnf7B6BAL
 H7BrimJipCNG2w8saiTQqu9B/iAXBDj2HD1m2g8DZhBK3COGVtZuoSFyFJYC1wGBWQF1WoiHe
 hWyf35TCxqQGtjGrWmrSMzqRT2BUpC1SIxGSqW37DOWP1N7zEObOaiCL8YdRiaXf3zaM0Kslf
 Rd6hAJXFUTSoQv2S6g411GcG7gYPGAGfwIFiXMoxBE0LAiEntq9fj35h1wbvJS0sgHp+hiUlU
 00ckim6cIoUs8tmhAsxP8oCLPXYkOmcBSfSy/ot3y89BHNbwiHZ9LghxZjWknppmzMMlYDIWE
 DLJrW/UixoEfc3m8SFexvfJvayYF0fl5O3hO0G26TU3Pgw7yCu068Gi0qHvIUkj2eZuINIT1L
 fo77vkGdqPWhrTN81d5rwo3CvwxalRUpnAfde9IK93c/Y6rkW3cTtYugNYTE/t+ngg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/22 04:38, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-li=
nux.git for-next
> head:   ca3ee5ad86cc1b9553d5bd6878957ad8c79dfb4a
> commit: 0acfd47aee46a4dc7aedcc6470d52c35bf0a836c [23/24] parisc: Convert=
 parisc_requires_coherency() to static branch
> config: parisc-defconfig (https://download.01.org/0day-ci/archive/202203=
19/202203191125.4vT2F6La-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-=
linux.git/commit/?id=3D0acfd47aee46a4dc7aedcc6470d52c35bf0a836c
>         git remote add deller-parisc https://git.kernel.org/pub/scm/linu=
x/kernel/git/deller/parisc-linux.git
>         git fetch --no-tags deller-parisc for-next
>         git checkout 0acfd47aee46a4dc7aedcc6470d52c35bf0a836c
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc prepare
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from arch/parisc/include/asm/processor.h:14,
>                     from arch/parisc/include/asm/spinlock.h:7,
>                     from arch/parisc/include/asm/atomic.h:22,
>                     from include/linux/atomic.h:7,
>                     from arch/parisc/include/asm/bitops.h:13,
>                     from include/linux/bitops.h:33,
>                     from include/linux/kernel.h:22,
>                     from arch/parisc/include/asm/bug.h:5,
>                     from include/linux/bug.h:5,
>                     from include/linux/page-flags.h:10,
>                     from kernel/bounds.c:10:
>    include/linux/jump_label.h: In function 'static_key_count':
>>> include/linux/jump_label.h:266:16: error: implicit declaration of func=
tion 'atomic_read' [-Werror=3Dimplicit-function-declaration]
>      266 |         return atomic_read(&key->enabled);

Thanks, fixed now in for-next.

Helge
