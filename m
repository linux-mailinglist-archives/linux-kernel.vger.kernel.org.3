Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8C4571AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiGLNFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGLNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:05:42 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5CE33A28;
        Tue, 12 Jul 2022 06:05:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DDEB22B2;
        Tue, 12 Jul 2022 13:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DDEB22B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657631141; bh=QTFaaFfrmflBfN2tiPMpqSNmnH8IeA/fkfWvf4+Z6SM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O9ktPBSph9PmD4wdt38ZJz8NisWq7wufs/AOPcMJ1YeK52889vEPQo5xBWEIp9eMj
         GNqEx1/kzx7IIig1+Xsam5nnR+a9ilxVFaqEp9WQTDgIw33DzuvhdPqBWTVnynElpB
         4KMoo+UninwEJlRYGz6bxPV+dBL2dFlL+yX9WvLbkrsm9aq4AwmKQMjDXdbaaWpPLC
         PrDIdtnUOfx7Eap310fAWvETx6U8QfPNirt6/7nXMZn0ntpBxaTWkyJP9PsWimoLyL
         B6j6/oYY/HUDn3OFxcZneVDa4NTVA5YmVy3rYK2HRRVDmHuF4s4QNZFDHTZuuXWraq
         PEMrj7nh93v0A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dov Murik <dovmurik@linux.ibm.com>, linux-doc@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] Documentation: siphash: Fix typo in the name of
 offsetofend macro
In-Reply-To: <20220712104455.1408150-1-dovmurik@linux.ibm.com>
References: <20220712104455.1408150-1-dovmurik@linux.ibm.com>
Date:   Tue, 12 Jul 2022 07:05:40 -0600
Message-ID: <87fsj6bhwb.fsf@meer.lwn.net>
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

Dov Murik <dovmurik@linux.ibm.com> writes:

> The siphash documentation misspelled "offsetendof" instead of
> "offsetofend".
>
> Fixes: 2c956a60778cbb ("siphash: add cryptographically secure PRF")

When you send a patch with a Fixes tag it's always a good idea to CC the
author of the patch being fixed.  Adding Jason...let me know if you'd
like me to grab this.

> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> ---
>  Documentation/security/siphash.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/security/siphash.rst b/Documentation/security/siphash.rst
> index a10380cb78e5..023bd95c74a5 100644
> --- a/Documentation/security/siphash.rst
> +++ b/Documentation/security/siphash.rst
> @@ -85,7 +85,7 @@ Often times the XuY functions will not be large enough, and instead you'll
>  want to pass a pre-filled struct to siphash. When doing this, it's important
>  to always ensure the struct has no padding holes. The easiest way to do this
>  is to simply arrange the members of the struct in descending order of size,
> -and to use offsetendof() instead of sizeof() for getting the size. For
> +and to use offsetofend() instead of sizeof() for getting the size. For
>  performance reasons, if possible, it's probably a good thing to align the
>  struct to the right boundary. Here's an example::
>  
> -- 
> 2.25.1

Thanks,

jon
