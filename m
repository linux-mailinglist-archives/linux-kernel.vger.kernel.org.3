Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0B552AC23
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352834AbiEQTlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352958AbiEQTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:41:46 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F47135A80;
        Tue, 17 May 2022 12:41:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B82CC2ED;
        Tue, 17 May 2022 19:41:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B82CC2ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652816503; bh=vc/mJB154ai0SSpGlWahmWov7w9vRHD/u4MB2x7MD0s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QVtajxX9Ui4rJWwE94scwj+Ns42KZggGfOmFffQuBplqmcoMGkGJfsvNJqvVt9pla
         CBh4oJcE4uc8Fz8iz5x3kIOmz0cqhnAGOnxcrLldfq5fTYvybXWx4r5Ha5GP3nJMzq
         UDWnxTELudspMNDjPBTW/MgdjXvTIEilGLIA0x5GWrlqtrxLGljs4nfklw7EgIAtMZ
         zejvFNYYdc7ba+LbJXQ6PLSPYnyW0mPNegwTfB5oV+oLLDJNN0UhG1z8PCOSM9dCLC
         sN9tYm+a8UwNxVN9kak8c/5txM1iiSjk57BTjpkhOxRwTp7+a0lWh03vu6ln8XJZZE
         Zkz5sD/BkLphQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: pdfdocs: Add space for chapter counts >= 100 in TOC
In-Reply-To: <bdb60ba3-7813-47d0-74f9-7c31dd912d95@gmail.com>
References: <bdb60ba3-7813-47d0-74f9-7c31dd912d95@gmail.com>
Date:   Tue, 17 May 2022 13:41:43 -0600
Message-ID: <87h75ouetk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> It turns out that networking.pdf has exceeded 100 chapters and
> titles of chapters >= 100 collide with their counts in its table
> of contents (TOC).
>
> Increase relevant params by 0.6em in the preamble to avoid such
> ugly collisions.
>
> While at it, fix a typo in comment (subsection).
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
>  Documentation/sphinx/kerneldoc-preamble.sty | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

jon
