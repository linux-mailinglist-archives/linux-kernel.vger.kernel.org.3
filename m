Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BB5277CD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiEONSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 09:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiEONSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 09:18:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C793165C3;
        Sun, 15 May 2022 06:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E50DB80B43;
        Sun, 15 May 2022 13:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76527C385B8;
        Sun, 15 May 2022 13:18:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lmwJFg1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652620724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MfzdeACKJaUrUayTeP0y27yyQ2kDUsfI8CoTYaoZck=;
        b=lmwJFg1ZobRcn9Hjq8Cu88Wr6thn0XNgHpDhqALFxDPcy9tI16ZzOx3u3iH/DeJXK0SyRn
        nehXGxT0AAk4OzLFBKsXRnvRXjGIpd362KybQPOuIMC9KuQRAUpuOzuVLOOSYYoGlcImyX
        I9BUQF7JmqavjvDYzqBmy+0LReY3m+c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0453a679 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 15 May 2022 13:18:44 +0000 (UTC)
Date:   Sun, 15 May 2022 15:18:42 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] random: remove get_random_bytes_arch() and add
 rng_has_arch_random()
Message-ID: <YoD7hn4yBHE0RYUa@zx2c4.com>
References: <20220514112307.349599-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220514112307.349599-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a heads up, I've got one more of these affecting vsprintf similarly
that I'll post as a reply to this email here when it's ready.

Jason
