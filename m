Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2AE512F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiD1JtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348037AbiD1JgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:36:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C6B95486;
        Thu, 28 Apr 2022 02:33:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k4so3847748plk.7;
        Thu, 28 Apr 2022 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kWZe+4U90sxTKToEseK0+oAihI7ZBnHaalcQvB+4Uuo=;
        b=E7jjJrp33n0Qj5If3vLLYwfakVJG/T4INawvqftLhNW9eEe+YbX0OSrjv6IS0PtyMe
         diT0FntjAzNAvTpLcC8J54wT9I008ZvsoEbauH0HMYGKJW1JMoIyJ5M04Fk3A6/RhB06
         QzKacey6Y3Ri7k7+gX+bab14OldiWlQcuVcXNRLmnccATw/D1AXIGcIODkY5Q1Sy/FkP
         Fc6NQb8b1fjEjRDZlYsU3KHgoaXk22AXFIApM81ss9XL5KltYVelBJFUP+hQmz9gTAlZ
         ZUUwyQjtPh8Vopq7OGLBmQqsindaYGYKiCfjyPLYHdWTW6j92UzfeovurHhagnenCpK4
         9X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kWZe+4U90sxTKToEseK0+oAihI7ZBnHaalcQvB+4Uuo=;
        b=2nNvyMI2XoERuecGOoUjOV2iow8vJl63qesFouYbfZazCQsvZfRaGM8RLNf2yTZsvx
         TjIlshHoRl2405i9vS6rm4vui99R3qGzWglynCLzGXLzvd2/83I+qHNqiK7vr/jW7kfp
         Za0F+NCDaVgJMwTnVQXZ2LOMkjbDWrQjRrColRTD1v3YolULE7K4ckaVmcRI4vvpVGOp
         fxuTv5jodEebM7H3qHQ28YwbDj91N1to7lrLy+wqGcJFmk5ZHKck72AJkCW/VL3t7F3i
         h8GGpvj6gv3ZIBLMc23ETxyOPGHxwl2E+/0dI/wGHmCOYXuyDKgBrdHJ4Kt/TKCcN32e
         K8xw==
X-Gm-Message-State: AOAM5323vw2H4zRnC5137a/xtZZH11fDyA1QleGrlkgC5ZXz2Ou3A2Lf
        rifFxop8WRGT7H0Wtcs2judIWw3hL20=
X-Google-Smtp-Source: ABdhPJwNXGBHj42NXx7t+qclCk9irVzgFj4UXrWz3vDqXdZOADcX0g9YJUbTB3xz2kMM91Xt+Vf7NA==
X-Received: by 2002:a17:90a:c402:b0:1d9:a003:3f8a with SMTP id i2-20020a17090ac40200b001d9a0033f8amr17168273pjt.18.1651138388661;
        Thu, 28 Apr 2022 02:33:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:2b1f:d169:337e:6359:8ff7])
        by smtp.gmail.com with ESMTPSA id i66-20020a628745000000b0050d36a5fe70sm15457932pfe.127.2022.04.28.02.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:33:07 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, jacek.anaszewski@gmail.com,
        gene_chen@richtek.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] leds: flash: mt6360: Apply the fixes and hardware features
Date:   Thu, 28 Apr 2022 17:32:41 +0800
Message-Id: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series includes some fixes and add supproted ISNK hardware features.
From MT6360, ISNK can support three modes (CC, PWM, and Breath). The previous
one can only support CC mode.

ChiYuan Huang (4):
  leds: flash: mt6360: Fix the wrong enable_reg in multicolor brightness
    set
  leds: flash: mt6360: Remove unused dependency in Kconfig
  leds: flash: mt6360: Add mt6360 isnk channel hardware timer dimming
    mode support
  leds: flash: mt6360: Add mt6360 isnk channel hardwre breath mode
    support

 drivers/leds/flash/Kconfig       |   4 +-
 drivers/leds/flash/leds-mt6360.c | 413 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 410 insertions(+), 7 deletions(-)

-- 
2.7.4

