Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839184E2731
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbiCUNFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347714AbiCUNFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:05:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDD3D4B7;
        Mon, 21 Mar 2022 06:04:25 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647867863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6oh2tEkEvjtphKwTfNJTxWtdpPsyogRNq0ARlevmVvo=;
        b=EWp9++qZBQoNASlyfzS6XD1omza7JaZAVVxYvCu9eRb+2nHkNQxk0zPF7Hp7vf6u7RarH7
        SZoJKCSjzeB6gkPChyBwA52pRHi1ty8eqTwW3QI5Xsdn+MwXRuqfpTOylEDoTPVe64ExbB
        Ys2ANjxvkShFkwOHqdl6Cf2kPDi6UHAMsR/dccBmzok2mgQjc+KZweuH+rcO5Az7PWpRV5
        0WD+MT6HmK8m/IwnoL80Y/hnCAvBItHu7JWDY7wIZsMG+P2Tq9RabtpU3fLtCwZo4pvEKl
        128EdjmP/efmLSdNDt9F3N6PQtEuOoLvoxFWgf8sghLw+CZqfcDFrvLNWSn8lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647867863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6oh2tEkEvjtphKwTfNJTxWtdpPsyogRNq0ARlevmVvo=;
        b=xO0o9eV7PJ+CWUidT3gg5/3KffvRIiu2tTbyLPmGcxd3q12bfns3yMJHyiaANKOvRiS2Ix
        a8I7O0NVgzDnH5Cw==
To:     Schspa Shi <schspa@gmail.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de, schspa@gmail.com
Subject: Re: [PATCH 5.15-rt] printk: fix suppressed message print when
 reboot/panic
In-Reply-To: <20220321111501.68241-1-schspa@gmail.com>
References: <20220321111501.68241-1-schspa@gmail.com>
Date:   Mon, 21 Mar 2022 14:10:23 +0106
Message-ID: <87o81z1mp4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-21, Schspa Shi <schspa@gmail.com> wrote:
> Update printk_seq for suppressed message.
>
> When message is suppressed, printk_seq should be updated, otherwise
> this message will be printed when reboot. This problem was introduced
> in commit 3edc0c85d154 ("printk: Rebase on top of new ring buffer").
>
> This patch apply fix to 5.15-rt according to
> Message-ID: <87a6dj3b5c.fsf@jogness.linutronix.de>
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks.
