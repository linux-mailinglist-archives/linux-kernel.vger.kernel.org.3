Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8055535BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349879AbiE0Ihh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349807AbiE0Igc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:36:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EDA104C8A;
        Fri, 27 May 2022 01:36:08 -0700 (PDT)
Date:   Fri, 27 May 2022 08:36:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ncx3ivK+ZwISDSMM4kljdgZQUQznePRbXqDSNVCPmE=;
        b=fTTxCW7zVN7TKDWD5M/Q/2czmvsoVTxTbbFD1ye7ID9y4pcAtm9VW6PQE9O7YZzyznz2Ui
        NYmMkIf1LZyM1JYePlZcnnQU3t8HubddwdHZvFRBVg0oIwA2iUyTZ064/OhxctMPH73qeQ
        sCfw5Ck0ZctrXsRZDfFpkxpOPdIMITOh7PmzEq5BSYSQJrMWKbnESU32JBodIuwOyQNLVi
        1pfaSGUG2kiJWjqCjJ5x+x51/RvK7tzadc3OxUlIEFxQXUfh1FURGlTbX1an5+l61HF04v
        lg6RPOeP+TwxUeHUdvgN4tSPQRTyTTfvPDMRBQfbUoFifx1bCZaXlpfvMiRkMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ncx3ivK+ZwISDSMM4kljdgZQUQznePRbXqDSNVCPmE=;
        b=OGbA8qT2C+y+Pf40HcWB9uFhvcP29hW3VukTKZ2lAGK9g2I4xE3/dxbfOMaAWK5ivR+dtx
        SPLgbZjS68jLRYBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.19-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <b5a83e54-1ee1-f910-4be4-bc3bf1015243@linaro.org>
References: <b5a83e54-1ee1-f910-4be4-bc3bf1015243@linaro.org>
MIME-Version: 1.0
Message-ID: <165364056563.4207.1413260323155955493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     57963a92a70b037aa22544fbc34742e5be689c04
Gitweb:        https://git.kernel.org/tip/57963a92a70b037aa22544fbc34742e5be689c04
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 27 May 2022 10:32:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 May 2022 10:32:08 +02:00

Merge tag 'timers-v5.19-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clockevent/clocksource driver updates from Daniel Lezcano:

  - Add Mediatek MT8186 DT bindings (Allen-KH Cheng)

  - Remove dead code corresponding of the IXP4xx board removal (Linus
    Walleij)

  - Add CLOCK_EVT_FEAT_C3STOP flag for the RISC-V SBI timer (Samuel
    Holland)

  - Do not return an error if there are multiple definitions of the sp804
    timers in the DT (Andre Przywara)

  - Add the missing SPDX identifier (Thomas Gleixner)

  - Remove an unncessary NULL check as it is done right before at probe
    time for the timer-ti-dm (Dan Carpenter)

  - Fix the irq_of_parse_and_map() return code check on onexas-nps
    (Krzysztof Kozlowski)

Link: https://lore.kernel.org/lkml/b5a83e54-1ee1-f910-4be4-bc3bf1015243@linaro.org
---
