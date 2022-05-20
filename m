Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2803652F160
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352067AbiETRMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349009AbiETRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:12:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73402AE257;
        Fri, 20 May 2022 10:12:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653066761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXErZRvqjldlOjMLvYU3NoT+xSCUsvtODzyjR+hi/KQ=;
        b=ki5HV+5SMfm4IW2KWiNtM52ROQelC40IiS5IeIL5TATYlDYpQ9g9tyUXXR1Z2BuqzmdMkz
        ezwT5jcatnoxu5SQwfGec4kDly0oKUI0zgZL/3YndE3561BmL4VUoo2VAKVsNB7ajQINXt
        ClOZG9fY1TuKWe0MBSryzWQQaQoa/paK+uIwlkP78bEbXdlgUU8a2OxqJ3h2ag1t+PlE4j
        AddhYqcDkl9lgWqn7w0+jaGybczGfp3DM3ZXhf15/jGHNOQM/4rs3df5f50cItGrGoc6F2
        IYD28ddfFMCyhLtg8TiLgQoXyxTQodanT4QDV1tB/6ZyBX6Zkl9ChRrzAYStuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653066761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXErZRvqjldlOjMLvYU3NoT+xSCUsvtODzyjR+hi/KQ=;
        b=tWWe4JQBKfAEuyKQdjb0m7AbWmmbUcUBvoFtxz9DMtesd4zCdY0VYnZT+F0a7CgDDPqITK
        wci0PPZY57hQIECg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] siphash: add SPDX tags as sole licensing authority
In-Reply-To: <20220518132345.40615-1-Jason@zx2c4.com>
References: <20220518132345.40615-1-Jason@zx2c4.com>
Date:   Fri, 20 May 2022 19:12:41 +0200
Message-ID: <87v8u0i0vq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18 2022 at 15:23, Jason A. Donenfeld wrote:
> The text "dual BSD/GPLv2 license" is somewhat ambiguous, and moving this
> over to SPDX is overdue. This commit adds SPDX tags to the relevant
> files and clarifies that it's GPLv2 only and 3-clause BSD. It also
> removes the old text, so that the SPDX tags are the only source of the
> information.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
