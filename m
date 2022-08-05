Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0358A90D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiHEJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiHEJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:54:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6487B481E9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:54:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h13so2652028wrf.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=7oSWzw08ErorXdwfypMz8hOIDNIrEaUdKP8DUsP4jtU=;
        b=f+ctR6gR3+OEFkDVj9plmzsdkBb31hxP79tU+tYv/+FhqmSJcUmhamtjX0hFqfmXjc
         hBJz5e1T3VfJLFSGroOguIBJEPppsSAUOwsuSD/lwSI0pOB/qlMCRw2aHo2wKFnQF9qg
         rk/Yzjk2nPuDBvu9ER9GNHnvmIDvIfAuonh7+R/6c9ahgDQdyZH0EWVPFDoR6qifEodK
         NaWuCEQxcB21oaKAJ34/f+KyDKM65eD8hMV1/rMnUme/k2iwKH8g5oC3m4/Bw4miMWm8
         izHYCe0dPe2CZ0yuLHjuIDbhzegLhyuzVY4fp4kx0ehYReyiKnjlr4BkWiC+lfGTpTOi
         8PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7oSWzw08ErorXdwfypMz8hOIDNIrEaUdKP8DUsP4jtU=;
        b=s75ohc2yIfC4Kj1eON3W0QBv2HLksJl1aVL0tNaTmovSsxmPpDOxjLKHxsmGc2hF6z
         c3RLuSTyvBwk/96IjR9cMuqJQq5PvxAmes2sq97wm8Ky7CZaBfTK3vrdy2m4xhPPgZK4
         CS/alDVC/8bdnfEcknCxBD1LNu4aoxpJ4rsXjvjZ5mvP77NAI0LWXPfNhEb8hBl22FNn
         TUnPZubP/+zjlVkuA+MDN9jQHwuHYdX4DTvAzHxnoLm7VhpSUEUMWJGXJkH2vtre1d4z
         GD7sfbf3Sdy7Y+YLuPZ32xwHnSQest8IIIfeMiaKM79Pi+JX2jStWfYFPAPYsN5U73JE
         RtWg==
X-Gm-Message-State: ACgBeo2rm7ceAzKNS9u9Z9Jo1wci5qvVXIrgwxLy2SYbBiAFX4jMCyAP
        +IgHHp43qsUu87TSi2dJjWypLQqbcFjybg==
X-Google-Smtp-Source: AA6agR6OP/1EzHrpiLLNyC/MBF+Ne6PJ3pwk4CH6O+KC7SZZQqg0Czw/jqOYMEfDPTmSZt4mx+OdZg==
X-Received: by 2002:adf:fec1:0:b0:221:6cd7:1cfb with SMTP id q1-20020adffec1000000b002216cd71cfbmr1580517wrs.197.1659693265878;
        Fri, 05 Aug 2022 02:54:25 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t16-20020adff050000000b0021ee28ff76esm3449594wro.38.2022.08.05.02.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 02:54:25 -0700 (PDT)
Date:   Fri, 5 Aug 2022 10:54:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.20
Message-ID: <Yuzoz21D5Cb0yROm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.20

for you to fetch changes up to fe201f6fa4cf96749b0a6b6a61b33b6a82de4e49:

  MAINTAINERS: Use Lee Jones' kernel.org address for Backlight submissions (2022-08-03 08:26:30 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Change maintainer email address

 - Fix-ups
   - Obtain OCP level from Device Tree; rt4831-backlight
   - DT fix-ups/conversions; richtek,rt4831-backlight
   - Remove unused code / functionatlity; platform_lcd
   - Switch to atomic PWM API; lp855x_bl

----------------------------------------------------------------
ChiYuan Huang (2):
      dt-bindings: backlight: rt4831: Add the new ocp level property
      backlight: rt4831: Apply ocp level from devicetree

Lee Jones (2):
      dt-bindings: backlight: Update Lee Jones' email address
      MAINTAINERS: Use Lee Jones' kernel.org address for Backlight submissions

Maíra Canal (1):
      backlight: lp855x: Switch to atomic PWM API

Rob Herring (1):
      Revert "drivers/video/backlight/platform_lcd.c: add support for device tree based probe"

 .../devicetree/bindings/leds/backlight/common.yaml |  2 +-
 .../bindings/leds/backlight/gpio-backlight.yaml    |  2 +-
 .../bindings/leds/backlight/led-backlight.yaml     |  2 +-
 .../bindings/leds/backlight/lm3630a-backlight.yaml |  2 +-
 .../bindings/leds/backlight/pwm-backlight.yaml     |  2 +-
 .../leds/backlight/richtek,rt4831-backlight.yaml   |  5 ++++
 MAINTAINERS                                        |  2 +-
 drivers/video/backlight/lp855x_bl.c                | 21 ++++++--------
 drivers/video/backlight/platform_lcd.c             | 10 -------
 drivers/video/backlight/rt4831-backlight.c         | 33 +++++++++++++++++++++-
 10 files changed, 52 insertions(+), 29 deletions(-)
 
-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
