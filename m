Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD00513B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351050AbiD1Sc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiD1Scy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:32:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59DBB92C;
        Thu, 28 Apr 2022 11:29:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7B4DD2BD;
        Thu, 28 Apr 2022 18:29:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7B4DD2BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651170577; bh=43cdOEsVWETBTp+jLybdKavmf9Zu8s0U30w1o0k+M0U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rJ1NZsg5X4SQCR/NcAY+iFUHcKmmi3b2wkg2o7WOY3B2QIX24ejy3MT5OrwpBAgRz
         IuU8VfLO2AR8kOLqMTAR5/rXfl+0iTemfIENQS6KQ1H8ZfQkg+oUT4s3U/NSMFGiKL
         ClfKBzep/4H862Qz6pHL+S0ua1Dzl5eu/B6qhe1LZHDCrGcOp4/69zjaQuDCq68I1b
         yxOKDFae9jxyHBQT1aPy3XDLxnzfiMHtAv8IhImZuOqghHXGfGF6whz0OCzydAzLHH
         L/LJjzSVgfmEEGA/SvABAzCue1K5kEhLPerVb6GIlNfgzhoF5a/wkGz0nsYRPgk3I5
         fYrphbpdxiT0w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: Fix crossref to 'The
 canonical patch format'
In-Reply-To: <64e105a5-50be-23f2-6cae-903a2ea98e18@gmail.com>
References: <64e105a5-50be-23f2-6cae-903a2ea98e18@gmail.com>
Date:   Thu, 28 Apr 2022 12:29:36 -0600
Message-ID: <87bkwl6oz3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> The reference to `explicit_in_reply_to` is pointless as when the
> reference was added in the form of "#15" [1], Section 15) was "The
> canonical patch format".
> The reference of "#15" had not been properly updated in a couple of
> reorganizations during the plain-text SubmittingPatches era.
>
> Fix it by using `the_canonical_patch_format`.
>
> [1]: 2ae19acaa50a ("Documentation: Add "how to write a good patch summary" to SubmittingPatches")
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Fixes: 5903019b2a5e ("Documentation/SubmittingPatches: convert it to ReST markup")
> Fixes: 9b2c76777acc ("Documentation/SubmittingPatches: enrich the Sphinx output")
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: stable@vger.kernel.org # v4.9+
> ---
>  Documentation/process/submitting-patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
