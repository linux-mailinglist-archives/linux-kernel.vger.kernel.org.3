Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8614EA0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbiC1Tzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbiC1Tzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:55:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5591621B2;
        Mon, 28 Mar 2022 12:53:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 941752C5;
        Mon, 28 Mar 2022 19:53:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 941752C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648497189; bh=ONULqGmtMUWWbttEH/Vl1fBy4iTesXGNMQPuHZjxh/Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FoqvfXypvS0k+BSKMsjFStWsc62fKTATKc236zi5+RJcVpaucT/xgTuryeA1rQDCa
         CKFCazt+7jUG4MF5WUKIuVX92liyb8pir4HqULUMr/hEqDvJlSLPvMHqM5sxarpJ7v
         u6nqJB/Ns4BcuZ5/7bKNdbXQryJ0nYNiaPFNNyGOebRixuXlr/K63si3Hj9NHq+PLO
         2U6nurD7Xc5GdlebiNel55TgnjyxS5rt7gx9Rxu2GKRDHLYXRRWw0NpEv7XCU+u80I
         quXuqR7aXQ93NtHnTmentep3YLPq1T1L3YIDCVTkRoo4tqlWg7aOx1SqEhuVnThwBZ
         kCt8g3Lj7Xt1Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: kfigure.py: Don't warn of missing PDF converter
 in 'make htmldocs'
In-Reply-To: <c80e1481-10d4-7151-fe59-e846259eb0d4@gmail.com>
References: <c80e1481-10d4-7151-fe59-e846259eb0d4@gmail.com>
Date:   Mon, 28 Mar 2022 13:53:08 -0600
Message-ID: <87zgl97t23.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> SVG -> PDF conversion is not required in "make htmldocs".
> It is pointless to always warn of a missing converter.
> Demote the log message in setupTools() to verbose.
>
> For "make pdfdocs" (or "make latexdocs"), promote the dynamic
> message of "include SVG raw" to a warn.
> Expand the message and recommend installing Inkscape or
> ImageMagick.
>
> Fixes: 8ccd05697a9d ("docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion")
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/sphinx/kfigure.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

jon
