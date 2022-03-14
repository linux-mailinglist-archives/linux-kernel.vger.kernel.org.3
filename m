Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5869A4D7EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiCNJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiCNJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3137A41628;
        Mon, 14 Mar 2022 02:28:39 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXZbI5Bj82Xs5cuyPGpTys3YpWkhXLfyTUD2/9Gi5bE=;
        b=s9HJW0SH9iXWy8OE9fNG+46uFigPLdo9rcr1eNf5kR7hdwXYk47ywVPdUZMwHpG4pARiR1
        zJUTtm8cTav4z905mEQKrppa4iCfICA693vYvS3wgLrp1latbeqtEtJ10wUXtyWhARW12u
        Xw/84osKCFS5v7NsxIVmYQMbVyh+4eJrLw9GdiWreLsEvj8bfn2pHezXSsbna0oBgn+2ok
        mEzrEkQQ9wTxTo0GC8asm0Rwd4m6B0ozcxh4jCPq7wgrp5BQPKfXwJkMM2xMxMulYZPxJM
        cCWIZNVfFJckrML/teDa1DxSe/32hAsbCKC49bhtcg8HDoULTFX2oz5eKMjC8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXZbI5Bj82Xs5cuyPGpTys3YpWkhXLfyTUD2/9Gi5bE=;
        b=0IQNYvADltSboI++kMWCNx0Vdzght/T1ab0GshMp7DBUkNLk+Q7ENkZuqRbpkF2B8rJ7uQ
        9IsgHGAri/ixL/BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.18-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <a8cd9be9-7d70-80df-2b74-1a8226a215e1@linaro.org>
References: <a8cd9be9-7d70-80df-2b74-1a8226a215e1@linaro.org>
MIME-Version: 1.0
Message-ID: <164725011656.16921.13127252416806746788.tip-bot2@tip-bot2>
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

Commit-ID:     b166e52541f2357ce126a92ce1d9a580fdca719d
Gitweb:        https://git.kernel.org/tip/b166e52541f2357ce126a92ce1d9a580fdca719d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Mar 2022 10:18:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 14 Mar 2022 10:18:17 +01:00

Merge tag 'timers-v5.18-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clocksource/events updates from Daniel Lezcano:

  - Fix return error code check for the timer-of layer when getting
    the base address (Guillaume Ranquet)

  - Remove MMIO dependency, add notrace annotation for sched_clock
    and increase the timer resolution for the Microchip
    PIT64b (Claudiu Beznea)

  - Convert DT bindings to yaml for the Tegra timer (David Heidelberg)

  - Fix compilation error on architecture other than ARM for the
    i.MX TPM (Nathan Chancellor)

  - Add support for the event stream scaling for 1GHz counter on
    the arch ARM timer (Marc Zyngier)

  - Support a higher number of interrupts by the Exynos MCT timer
    driver (Alim Akhtar)

  - Detect and prevent memory corruption when the specified number
    of interrupts in the DTS is greater than the array size in the
    code for the Exynos MCT timer (Krzysztof Kozlowski)

  - Fix regression from a previous errata fix on the TI DM
    timer (Drew Fustini)

  - Several fixes and code improvements for the i.MX TPM
    driver (Peng Fan)

Link: https://lore.kernel.org/all/a8cd9be9-7d70-80df-2b74-1a8226a215e1@linaro.org
---
