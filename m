Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A31156A07A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiGGKxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiGGKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FE257221;
        Thu,  7 Jul 2022 03:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32EA5622DE;
        Thu,  7 Jul 2022 10:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B113C341CB;
        Thu,  7 Jul 2022 10:53:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Kuo/M9df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657191186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0hiP75bywalq4wJilKlgvi8A6ckY7G9OfIHBXYukrA=;
        b=Kuo/M9dfJqc4ZchaoFkxvgAKDC6qHrotNcISSxGj8w/TAIjLGVbjHYVB9tng1J858d5/u7
        xTOgzzWFfIG/1JhP/Qj/E2mboSq0H4eMiO7v8S72hddr0+zvGlgoUAz3o0lGZhqGCmJ4dR
        Ybtcc05oJ0w2SETQHQLKSrey07t/Prs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d3b5aa04 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Jul 2022 10:53:06 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id p13so10810521ilq.0;
        Thu, 07 Jul 2022 03:53:06 -0700 (PDT)
X-Gm-Message-State: AJIora/9epNUg7spD+TwL/8R5TFIAWCPvRvHBJ/eJna9EQ3KU8+j2OLg
        2bRqp82w1BZ25yt19sdYs3htLk2RCEH/gKxfRjg=
X-Google-Smtp-Source: AGRyM1uPG2aPUQGnUtUd1utWCbj/p/OG8HUm8NCM64ilDZ1INtOsvBMn+v+G15oROID8oYLRYjIM7z8FWS+ahoTmFss=
X-Received: by 2002:a05:6e02:20cb:b0:2dc:28d0:b8a5 with SMTP id
 11-20020a056e0220cb00b002dc28d0b8a5mr7727958ilq.160.1657191185406; Thu, 07
 Jul 2022 03:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220707173252.5fff21f2@canb.auug.org.au>
In-Reply-To: <20220707173252.5fff21f2@canb.auug.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 7 Jul 2022 12:52:54 +0200
X-Gmail-Original-Message-ID: <CAHmME9qCTZpRKrvXVDhCGTD6z15BwDFupX0Z5QwhoWCCT2w2Fw@mail.gmail.com>
Message-ID: <CAHmME9qCTZpRKrvXVDhCGTD6z15BwDFupX0Z5QwhoWCCT2w2Fw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the random tree with the powerpc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Jul 7, 2022 at 9:36 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the random tree got a conflict in:
>
>   arch/powerpc/Kconfig
>
> between commit:
>
>   cea9d62b64c9 ("powerpc: Kconfig: Replace tabs with whitespaces")
>
> from the powerpc tree and commit:
>
>   a2ff4b7600cd ("random: remove CONFIG_ARCH_RANDOM")
>
> from the random tree.
>
> I fixed it up (the latter removed some lines updated by the former) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Oh darn. Any clever tricks to prevent the merge conflict from
happening? Or is this trivial enough that we'll let Linus deal with
it?

Jason
