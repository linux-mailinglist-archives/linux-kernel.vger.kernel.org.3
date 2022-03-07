Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303464D0909
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiCGU4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbiCGUzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:55:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E3C40E6C;
        Mon,  7 Mar 2022 12:54:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso360768pjq.1;
        Mon, 07 Mar 2022 12:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zkCQnU25vRaG4W9nWnsmXVac+hU6z1UCzvKbgfJvzA=;
        b=U53JBAMIieK91+S22DJEVApF7fJAZxw9nHcYsFrR1c3KXK6Dcq/hPOMGtfc8q6E+kL
         YmX+dLPFv21yCzsgWaqarfHat8mwGZK+zTVRg/qM00FAh0ewS5u8lSKVur9WwuGDfsS2
         CBs7Ntp7crtLgx1nIcj0Mboa+aWRXqGZ8WCejG/K4YwK+A/BaKCfbotDBfrcMfsdRHnj
         fIOEtM7LDzAtdKRnu9+hH/c8oKphH4rQr52Ex6nT0vIQ/Y4/rbY21N7xTb6vyq5Hces5
         sxhMIfUwjS25PVkSkAjOfHD9kK8VLKCKX0bKqsxXi0259u9leM87SEW2jVnVLfH7D/8L
         kKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zkCQnU25vRaG4W9nWnsmXVac+hU6z1UCzvKbgfJvzA=;
        b=rGDBvJQZamPmwke3mv6uXplFHj7RTPBYdAUvBVNuQeXBI02smJiy40MTuwgn0D9Tr4
         23+jE0mbOjvA4U0t7nA+QtlPkzdjK5OMSjJXfQ3IrCvHn404PiIZnze2O6patXthYmB/
         f/eMr8KuQgUcY/XQ0Rwm6KS6p776IJdMSxyWE7BOTn755odLu9+3Pxmr95454mC3RV/x
         MU5dqe4I93TeBTkyUfGrZG049EglZ3/Sb4wMBMeObMS7hxVpPLmSgcEt+8phzplCXbKu
         /tXjlVGfkcH69XecwwcandN/R09hHh1xt8XX7CWO4ywvv5opBBGx1nFOmLuOXHSaRhTr
         rikQ==
X-Gm-Message-State: AOAM533Trrvp/kNjDHNlbswj+nAAAjvSjcHk982wCYqRcyBy8exLfymR
        ZEgY1p95S+OnNULE9IMpbp0=
X-Google-Smtp-Source: ABdhPJx7hHxAzDxxnL4yDIF89UWxmfKGRm7I2TUno0NUHasHgjVx/wj21gWZ/5ewllOfCE3ZRAtYFA==
X-Received: by 2002:a17:902:a98b:b0:14f:ae28:c660 with SMTP id bh11-20020a170902a98b00b0014fae28c660mr14300370plb.94.1646686442277;
        Mon, 07 Mar 2022 12:54:02 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id a12-20020a056a000c8c00b004e1a76f0a8asm17676794pfv.51.2022.03.07.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:54:02 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/2] Arm based platforms dtc fixes for pl022
Date:   Tue,  8 Mar 2022 02:23:55 +0530
Message-Id: <20220307205357.66322-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is an attempt to fix device trees and resolve bindings
warning for pl022. This requires updation in clock name to keep alignment
with other platforms and spi node properties for integrator platform.

This patch is based on
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git,
master
Since, these patches are based on same tree, so i added them in series
for seamless application.

Kuldeep Singh (2):
  arm: dts: realview/versatile/ste: Update spi clock name
  arm: dts: integrator: Update spi node properties

 arch/arm/boot/dts/arm-realview-eb.dtsi    |  2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts |  2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts |  2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi   |  2 +-
 arch/arm/boot/dts/integratorap-im-pd1.dts |  4 ++--
 arch/arm/boot/dts/ste-dbx5x0.dtsi         | 12 ++++++------
 arch/arm/boot/dts/versatile-ab.dts        |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.25.1

