Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54734583C65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiG1KqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiG1KpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:45:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97224664ED;
        Thu, 28 Jul 2022 03:44:24 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwoAYgZZzTuULxuR7KdOJAlMVrYrVIxLgqZSyrclnxQ=;
        b=LE/vRynijmMST+2rZWCw3Vo5BgeDvNek6J73T1XUuVWayEcFLvaSFlZATmEKWDEjWiNEf7
        ZuZBp9S6RLzYQcbmHVSkOtj6y4u8urJOyeg75Ln1wX/9ETNAjuHQ5a4gnQ8Huj6gpRsq8g
        OQXBoIzHnsscxuOE/B+90Ja5oT/Kkt9QZZ58jylwaG8+nm/lPrewMq86jZHOUE7COh48fl
        JNoKyFq4if4DpWKFpMHgh/HmA4gbo/fgPnbfPwyVmt5/SFbR1xFWwaYUDR/Kvz7ac5PZZp
        LbMVYk21q11KxH2lQI+MQijqMCjcpZsnn6PIgfAXH5HlA8mLKr2qOfmssRNzHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwoAYgZZzTuULxuR7KdOJAlMVrYrVIxLgqZSyrclnxQ=;
        b=yXiUuTfpFtgQUBmdIRFw/u1HXJIy/5tWPtMXpBuN/ang+8G31XtuvfUBR+AYlTcXMqf2WO
        pvovpxnQH2XBq3DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.20-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <7472984e-f502-5f27-82bf-070127dd85a5@linaro.org>
References: <7472984e-f502-5f27-82bf-070127dd85a5@linaro.org>
MIME-Version: 1.0
Message-ID: <165900506117.15455.179308820042682784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     75fed76ebc8f75e7a9f8c9ca39482aa34932ad41
Gitweb:        https://git.kernel.org/tip/75fed76ebc8f75e7a9f8c9ca39482aa34932ad41
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 28 Jul 2022 12:33:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Jul 2022 12:33:34 +02:00

Merge tag 'timers-v5.20-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clockevent/source updates from Daniel Lezcano:

  - Add the missing DT bindings for the MTU nomadik timer (Linus
    Walleij)

  - Fix grammar typo in the ARM global timer Kconfig option (Randy
    Dunlap)

  - Add the tegra186 timer and use it on the tegra234 board (Thierry
    Reding)

  - Add the 'CPUXGPT' CPU timer for Mediatek MT6795 and implement a
    workaround to overcome an ATF bug where the timer is not correctly
    initialized (AngeloGioacchino Del Regno)

  - Rework the suspend/resume approach to enable the feature on the
    timer even it is not an active clock and fix a compilation warning
    (Claudiu Beznea)

  - Add the Add R-Car Gen4 timer support along with the DT bindings
    (Wolfram Sang)

  - Add compatible for ti,am654-timer to support AM6 SoC (Tony Lindgren)

  - Fix Kconfig option to put it back to 'bool' instead of 'tristate'
    for the tegra186 (Daniel Lezcano)

  - Sort 'family,type' DT bindings for the Renesas timers (Geert
    Uytterhoeven)

  - Add compatible 'allwinner,sun20i-d1-timer' for Allwinner D1 (Samuel
    Holland)

  - Remove unnecessary (void*) conversions for sun4i (XU pengfei)

  - Remove unnecessary (void*) conversions for sun5i (Li zeming)

Link: https://lore.kernel.org/all/7472984e-f502-5f27-82bf-070127dd85a5@linaro.org
---
