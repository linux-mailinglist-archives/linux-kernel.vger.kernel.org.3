Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F64BA6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiBQREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:04:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiBQREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:04:39 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD399207565;
        Thu, 17 Feb 2022 09:04:24 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 882C89A2;
        Thu, 17 Feb 2022 17:04:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 882C89A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645117464; bh=7yI7eNlBEA3Kgl9clAQBNuaZ7/DvcyD/YbJxoPU4uJA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YGOTmOvzxAvCyfI3pnrs2/f+IvHClKI+/uQVShpeotismozv273VSKUofYhvZhh7l
         SRf/GCcQnMKUfN7iYA/1fsftEMk6UaSQWLSgNvDGvfXCTeLE2zrc34Voip9yEC/PNh
         Hxo/EvzzwDHnbAZoLjdE/OJhcqYdWxp0yHYRFjM2CUzwyT6ure++V1ckRm6EAEi4RF
         nUO23rTPKeEkFENaLrGLm1/ZEIZcf0ezXcNuRKX0FLKn4OZUse5cxEgybevHScobLq
         zXISXKvedXnpWZnbQJ530QGTZzzYffPamfBPf/txiS89/jOvBnIZVa1h4YKGWsk56c
         PfiZWczQWn0Ww==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] scripts: kernel-doc: Major kernel-doc rework
In-Reply-To: <20220217163247.03e37c9b@fuji.fritz.box>
References: <20220205233945.7a4d22d8@fuji.fritz.box>
 <8735ki2x62.fsf@meer.lwn.net> <20220217163247.03e37c9b@fuji.fritz.box>
Date:   Thu, 17 Feb 2022 10:04:23 -0700
Message-ID: <87bkz51l2g.fsf@meer.lwn.net>
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

> I will prepare the POD part. As for the rest, you will need a porter if y=
ou
> decide this is the way to go. I could help with explanations if something=
 is
> unclear and as long as the questions come soon. The winter is almost over=
 and
> I need to switch to other activities like earning money.

Understood.

> I understand. I didn't know there was a rewrite. I'm not into Python, but
> if you could post a link, I'd take a look out of curiosity.
>
> If the community prefers Python, what can I say about this? Their choice.

This is the kernel community you're talking about - saying that it
prefers any language (except possibly C) is asking for big-time trouble
:)

*I* prefer Python, and the Sphinx side of things is necessarily in
Python, so I'd be happy to see kernel-doc move over.  That said, others
certainly disagree.

Markus's work was here:

  https://lore.kernel.org/lkml/1485287564-24205-1-git-send-email-markus.hei=
ser@darmarit.de/

At the time, we were just trying to get the RST transition done, and
swapping out the kernel-doc script seemed like a major distraction that
we didn't need, so this never got looked at as seriously as I would have
liked.

> Personally, I'd rather play with translating this script to Raku (aka
> Perl 6).

Trying to add yet another language dependency is another path to
unhappiness, we're not going to go there.

Thanks,

jon
