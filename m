Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90668559E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiFXQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiFXQIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:08:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B22E087
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:08:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k7so2502878plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=spPs9Kh5ojs3SRS6SOisJmBowfLYX6h0pwpaQVCmATc=;
        b=OOQwQsejeQlKbt2UzAYvBYDM91ItcQHMgj5FomAy5gRFoPGhCCYuOas+oX3/kpysGX
         Rptyn7UjcB/OZrSFIpq8QWU8KKXidyivS/wVCOnTRqr+tse+DOppn9kUdBi37HH+oM83
         eCqN/hQoAAN8JJexYF7im9rEXASfSmYsgirooRs/E+pTIQkqQFsx0vq3Kc5kmuPpPBgF
         y+XieLAqDEB7ZnKk6EQ5F5zNywMvRi7l3djlploU551bac5tDkX3Zw1NdjQvATRNHlDu
         z26QRvkrAM9/9zUqKyTHb8yVc4wCRof7NxnO1HLjtsJ0PTm5Wm4g5ylObydY8ndED2Fb
         yvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=spPs9Kh5ojs3SRS6SOisJmBowfLYX6h0pwpaQVCmATc=;
        b=wH1fY8zOk+FavsoDK09ZKjaE58h5PjqXXkIb1AmJ7pYUbMJAxS9b5g/OBqhnMuCGOT
         985UtdMG88FXRS/TEIFnoAbrYwDNxw5ioYssCk5kbIypJNiY+wR+uFR2XmxtWh+Wc4uq
         k9yO35hObWCFIwSP38TPZ3QyQXPiYqau7LLu+emQqaLN7AsgvkMaYWbvzktEJsFyCLWK
         Q6OJ83UA2n6pFKuveyB60Q789a5D8eBHvu3NSo9MZk2nf/uMpCYntOD4YVfwQPgkYaYI
         M+qPcJsnllgrVhqeoDP98Tz/5kx21lRJZ9p7T+fE1vdImhaxm9611khlTomVGGlzEIwF
         T1XA==
X-Gm-Message-State: AJIora91Aj7cKR2Tmg2Z37l2aMVp3IUWC1Q49kG+DYFpeO3dzGNTVnA3
        zbFcLVT0XJznBLz6LiIN92INiA==
X-Google-Smtp-Source: AGRyM1umNBt5UoQa8o4X9DncGsEKMTMaXY8F5/kEULHEONR9NnfdGcqdijJnlh2NADsJZ0Aul8jKDw==
X-Received: by 2002:a17:902:f642:b0:169:714:b079 with SMTP id m2-20020a170902f64200b001690714b079mr43540771plg.117.1656086892581;
        Fri, 24 Jun 2022 09:08:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h6-20020aa796c6000000b00522c8fb04adsm1976417pfq.176.2022.06.24.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:08:12 -0700 (PDT)
Date:   Fri, 24 Jun 2022 09:08:12 -0700 (PDT)
X-Google-Original-Date: Fri, 24 Jun 2022 09:08:06 PDT (-0700)
Subject: [GIT PULL] A Single RISC-V Fix for 5.19-rc4
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-3e339ca6-0ed6-4d02-96b8-2f664f62cc8c@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c836d9d17a7d102ded1ba4dbd4ee0bc42ba26211:

  RISC-V: Some Svpbmt fixes (2022-06-16 15:48:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc4

for you to fetch changes up to e83031564137cf37e07c2d10ad468046ff48a0cf:

  riscv: Fix ALT_THEAD_PMA's asm parameters (2022-06-17 06:16:46 -0700)

----------------------------------------------------------------
A Single RISC-V Fix for 5.19-rc4

* A fix to the T-Head memory type errata workaround that avoids behavior
  that is unsupported in the LLVM assembler.

----------------------------------------------------------------
Nathan Chancellor (1):
      riscv: Fix ALT_THEAD_PMA's asm parameters

 arch/riscv/include/asm/errata_list.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
