Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B234D6703
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiCKRDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbiCKRDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:03:31 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE6EBD2C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:02:26 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KFXKs09F4z9sSC;
        Fri, 11 Mar 2022 18:02:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3tJ2Pqa3JuzL; Fri, 11 Mar 2022 18:02:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KFXKr6Pfnz9sSB;
        Fri, 11 Mar 2022 18:02:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C82728B78F;
        Fri, 11 Mar 2022 18:02:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id M0zNjWjTw6RX; Fri, 11 Mar 2022 18:02:24 +0100 (CET)
Received: from [192.168.202.87] (unknown [192.168.202.87])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 306BA8B763;
        Fri, 11 Mar 2022 18:02:24 +0100 (CET)
Message-ID: <e3a464d0-541a-0f7b-91de-79a446a4ee80@csgroup.eu>
Date:   Fri, 11 Mar 2022 18:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 0/8] reduce memory consumption for powerpc
 firmware-assisted capture kernel
Content-Language: fr-FR
To:     Hari Bathini <hbathini@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Ankit Kumar <ankit@linux.vnet.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/11/2017 à 16:16, Hari Bathini a écrit :
> I posted the initial version [1] of patchset [2] adding support to enforce
> additional parameters when firmware-assisted dump capture kernel is active.
> Michal reposted it with few improvements to parameter processing to make
> it more robust. He further posted patchset [3] with few more improvements.
> 
> This patch series clubs the work from these two patch-sets while segregating
> the generic and arch-specific code to ease the review process.
> 
> [1] http://patchwork.ozlabs.org/patch/758176/
> [2] http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=2733
> [3] http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3338
> 

Hello,

We still have this series flagged as "new" in powerpc's patchwork.

It is still of interest ?

Patch 1 applies but patch 2 hardly conflicts in init/main.c

So I'll flag it as "change requested", fell free to resubmit if still 
relevant.

Or if you think that's still required but don't plan to handle it, tell 
me and I'll open an issue in our issue board so that we don't loose history.

Thanks
Christophe


> ---
> 
> Hari Bathini (2):
>        powerpc/fadump: reduce memory consumption for capture kernel
>        powerpc/fadump: update documentation about 'fadump_extra_args=' parameter
> 
> Michal Suchanek (6):
>        lib/cmdline.c: remove quotes symmetrically
>        boot/param: add pointer to current and next argument to unknown parameter callback
>        lib/cmdline.c: add backslash support to kernel commandline parsing
>        Documentation/admin-guide: backslash support in commandline
>        lib/cmdline.c: implement single quotes in commandline argument parsing
>        Documentation/admin-guide: single quotes in kernel arguments
> 
> 
>   Documentation/admin-guide/kernel-parameters.rst  |    5 +
>   Documentation/powerpc/firmware-assisted-dump.txt |   20 ++++-
>   arch/powerpc/include/asm/fadump.h                |    2
>   arch/powerpc/kernel/fadump.c                     |   97 +++++++++++++++++++++-
>   arch/powerpc/kernel/prom.c                       |    7 ++
>   include/linux/moduleparam.h                      |    1
>   init/main.c                                      |    8 +-
>   kernel/module.c                                  |    5 +
>   kernel/params.c                                  |   18 +++-
>   lib/cmdline.c                                    |   54 +++++++-----
>   lib/dynamic_debug.c                              |    1
>   11 files changed, 179 insertions(+), 39 deletions(-)
