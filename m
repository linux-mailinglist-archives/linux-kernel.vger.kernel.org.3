Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86051A526
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353249AbiEDQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353237AbiEDQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C182C46B27
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:11 -0700 (PDT)
Date:   Wed, 4 May 2022 18:15:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIERbk2cpXsoJ8kjftCUWYSeozF5R/Qyv/1f0LqgUsg=;
        b=mcuAQ1W57z6ENUPXEfEN960z51qDqiCsTVoJbP6PXMyH2vVOwEbdKT7gOc0C4pl1Jj7Ydg
        KN+meDhENr88vWJls3RZ5AEJGg90Sx8VmG4c/FGL6PY6Fz2/+g6CxcWo4g4vndYC6S/QEl
        RyTzpmFo/7dqqcTMitH5reYMPwmLe4YssBMM9ZTtYUL3/eSEgui3U40g2M92mgIx8fXKq2
        BjfbXiGHqqGa87uXnIFtCfDKm8VqMXssyESSm3xTXehxpNLwbAtnXwzW3ZuxL20Yxa0Vir
        1S5lGL7HN2U1sR6uCC9+50EHRSAM71erEX7jW9C8Y0sAzkYkWpq8VJw/xEDdnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIERbk2cpXsoJ8kjftCUWYSeozF5R/Qyv/1f0LqgUsg=;
        b=sP33yVjRoceLFeDKR8JDjrxCmb8kC1jMp282tcfC4Gf1o0H1X7hgtm9eLFVSBOfjCzy5TE
        L1TmjiFlJgc0uzDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/lockdep: Remove lockdep_init_map_crosslock.
Message-ID: <YnKmjGQ/i7KN7aYx@linutronix.de>
References: <20220311164457.46461-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311164457.46461-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-11 17:44:57 [+0100], To linux-kernel@vger.kernel.org wrote:
> The cross-release bits have been removed, lockdep_init_map_crosslock() is
> a leftover.
> 
> Remove lockdep_init_map_crosslock.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

ping.

Sebastian
