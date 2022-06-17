Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878E854F928
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380358AbiFQO2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiFQO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:28:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F126A54693
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:28:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h1so4009474plf.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=Tcqogqr7saSROb6VJsAgZfCbPF8TWLw9G8OGokI3FTg=;
        b=E+4Jz3GGbPeUBX1+iOzQKk5b9D+kTxwstYr74i+tyWOs4q5olcWYlxQTD+bNKoXBRI
         amXrbYO2XleVeyrFW123CtKxnGQUGn+D/QCzkZoVqoY4xii4i+D4YVF5ATiRYFn+nyMn
         NJoeCFYUYL8z8BvPzsuLQSjRJUIRV9cQXjWkaFzla0uTQElu8y3uFgAoMKQQUsw7893K
         bs2qE8ZJNQXl/dsRMdt3a8wIGoVYTPa+fLuQ0h/m093JHgjB1YLwEkndjCPqM6f3LYEK
         IYPth2ugj1/I1fSbYZr7sZrtxN/RIaZiQx/1t3HQ56tKleur6cM/7pNP6SJ4/cUZC6y4
         vjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Tcqogqr7saSROb6VJsAgZfCbPF8TWLw9G8OGokI3FTg=;
        b=i+ETlEcttQ3/pl5uE4bS98uhS0RkUekBaszowmblX3QFPr+bzyvJKOWjpV4HsVTHgu
         A1kPR10IaZyr4lvJyiRJxlgVDic8mcGqC31ILPqSS8T7BopTibyayZxXq791bCbwnRyC
         6UBTdXFuJqeE2Ce/BOGkT8oP3plOv2D0TMW4cmN+gU7+dMa7OQIbzslTaLWnLalRNUuV
         RBXZcH5yv8fu517GIYFAX5Uevl1bW+pCPTBztjAdruP2mEuu2NopTq6ChEazycz+v1mS
         ZcM/6EYNiRcWxByHSJ7R8vmRZR5v+vkU2aQ1jkjjjRLHWcA2PFrOC1qF2XKZfaJDdL1C
         Hhhg==
X-Gm-Message-State: AJIora9FtiPsud1bTRyVTnkhNy/Ia7aEI8sA1ltVSukUDKapV4DeeKCP
        5YlOdfVnkYz32KW8PSgMarzUY6pRmKCiag==
X-Google-Smtp-Source: AGRyM1sQZnAyDmRJkonXd8bV0/gW4lFtzB5JN6E3PmH6DvPKId+IFv/dku2ioZg+/nr1ZDvNRhr14g==
X-Received: by 2002:a17:903:32c4:b0:163:e765:5071 with SMTP id i4-20020a17090332c400b00163e7655071mr9695779plr.153.1655476122875;
        Fri, 17 Jun 2022 07:28:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id ik4-20020a170902ab0400b001637704269fsm3606589plb.223.2022.06.17.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:28:41 -0700 (PDT)
Date:   Fri, 17 Jun 2022 07:28:41 -0700 (PDT)
X-Google-Original-Date: Fri, 17 Jun 2022 07:28:39 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.19-rc3
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-67f78725-bcd9-4c12-920d-2377a998b9f0@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc3

for you to fetch changes up to c836d9d17a7d102ded1ba4dbd4ee0bc42ba26211:

  RISC-V: Some Svpbmt fixes (2022-06-16 15:48:39 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.19-rc3

* A fix for the PolarFire SOC's device tree.
* A handful of fixes for the recently added Svpmbt support.
* An improvement to the Kconfig text for Svpbmt.

----------------------------------------------------------------
This is my first time taking an actual pull request, so sorry if I screwed
something up.  It's just a single patch and I checked over things last night,
though now that I look at this again I see that pretty much everyone is using
the git URLs instead of the SSH URLs.  Happy to re-spin this for next week if
that's a problem, but it looks like I've done that a handful of times before.

----------------------------------------------------------------
Conor Dooley (1):
      riscv: dts: microchip: re-add pdma to mpfs device tree

Heiko Stuebner (3):
      riscv: fix dependency for t-head errata
      riscv: drop cpufeature_apply_feature tracking variable
      riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol

Palmer Dabbelt (2):
      Merge tag 'dt-fixes-for-palmer-5.19-rc3' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/conor/linux into fixes
      RISC-V: Some Svpbmt fixes

 arch/riscv/Kconfig                      | 9 +++++++--
 arch/riscv/Kconfig.erratas              | 1 +
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 9 +++++++++
 arch/riscv/kernel/cpufeature.c          | 5 +----
 4 files changed, 18 insertions(+), 6 deletions(-)
