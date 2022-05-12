Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCC52416C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349582AbiELAPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiELAPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:15:31 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FE69C2E2;
        Wed, 11 May 2022 17:15:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VCy.jBT_1652314516;
Received: from 30.39.157.75(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCy.jBT_1652314516)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 08:15:17 +0800
Message-ID: <b04fb722-1a35-9586-93e2-b9353e2944d7@linux.alibaba.com>
Date:   Thu, 12 May 2022 08:15:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [next] sh: hugetlb.h:27:1: error: no return statement in function
 returning non-void [-Werror=return-type]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
References: <CA+G9fYtS5fXzbODO3+Rz7VE4VvjY_1c99Da5UhruXi16jcVGbw@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CA+G9fYtS5fXzbODO3+Rz7VE4VvjY_1c99Da5UhruXi16jcVGbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/2022 11:56 PM, Naresh Kamboju wrote:
> Following build regressions were noticed on sh builds on linux next-20220511
> with gcc-11, gcc-10, gcc-9 and gcc-8.
> 
> Regressions found on sh:
> 
>     - gcc-11-microdev_defconfig
>     - gcc-11-shx3_defconfig
>     - gcc-8-defconfig
>     - gcc-9-shx3_defconfig
>     - gcc-8-dreamcast_defconfig
>     - gcc-10-defconfig
>     - gcc-10-microdev_defconfig
>     - gcc-8-shx3_defconfig
>     - gcc-8-microdev_defconfig
>     - gcc-11-dreamcast_defconfig
>     - gcc-9-microdev_defconfig
>     - gcc-10-dreamcast_defconfig
>     - gcc-11-defconfig
>     - gcc-10-shx3_defconfig
>     - gcc-9-defconfig
>     - gcc-9-dreamcast_defconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> In file included from include/linux/hugetlb.h:757,
>                   from mm/filemap.c:36:
> arch/sh/include/asm/hugetlb.h: In function 'huge_ptep_clear_flush':
> arch/sh/include/asm/hugetlb.h:27:1: error: no return statement in
> function returning non-void [-Werror=return-type]
>     27 | }
>        | ^
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:295: mm/filemap.o] Error 1
> 
> 
> Build url: https://builds.tuxbuild.com/291BWxg5eELaKSwUXNLIqh5w1k3/

Thanks for reporting. I'm sorry for my stupid mistakes. I've sent out a 
V4 to fix building issues[1], and Stephen will update today's 
(next-20220512) linux-next. Please test today's linux-next. Sorry for 
troubles again.

[1] 
https://lore.kernel.org/all/cover.1652270205.git.baolin.wang@linux.alibaba.com/
