Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB04B7B63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbiBOXv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:51:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiBOXv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:51:27 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68A9C4E25;
        Tue, 15 Feb 2022 15:51:16 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A5425385;
        Tue, 15 Feb 2022 23:51:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A5425385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1644969076; bh=ZwrJOQk8NdUvo/m4mnIZFlRPYRE2tqMlnMhJ4JIH8HI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=B3xDknRz4Yl8nmYPHskW/HxwaksROl2Hnay6VEtoHCtgAIbC1Wx1qz/xWQ3Xaock9
         WVabbuSBZXcchmkML7uHnacKjjJiVHSdlYpreI3efs6JTLFr71lQDQUHSZI0KBfuxh
         Ym/mjMioRZa7ZIVQ2rjnnIkK52dQ1smA8qUDb9WyR1e/bI2uCG+MCWZRus0RhtsQ/y
         N1qOgmdl29iGNFpSq/HlRbP65BXNaEI63HA81aVGPBHjbrOmw1fdboswRUBDy/YWph
         8EyDyASmDqAHjSpfkXW/bQEoDyc1p3Ap9N5drx5EK6zQqgrGu66kVvh4d3GPNee/Gz
         DDR8WIXvU8XLg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: Major kernel-doc rework
In-Reply-To: <20220205233945.7a4d22d8@fuji.fritz.box>
References: <20220205233945.7a4d22d8@fuji.fritz.box>
Date:   Tue, 15 Feb 2022 16:51:15 -0700
Message-ID: <87v8xf664s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> This is in fact a release notification of a major kernel-doc script
> refurbishment I have done. My work has reached a stage, which can be
> considered a world sync point and here we are.
>
> I'm not sending all the patches to the Linux mailing list, as I prefer
> to check what you think before I emit about 500 emails.
>
> I've parked the lot for you to inspect here:
> https://salsa.debian.org/guest/kernel-doc
>
> This also helps me report the bug fixes. See the issue tracker:
> https://salsa.debian.org/guest/kernel-doc/-/issues

So I have done you a disservice with this work; I've been distracted and
it has languished.  I apologize.  It's at the top of the list and will
be the next thing I put some serious attention to.

Thanks,

jon
