Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82FF4D0662
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbiCGSXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbiCGSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:23:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A182D21;
        Mon,  7 Mar 2022 10:22:20 -0800 (PST)
Date:   Mon, 07 Mar 2022 18:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646677338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXbeal6bcy95rXyzNFRNmpLjARfb/CPaN+PE9LyP9rI=;
        b=3jZoEM/z6CfMqutjQJecvGmBSk5jYC3EVcfwNXdZWcoVpsoNfW64vfhVc6GlBkn898dOnh
        SMJcOTD5FnkQRkHIO3Qhaqp0YC0JyZjYQejAgZBKo3GgRPJ0SPW8QUICWROw7eUTji4dMX
        TPErS2/Q0fBS7jXOwsdir4g3BJz2kPKl9kKnYYRrQZU07gBzXGAkTBdsk/ZSH5XogdXLt6
        KQKSHjnCE2+ehgLYybdNVOVIr+uKDjNwX3ngtQbnrCPyjhJPyK5OSm6lZSdNSiakh4FcCF
        0asOTEbd2c7p9sCPvaj1Hpc8JFFtoXvLJtTFS+BbaeXWd0bz34GUhhxFH8IBsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646677338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXbeal6bcy95rXyzNFRNmpLjARfb/CPaN+PE9LyP9rI=;
        b=e1k4UY0rcSecT6erkbR7eFXZPH5AbMs1lyxv7Swpe0aXdhr6EEy6p5XnlTqD3QFnyymoEN
        r1yH+5BiCttYTMCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge branch 'clocksource.2022.02.01b' of
 git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into
 timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220224000718.GA3747431@paulmck-ThinkPad-P17-Gen-1>
References: <20220224000718.GA3747431@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Message-ID: <164667733763.16921.1137393450862098087.tip-bot2@tip-bot2>
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

Commit-ID:     58dedf0a4782ce42b4d31f1f62e5ad80a1b73d72
Gitweb:        https://git.kernel.org/tip/58dedf0a4782ce42b4d31f1f62e5ad80a1b73d72
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Mar 2022 19:12:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Mar 2022 19:12:38 +01:00

Merge branch 'clocksource.2022.02.01b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into timers/core

Pull clocksource watchdog update from Paul McKenney:

 - Add a config option for the maximum skew of the watchdog.

Link: https://lore.kernel.org/r/20220224000718.GA3747431@paulmck-ThinkPad-P17-Gen-1
---
