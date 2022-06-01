Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3931353B051
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiFAWuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiFAWuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671C2838FD;
        Wed,  1 Jun 2022 15:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 416796106E;
        Wed,  1 Jun 2022 22:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD1EC3411D;
        Wed,  1 Jun 2022 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654123813;
        bh=eTcPXUPLntrWP+xkpFNKvvMCuRc6r4WMKNlzfE0gx6w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VwaGdx1/UcMACPvjO7Yt8wn/SdDk8b+6n55Ytvg1kup70FpVNQs3WMisTRBo1MF8w
         FoUEK3Qq/2Kf5fdG2+IyWDrERtEcNC81TRCY+z/iFvfCZsWdbN4a8bMjmBGact9B4u
         iMN40emmIo0Wzpq/4Kxy7FGpgfQd3gL5ZesSUVIlZ5teNaT3o/utb3RNXQ95mAvW2/
         gvYH039APq64XPa5OXFwAE65XdzE8/fwHT+Y2T3xDKWD7A9FtA3Td3OwF4Quo7XPYW
         8do1GwAF/D/IrozZMz/70EtOHETgnezvGNKVE0bchvfXIrkKi8y2fn8WYjums47ZYW
         CDZMsXyGUZZMQ==
Received: by mail-yb1-f178.google.com with SMTP id i11so5377590ybq.9;
        Wed, 01 Jun 2022 15:50:13 -0700 (PDT)
X-Gm-Message-State: AOAM531m9Pfa6gxcy7UN5ccII6VbZm113j87KXIN1ol7NzCM6vkGbHdy
        lvz5cZ20wiyCPsXM7Lr0gU/TLlF5lJHNUw7BArM=
X-Google-Smtp-Source: ABdhPJw9i1wiFX2U0pSnCMM8P1g5Z6OL4RcUDvSt63kV3sraMgcoZv5+XSzdxQum1wWoYpWNSqsTI6aDUnqlFFaVbGs=
X-Received: by 2002:a25:a242:0:b0:651:a78d:4636 with SMTP id
 b60-20020a25a242000000b00651a78d4636mr2247046ybi.9.1654123812737; Wed, 01 Jun
 2022 15:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220526163604.32736-1-logang@deltatee.com> <20220526163604.32736-13-logang@deltatee.com>
 <YpRdL+2e7gngOYPa@infradead.org> <c59d233a-c0d1-a3cc-3dad-0a5af449ff83@deltatee.com>
 <CAPhsuW56YAwByRKnYDpkbBk1pi01Wdx3NL9yLY2sADWfMmTMeQ@mail.gmail.com> <6605fb80-47c4-3a42-1fde-fbb42886ebc3@deltatee.com>
In-Reply-To: <6605fb80-47c4-3a42-1fde-fbb42886ebc3@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 1 Jun 2022 15:50:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6kRx4c1YudLaAuL2LMrtz4N8FvROXLNtbii5qcEJSarg@mail.gmail.com>
Message-ID: <CAPhsuW6kRx4c1YudLaAuL2LMrtz4N8FvROXLNtbii5qcEJSarg@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] md/raid5-cache: Move struct r5l_log definition
 to raid5-log.h
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 3:42 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2022-06-01 16:36, Song Liu wrote:
> >> I guess we could do that. All the inline functions in raid5-log.h are
> >> there to choose between the r5l or the ppl implementaiton. So it that
> >> would mean the r5l implementation would probably be inlined and ppl
> >> would be doing a second out of line call. Not sure if that matters, but
> >> it seems a little odd.
> >
> > I like the current version better. raid5-log.h is not used in many files anyway.
>
> It's a moot point now. v3 will follow Christoph's other feedback which
> essentially removes the RCU access altogether and adds an appropriate
> lock in a couple places.

Ah, that's right. Thanks for pointing it out.

Song
