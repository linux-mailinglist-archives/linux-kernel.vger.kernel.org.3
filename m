Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C356BB6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiGHOC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbiGHOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:02:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D951A386;
        Fri,  8 Jul 2022 07:02:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0841C52AE;
        Fri,  8 Jul 2022 14:02:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0841C52AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657288973; bh=wSpnYxDKlFB0S/OcW2eFZmHCzB6IpCnff31hbX//2zI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Gzmx5KU/wYdL1A7UoLseIPA/r6GW9pdGKU5mVPltm6/PizYT0x++9s838oxckhRkW
         8cPE74vw83rOUWlJmwyo9Sokm7S4f4wRiKFMExEzTDPiylj4rQqbJ2CM099Xc2z0ZR
         k+wyjXFFLpBFXGBHcakbRPR5YuUROAothLDC4MpcamuEjQKFCF/pknuJSfdWZpbQGJ
         lxczEBtsfT+g1CrzxFx+0J9kqsLim3A8w8JNx7h764y6XNxr35i6sxjgzrte54D80E
         vmItzuiP/+edCGIq3pHIURrxRcQnhE0TtqH9lPOZVSu2pB9P6YUccCp2DrNdbldKqR
         O/zoRIjYcCRBA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: Expectation to --no-pdf option (was Re: [PATCH v2 0/5] Address
 some issues with sphinx detection)
In-Reply-To: <3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
 <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
 <20220707211558.438a27d4@sal.lan>
 <3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com>
Date:   Fri, 08 Jul 2022 08:02:52 -0600
Message-ID: <87bktzhfcj.fsf@meer.lwn.net>
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

> In my tests, the mathjax extension works with all the versions of Sphinx
> I tested (1.7.9, 2.4.4, 3.4.3 (debian bullseye), 4.2.0 (openSUSE LEAP 15.4),
> and 5.0.2).
> Note that math expressions should look much sharper (vector fonts)
> than those from imgmath (pixel images).
> The time for a browser to complete the rendering might be longer than
> with imgmath, especially for pages with a lot of math expressions,
> though.  (Yes, I see some of media documents have a lot of them.)
>
> When you are detached from network connections, browsers will give
> up and show those expressions in mathjax source code.

Pulling in a bunch of JavaScript from the net while browsing the kernel
docs is not an entirely pleasing solution either.  But perhaps it's
preferable to loading the system with Latex.  I kind of wish we could
just do without the fancy math processing entirely, but I lost that
battle some time ago...:)

Mauro, have you looked at that option?

Thanks,

jon
