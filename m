Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA115489903
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiAJNAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:00:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiAJM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:59:31 -0500
Date:   Mon, 10 Jan 2022 12:59:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGArG59LEbvKECyTgiK/jHh/XXGW4fziPXBLeJuE3KU=;
        b=zkLHOwfZwGRfaXEUlBst8hQk+0+txvHS3+RefbavGzM2Q5J6+tJURPbgRjAGv4B2ufhXNu
        1YQDXO+VmaxvqSJHIZha6onigC+CZWx8OCWG0JRh3sBrhLVB509be40mnvngy68QUAQAOJ
        9q7er/e4Ac/CNQdjaXKr6zstm+qPP1RpGowodekSJh9mruawEs6tRWL4VMc39BRmltv/ic
        ZcKEQLPi3hNX8Jhb2SIbKT3Ul4Fk3C/gfTIAqsLCYNs+hUTEwFTPRg0S4x8k6Vh/XhJPg1
        zjQltOgI9E1Ye7FEpMCzilPiAythuZ/xYpDRW46breV8oYw8LwzdINTW0xqFpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGArG59LEbvKECyTgiK/jHh/XXGW4fziPXBLeJuE3KU=;
        b=lAc1HDjKtgCoQGjbmdVHXkoCxkLK1wlW9+CjUEYXcm2+MXoJwDG/LFGDrlTwq65n8zk1YJ
        arXc3yz6vx4Ly3BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.17' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220108130807.4109738-1-maz@kernel.org>
References: <20220108130807.4109738-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164181956745.16921.13706344933258245637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     67d50b5f9114ae55d45e08e1fd1d6ae152622bf3
Gitweb:        https://git.kernel.org/tip/67d50b5f9114ae55d45e08e1fd1d6ae152622bf3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jan 2022 13:55:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Jan 2022 13:55:41 +01:00

Merge tag 'irqchip-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier:

 - Fix GICv3 redistributor table reservation with RT across kexec

 - Fix GICv4.1 redistributor view of the VPE table across kexec

 - Add support for extra interrupts on spear-shirq

 - Make obtaining some interrupts optional for the Renesas drivers

 - Various cleanups and bug fixes

Link: https://lore.kernel.org/lkml/20220108130807.4109738-1-maz@kernel.org
---
