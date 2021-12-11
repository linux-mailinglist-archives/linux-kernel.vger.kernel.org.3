Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B714713EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhLKNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 08:05:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhLKNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 08:05:12 -0500
Date:   Sat, 11 Dec 2021 13:05:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639227911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+yKH03qOG5QF0/r8TSne1E+XiIekMYgNuMhVNJdPai0=;
        b=mzYEzk1IoITj7EFhfQPmdE1NDiXE8uqV+e01MeXjyHeD3UwtHeIgv1jAypBMDNrLJhTCA3
        fVnRuBMLMwpQkLkgDBY9DwWWZ88UR3wBimsKDvRTJOKZlL1SzTPUAuyFDJGf7arUltF2a6
        pJZrMr9qNyU5VbZWds87T44EZh1MrBrWt4IxSJiBL2VYIy2p2IEe/R6QQ6loHSqM5cLvSZ
        3BwyrEMENA88YCKp7V8RoJPh5NY7dH59OCpIEImm1dAlLvFAsBmK4LcK/EyR/SQtbBZhSw
        WKBTq5UFM28DQ83xfeg1c+WTZmfLt4IHt1FfqL6qZFnpOWLrstgn7PtD1wjXPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639227911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+yKH03qOG5QF0/r8TSne1E+XiIekMYgNuMhVNJdPai0=;
        b=zFsNKPjFcLluySRdRsajsnSO6c2OnRr+Ny/+13HtJH8YEOZzZRsOYuDValxVx/B/fHMpA+
        2dhnXkDEkmd7c9DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] Merge tag 'timers-v5.16-rc4' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <429b796d-9395-4ca8-81f3-30911f80a9a9@linaro.org>
References: <429b796d-9395-4ca8-81f3-30911f80a9a9@linaro.org>
MIME-Version: 1.0
Message-ID: <163922791058.23020.11227739373527480594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     aa073d8b2a6308832de3cac18e7901ac60748e26
Gitweb:        https://git.kernel.org/tip/aa073d8b2a6308832de3cac18e7901ac60748e26
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 11 Dec 2021 13:56:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 11 Dec 2021 13:56:30 +01:00

Merge tag 'timers-v5.16-rc4' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

Pull timer fixes from Daniel Lezcano:

  - Fix build error with clang and some kernel configuration on the
    arm64 architected timer by inlining the
    erratum_set_next_event_generic() function (Marc Zyngier)

  - Fix probe error on the dw_apb_timer_of driver by fixing the
    incorrect condition previously introduced (Alexey Sheplyakov)

Link: https://lore.kernel.org/r/429b796d-9395-4ca8-81f3-30911f80a9a9@linaro.org
---
