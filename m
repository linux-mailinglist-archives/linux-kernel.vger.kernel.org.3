Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7C4BBEB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiBRRuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:50:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiBRRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:50:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA1F3EF08
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:50:18 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l9so7779745plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=0Qt9aLRVk4goBTUwquuWJkruOHldgdUssfKiVNyRjBQ=;
        b=ELVfiqPh9ppAkt0PMnsaDcgHf9dr6TJTZx9jcxSn8dD8lROslE9gx+uCG3xPON3JIL
         nzHVZTyC12rV3QQhc/z6iIQz5FJxsgNfVA5U3/S3dfxwjl/Oe8MQzGLia/1RA7VU/V0Y
         VqcgPz2pHKc90EFevzjH0w6BQw9cbPycC84VHmDu7k6i3FAeqV1NF5P0Oo5588EvwZFL
         1wmwH+4WDywZdyLPB+X3ZP+Wm+KkOxTe9E6Nyj++EX+1KXh9D8gwWgwR3ECJN3c9FyFT
         3rBWEV8sGmdptAiulK619gvuB3lHRgHnMINsLG5SyjKYl8BIyyFlalWBRnWVE3q/8itv
         J72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=0Qt9aLRVk4goBTUwquuWJkruOHldgdUssfKiVNyRjBQ=;
        b=oKO93+F9Q8OdzO/2Q4XrujozVVX+JteUyVpiVRc//6vP/DIPPo64rmmanqCyW9Wonb
         SqYkj4ZDXPfWPKOqL4/H55HQ0vMzREgyamTfBEiOKRScKbyj5NvNZAANt1buJ4tonGru
         6zZEvPoPzGYYr2iO3H2R+hBZn5XV/a+w42tWJ8WZuHL53raWDJC80pTiccdcqfjfNdhG
         OPAsmiWDaWfHtOxQ/anKL/FhITLTKcZrQv2+fzr8hwJfLMl1P2IQmCcVp/PtnR0VUwC5
         tdvod/48kvSXPdb3bteHou+N+QHAeYzOoVIDS0oQpvr8wHiD5pDGneLcEj0ysG5f2mwp
         3iMg==
X-Gm-Message-State: AOAM532tI05XKrMAYNOFo9Z2Lc4qf8G5k5pZY1i1Cry7MDOziPGRHPbd
        3X0xOA7s75EL1pMxHy0OaPiuzQ/3JLAwBw==
X-Google-Smtp-Source: ABdhPJwO6mvs5H5GQcZgPoP18sncryFhxTQwZ/ukf2jOdcU83CBOdxodUkk58WWfOmTighdkR3YjVw==
X-Received: by 2002:a17:902:b201:b0:14d:66b5:5d69 with SMTP id t1-20020a170902b20100b0014d66b55d69mr8420800plr.95.1645206617851;
        Fri, 18 Feb 2022 09:50:17 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u1sm4081853pfg.151.2022.02.18.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:50:17 -0800 (PST)
Date:   Fri, 18 Feb 2022 09:50:17 -0800 (PST)
X-Google-Original-Date: Fri, 18 Feb 2022 09:49:33 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.17-rc5
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f149d1ba-1f6d-43b3-8df0-95d27c2b89c0@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6df2a016c0c8a3d0933ef33dd192ea6606b115e3:

  riscv: fix build with binutils 2.38 (2022-02-10 09:17:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc5

for you to fetch changes up to 5feef64f4c67068c49f5409d43c67cabf2327f66:

  RISC-V: Fix IPI/RFENCE hmask on non-monotonic hartid ordering (2022-02-14 12:27:45 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.17-rc5

* A set of three fixes, all aimed at fixing some fallout from the recent
  sparse hart ID support.

----------------------------------------------------------------
Geert Uytterhoeven (3):
      RISC-V: Fix hartid mask handling for hartid 31 and up
      RISC-V: Fix handling of empty cpu masks
      RISC-V: Fix IPI/RFENCE hmask on non-monotonic hartid ordering

 arch/riscv/kernel/sbi.c | 72 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 25 deletions(-)
