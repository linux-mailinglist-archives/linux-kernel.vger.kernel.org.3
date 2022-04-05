Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186DF4F4A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457022AbiDEWq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457598AbiDEQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:14:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D43140FF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:12:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649175125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNm+9V5x8K8pd4DpHAVUkys7MPqoZfGpc+Mw3U+A+aU=;
        b=jioPHs0UCLFhqN7mVdCqSP7fCBRnzbhqBo0Kq/KZVudoOiR1evP5vnBBLeUwNNcIRhPlhN
        z7FCe3CHlCupgjZ2pXxToigM+GBxAWwtokajRe1/mQtCVGOo9MTeT7LoU8eQlnFWkV6xvS
        oephkeMIX5xpu4VyBs3UVK5Pif3NfSvQpWu50/j9qA3410d+HmRyHaCTl5u7lmgevvuJbm
        h3cWlybGUPs+205qwNL6cqMVUPOzAKt/LDMGjU9El0U75PSOl8mTjonlP23hj/9hk0gwvZ
        RS6rnLnuUMRipnrndM/sxhAuct0FznT2rzzI1AwASrVIm29woJk6sXuGZiwLEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649175125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNm+9V5x8K8pd4DpHAVUkys7MPqoZfGpc+Mw3U+A+aU=;
        b=P8R+/+Q0099wdlG5pYMKgeC0QKYV+ZuRgZ5f5AkfC4kexLzSWLKcaJ4UacxzxOgZSIeTRY
        aQmRLSW2iLH4rSAA==
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH 0/4] x86-32: Clean up GS segment handling
In-Reply-To: <20220325153953.162643-1-brgerst@gmail.com>
References: <20220325153953.162643-1-brgerst@gmail.com>
Date:   Tue, 05 Apr 2022 18:12:04 +0200
Message-ID: <87y20j1pd7.ffs@tglx>
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

On Fri, Mar 25 2022 at 11:39, Brian Gerst wrote:
> Since commit 3fb0fdb3bbe ("Make the canary into a regular percpu
> variable"), the GS segment is no longer switched on kernel entry for
> 32-bit kernels.  Clean up the remaining code that handled lazy GS
> switching.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
