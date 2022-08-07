Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53FD58BA87
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 12:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiHGKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiHGKHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 06:07:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A0F67;
        Sun,  7 Aug 2022 03:07:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so11902327ejp.2;
        Sun, 07 Aug 2022 03:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uZ4Y9ZBE3WzP0l02nv1M4Bipz183jpz7eunAyyqOylc=;
        b=ab0vi6XHLcQOwyrH9tInhBDEQXy6BGMupGRD9gHvGE7ALE/OKrE9Y7yFyo7qcSXooe
         I7JJqoQvt+dnzyLZ6bl8xvOliF3cwcWi5LeaItIN5Bfnglm3LjBe++F+zc9FufOja23x
         UBKHfVO03TFbM2cKa+nN8GJoMt3rXgwze1PUDLxMXmpI35qNjOGlW/8ondlGg4PzziYG
         scVEcpxLkj82ot6SGQ1aHMfLn2Tc5GOJ7hH+kahzno14YnAzsxWB/NYTi2Xo/6l7CbbF
         ZfJC1Exyw0RfMrMVW6HNkztiU9INW0ASZikkNZCcAOGuk6IKWmGH3PN6jQyX+rwz9Paw
         FZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=uZ4Y9ZBE3WzP0l02nv1M4Bipz183jpz7eunAyyqOylc=;
        b=pv7IQmzK+3FCDQKbKEMPyT5wUhMcP6pT0eryGIy1vuna2Npgaaps/EVuK3XfKz6oAT
         BtzABn3cm3IwCttE9SycQ+GF5k7pE3mRCpM0oOFRIpuQoM7/ng7twWfwqKy2jFLDvj2d
         xWrZnDooSUOC56KXlSF2nr5qE7mq/LT2+39YJpbWsxl3GpKd5X5DSEBdBETx2G71nC1m
         rU2icrLvQkYuP1PV62PQHgASzilZIFf4PRqm1WPEqRCyPTT3g8/w9BKW4kgTDUBETl0M
         7WQK8PxlkDpjN4ASOSEwNpyPrFdVdC/D2khsxL6yxMdcg050zSxYm+IpxcYA46Vop8+1
         vj9Q==
X-Gm-Message-State: ACgBeo3YxIRxS2GG+McUGQBEHrIrrMqCNvUicwiqkIbq/nngsLt9iskf
        rtUVrtv+UM13382rBqIcCrAv9Xo1TVs=
X-Google-Smtp-Source: AA6agR4wOnIGwY36ra18eh9mrxpc7bDv/cpaxYZKZAs6tUCcxtIGSutrpxaodcnab6hniAWT6dqt/A==
X-Received: by 2002:a17:907:60c7:b0:731:4b42:4e3e with SMTP id hv7-20020a17090760c700b007314b424e3emr1701944ejc.236.1659866831761;
        Sun, 07 Aug 2022 03:07:11 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7d60c000000b0043d0955d546sm2839062edr.69.2022.08.07.03.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 03:07:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 7 Aug 2022 12:07:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] hwmon updates for v5.20
Message-ID: <Yu+OzWv2JDbI89mW@gmail.com>
References: <20220730022529.497941-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220730022529.497941-1-linux@roeck-us.net>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Guenter Roeck <linux@roeck-us.net> wrote:

> Hi Linus,
> 
> I'll be traveling next week, so I am sending this pull request early,
> in the hope that there won't be a v5.19-rc9.
> 
> Please pull hwmon updates for Linux v5.20 from signed tag:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.20
> 
> Thanks,
> Guenter
> ------
> 
> The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:
> 
>   Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.20
> 
> for you to fetch changes up to cdbe34da01e32024e56fff5c6854a263a012d7ff:
> 
>   hwmon: (aquacomputer_d5next) Add support for Aquacomputer Quadro fan controller (2022-07-27 06:00:24 -0700)

>  drivers/hwmon/lm90.c                               | 2556 +++++++++++++-------

Just a quick build regression report, i386 allmodconfig fails to build due 
to a 'string overread' compiler warning in drivers/hwmon/lm90.o:

  # make ARCH=i386 allmodconfig
  # make ARCH=i386 drivers/hwmon/lm90.o

  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CC [M]  drivers/hwmon/lm90.o
In file included from ./include/linux/string.h:253,
                 from ./arch/x86/include/asm/page_32.h:22,
                 from ./arch/x86/include/asm/page.h:14,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/rcupdate.h:27,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from ./include/linux/ratelimit.h:6,
                 from ./include/linux/dev_printk.h:16,
                 from ./include/linux/device.h:15,
                 from drivers/hwmon/lm90.c:99:
  In function ‘__fortify_strlen’,
      inlined from ‘strlcpy’ at ./include/linux/fortify-string.h:159:10,
      inlined from ‘lm90_detect’ at drivers/hwmon/lm90.c:2550:2:
  ./include/linux/fortify-string.h:50:33: error: ‘__builtin_strlen’ reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
     50 | #define __underlying_strlen     __builtin_strlen
        |                                 ^
  ./include/linux/fortify-string.h:141:24: note: in expansion of macro ‘__underlying_strlen’
    141 |                 return __underlying_strlen(p);
        |                        ^~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make[2]: *** [scripts/Makefile.build:249: drivers/hwmon/lm90.o] Error 1

It's a build warning upgraded to a build error by CONFIG_WERROR=y, it 
normally looks like this:

                 from drivers/hwmon/lm90.c:99:
  In function ‘__fortify_strlen’,
      inlined from ‘strlcpy’ at ./include/linux/fortify-string.h:159:10,
      inlined from ‘lm90_detect’ at drivers/hwmon/lm90.c:2550:2:
  ./include/linux/fortify-string.h:50:33: warning: ‘__builtin_strlen’ reading 1 or more bytes from a region of size 0 [-Wstringop-overread]

Thanks,

	Ingo
