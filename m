Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1570956ABFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiGGTmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiGGTmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:42:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4754D14F;
        Thu,  7 Jul 2022 12:41:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 23so20318618pgc.8;
        Thu, 07 Jul 2022 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=ivYIsJT7PyHywMmzEaeXJnmebHs+p1o1VSB9W4EZkFI=;
        b=CU/gaNmCaTxnRWfeQlP5uruREHUPIHhpKRMmGfrPWz0LboJCIH/DD+09vp7fD6Fwwp
         TDOydXYVPFghdJmER2ahPWQ7JlWn0pReeESWFnYRNWRSVdiPDtBQm8e62yWU105Qg080
         67n2RHEJ6DAe9gAz3S9R1xXh2t+g3FxYeNUVI3LNWqxCcJrT5uAvUjiOQXPPOJ78dTwq
         s5IuW1x6zdSmYknts/6nukvh0hCtG47SFuI9+8F7sKFSSRA9hIEqMtxHvuiJJbC0IH8q
         78bSzsGgr70TThavHh72HgVDZtkiCVjtGd2CG2SG8mB010QFPwhDGQQzE+64IbSNsAwd
         x+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=ivYIsJT7PyHywMmzEaeXJnmebHs+p1o1VSB9W4EZkFI=;
        b=zmBvojfxbkNOJIApiRR+BqKiDZUgtZ5hHtlSgpV79w3PRYL5xOmBj5q0XKz/Fya6Kz
         tZ3oUhKINn+li/lS/oZPlH/hNkzygsII1TBukWzqLDVh8QZ9RrdYqTZxWF7nccJZPnVO
         eY1oUZExA638IJ4X3f1IrcAFvFGbW0yk/vTYAzoPJH2GBZP5F+uNxfaaZjadfPjX0kBM
         TpP8urzmpU/gl8Jqqa+C4RpSrrntvYQQ6UvluE8Pi9psvxlQnVITFne41omEMB0aDW6p
         XqsWArIV9eaGMDwgwy0DCdoBDBuEZivOuQoI69p6SALO8hFmcHc/SRTi+jTMsk26v3MX
         MLTA==
X-Gm-Message-State: AJIora/vxhUYF5Ri/1Sr8lI95w+ic8koKJfkQV5VntDLcJCOeNVwbssF
        dhgyZab2IyO9AYj2qUlGCRi/jrNKCZo=
X-Google-Smtp-Source: AGRyM1tFNzy/WZ5izk6HfT/XYKa2tO6rCwsz9MuGA1d5BEzkhy5Jd61C+bEA3GNgn/e6OMZqihfh6w==
X-Received: by 2002:a63:db41:0:b0:40d:e79f:8334 with SMTP id x1-20020a63db41000000b0040de79f8334mr23263205pgi.565.1657222918935;
        Thu, 07 Jul 2022 12:41:58 -0700 (PDT)
Received: from [172.30.1.47] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b0016bdd80a31bsm10458534plh.218.2022.07.07.12.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 12:41:58 -0700 (PDT)
Message-ID: <836aec22-fa5c-cbc4-cf9c-0676ea9885a4@gmail.com>
Date:   Fri, 8 Jul 2022 04:41:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Subject: [GIT PULL] devfreq fixes for 5.19-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-fixes pull request for v5.19-rc6. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.19-rc6

for you to fetch changes up to c8934e4e348915caac54085c01fd9d04fa16134a:

  PM / devfreq: exynos-bus: Fix NULL pointer dereference (2022-07-08 04:32:26 +0900)

----------------------------------------------------------------

Update devfreq for 5.19-rc6

Detailed description for this pull request:
1. Fix NULL pointer error on exynos-bus.c
- Fix exynos-bus NULL pointer dereference by correctly using the local
generated freq_table to output the debug values instead of using the
profile freq_table that is not used in the driver.

----------------------------------------------------------------

Christian Marangi (1):
      PM / devfreq: exynos-bus: Fix NULL pointer dereference

 drivers/devfreq/exynos-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
