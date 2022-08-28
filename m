Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154925A3C6F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiH1GxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiH1GxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:53:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A644F1AB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:53:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w19so10069250ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=jIUU48Dd4qUtx9eZL3yBJdTbWv5LKVxR1bts7DnjVSM=;
        b=eJDImHW3c1xRk5N/B3BTwzrFI3SQMOE/ydI047zviTnnXVtP+ffDsv0GMvqHNMWnks
         bbqDCfmfvWAZlV0GQOZsGR2h5hUNweOB2v/Sn+QXEaz2WQRpsHhnZkXB11O1BaNeLct1
         OMnBhmb97gwPAbvCBJ5X82X0dUDjtcB2f8btIjIz95QHTNVwnDPuBgemG3kpvYr8bgEO
         yx79QWuIidlzS8homorVqP2jOjJ3SpMjtfwr0n+f4oM47SpuVfE1Couwa9ZnwDS3Ur54
         StCmWAiOmJSeBBFTG4GX7/QM4sFOjYabiMmrHHqCDvkiVBf19pW8yAyQfrJhhY/dZ6RS
         pAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=jIUU48Dd4qUtx9eZL3yBJdTbWv5LKVxR1bts7DnjVSM=;
        b=1GuynPyxsh1XaghTrjvuW9niMuDrViOvIYpS5a2h61m1ctFXZWBwmMwShV/jaTbktA
         YH2TORehECXWsUTNkOyVws9ClC85mZB0d1BL4GMt6/HNzTWU7XU8QqNpHgEkxP898Dsu
         9u15CcO1G2fe1Wc4Mhwno70E31H78ILAJd07y0S6BXKVoVTV2ShBslk4tHEG9iZp8kmp
         ExU7Ss9gBuPCoAl7jefWg89+kzvN54UKDzMQWOzqr1ObnSdG97c3Hi7o6s6dwGxC+lSq
         jMWO91h/YuDhDFkfjI1fNFE7H9c2/xLgzLRY7AqNxIzGwKlMBczzFkcGjDyLV8Tnyf9Q
         WBGw==
X-Gm-Message-State: ACgBeo3Gg2EoYcsAuy9r0xvsuzF4zrkqMKvK9mpOGGzIrHVIdYbKuCU1
        lqt+msFw4ObnGViMi+nFtwxY30TCI+w=
X-Google-Smtp-Source: AA6agR6DGVAPaSmHx2JPLX5QqOr5Os6f+n+XvaQEpm21S07k20uhdkDCVwNXz3lACj8XvtFrmQycsg==
X-Received: by 2002:a17:906:7315:b0:741:5b1b:920d with SMTP id di21-20020a170906731500b007415b1b920dmr2273739ejc.484.1661669581106;
        Sat, 27 Aug 2022 23:53:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b00731803d4d04sm2854853eja.82.2022.08.27.23.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:53:00 -0700 (PDT)
Date:   Sun, 28 Aug 2022 08:52:57 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] staging: vt6655: Improve coding style in mac.h
Message-ID: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function and macro names and variable names to improve CamelCase
which is not accepted by checkpatch. Delete unused function declarations.
Delete unused functions. Convert functions to macros and make them static
when possible.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (9):
  staging: vt6655: Remove declaration of s_vCalculateOFDMRParameter
  staging: vt6655: Convert macro MACvSetBBType to function
  staging: vt6655: Rename function MACvSetBBType
  staging: vt6655: Rename macro MACvSelectPage0
  staging: vt6655: Rename macro MACvSelectPage1
  staging: vt6655: Replace macro MACvSetRFLE_LatchBase
  staging: vt6655: Rename function MACbIsRegBitsOff
  staging: vt6655: Delete function MACbIsIntDisable
  staging: vt6655: Rename function MACvSetShortRetryLimit

 drivers/staging/vt6655/baseband.c    |  2 +-
 drivers/staging/vt6655/card.c        | 22 +++++++----
 drivers/staging/vt6655/channel.c     |  4 +-
 drivers/staging/vt6655/device_main.c | 14 +++----
 drivers/staging/vt6655/mac.c         | 56 ++++++++--------------------
 drivers/staging/vt6655/mac.h         | 26 ++-----------
 6 files changed, 43 insertions(+), 81 deletions(-)

-- 
2.37.2

