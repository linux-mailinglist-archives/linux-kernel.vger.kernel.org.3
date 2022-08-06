Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7258B73B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiHFRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFRK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 13:10:58 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Aug 2022 10:10:55 PDT
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CF6F5A2;
        Sat,  6 Aug 2022 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1659805455; bh=q4ABFkCbSH96OqX58TPcyYOM49oSlhTNadDmH/B85F4=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=sEFTyfKX9sQOeJMwWcvpgLUSFDljZ4ZPhLANt4SFBBEQqj87NkeVwlM3T2HiBtHRN
         po+JJ1bGn0sgZJQRCbb5JiPM/DLzfsYWlZODKmrZsfDwGNABshy/90xETXAstplq2T
         9kDvdPATIMER9wVtfGZYYGAaLhO76/wzTIj9Sm/Q=
Date:   Sat, 6 Aug 2022 19:04:14 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Caleb Connolly <kc@postmarketos.org>
Cc:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Message-ID: <20220806170414.qogs4ad2mooluxie@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Caleb Connolly <kc@postmarketos.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
 <f9cbc047-f30f-e711-3213-56fcbb7bbc8a@postmarketos.org>
 <9a168a20-1fd1-5d73-1d33-bd2f054d60d7@tom-fitzhenry.me.uk>
 <eb4327d0-b31b-b6ea-e0d3-d5cff3508f39@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb4327d0-b31b-b6ea-e0d3-d5cff3508f39@postmarketos.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb and Tom,

more below.

On Sat, Aug 06, 2022 at 03:58:17PM +0100, Caleb Connolly wrote:
> On 06/08/2022 03:37, Tom Fitzhenry wrote:
> > On 6/8/22 12:10, Caleb Connolly wrote:
> > > According to the link below (and my own knowledge of PPP
> > > development) Kamil is the original author of this patch, both Kamil
> > > and Martijn created the initial version of the devicetree. Given
> > > that you're using their work as a base, Kamil's authorship should be
> > > respected in the patch you submit.
> > 
> > I agree authorship is important, and thus Kamil, Martijn and Megi are
> > listed as Co-developed-by in this patch.
> To be clear, by authorship I mean literally the author of the patch, the
> previous patch in this series was created by Samuel and you left his
> authorship intact - it has "From: Samuel Dionne-Riel
> <samuel@dionne-riel.com>" at the top, so when a maintainer picks it up and
> it ends up in Linux, anyone looking at it will see that he was the author of
> the patch.
> 
> This patch is from you, there is no From: tag overriding it, and the
> diffstat in your cover letter shows you as the author. Whilst you have
> obviously made some heavy changes to this patch, it isn't your original work
> as you state yourself in the commit message. Authorship should be attributed
> to Kamil as they are the author of the earliest version of this patch we
> have.
> > 
> > > Their original patch [2] contained SoBs from them and Martijn, those
> > > are both missing below. Both of their signed-off-by tags should be
> > > added before this patch hits the mailing list, and the same for
> > > Ondrej. The order also seems wrong (Ondrej should be last before
> > > you).
> > 
> > Yes, this patch's acceptance is blocked until all Co-developed-by
> > authors (Kamil, Martjin, Megi) provide their Signed-off-by to this
> > patch.
> You should obtain SoBs from Co-developers /before/ sending this patch
> upstream, this indicates that everyone is on board and that the patch has
> some sensible history. The mailing list isn't the place to ask your
> co-developers to sign off a patch after you've made extensive changes to it.

Looks like there's some confusion here, that I may have added to at some
point by a bit of patch squashing, and some SoB tag creativity. ;)

Let me try to clear it up a bit, since it's my squashed patch this discussion
and this submission is based around. Patch [2] you're linking to is not an
original patch by Martijn or Kamil.

It's just a squashed bunch of patches that I took from a secret repo that Kamil
shared with me once upon a time, so that I can help with kernel development and
camera support for Pinephone Pro about a year ago, when it was still a secret
thing.

*AFAIK*, original patches in the secret repo were never published by authors,
but only through my squashed patch from my kernel tree. All the prior work seems
to be either in unlisted git repos, or in login gated git repos.

So hereby I give my Signed-off-by: Ondrej Jriman <megi@xff.cz> for the patch
[2] this submission by Tom was developed from, stating that to the best of my
knowledge:

1) Original author is Martijn Braam and "Fuzhou Rockchip Electronics Co., Ltd".
   Kamil Trzciński extended the Martijn's original DT with some things that are
   mostly stripped off in this submission, other than a few oneliners and the
   gpio power key node. I also have maybe one or two lines in this submission.
2) Original work was published under MIT or GPL2.0+
3) Original work is missing copyright header from Rockchip and any SoB on the
   patches. I have added the SoB for Martijn/Kamil myself without asking them.
   Sorry for that. And I guess this is the source of some confusion here, too.

That should cover the requirement b) of "Developer’s Certificate of Origin 1.1"
which should be all that's necessary.

So now that we have all the needed SoB for the base patch, and Tom already has
SoB for his modifications, all the Co-developed-by are in place, and copyright
notices from original authors are untouched in the code, except for Rockchip,
the way forward should be to re-add missing:

  Copyright (c) 2021 Fuzhou Rockchip Electronics Co., Ltd

to the code and add my SoB to the commit message. That should make the
provenance of this code clear and properly accounted for.

SoB from Martijn would be nice to have, just to reassure about the Rockchip
copyright, which I assume authored the Android factory kernel code/DT. But I'm
presonally quite sure this code is MIT/GPL2.0+, regardless.

------

If you want more details, then here is the original patch series from the secret
repo: https://megous.com/git/linux/log/?h=ayufan-secret/pinephone-pro

Martijn's original patch as taken over by Kamil is
https://megous.com/git/linux/commit/?h=ayufan-secret/pinephone-pro&id=9f1a4867c21a9fa88177bd0903bdc1d82e213310
It has Martijn's copyright and is published under GPL2.0+ OR MIT. This is the
earliest available code this all is based on.

It will sure have some history, too, given that almost all of rk818 node content
matches the decompiled Android factory image's device tree to the
T and that's like 50% of the code in this submission. :) That's where my guess
that the original patch is missing Rockchip's copyright is comming from.

Android DT was never published in code form for all I know. I guess that's what
we get for requiring DT be licensed under MIT license. Some Rockchip engineer
likely wrote half of this submission. Rockchip copyright is thus probably
missing from the patch. Decompiled DT here: https://megous.com/dl/tmp/01_dtbdump_rockchip,android.dts

Kamil seems to have these changes in this submission:

https://megous.com/git/linux/commit/?h=ayufan-secret/pinephone-pro&id=30976b1d8b7c7958474bd54fc86db79ba11d7a17
https://megous.com/git/linux/commit/?h=ayufan-secret/pinephone-pro&id=28b33d187f6b8dd672115e69a19d8d9a6725c834
https://megous.com/git/linux/commit/?h=ayufan-secret/pinephone-pro&id=083d7b514a7ac0e97a18bf4012259f4d9fa37733
https://megous.com/git/linux/commit/?h=ayufan-secret/pinephone-pro&id=bbc9ca6051500baf28296908d92286ff1c4087e0
(just the power key part)

kind regards,
	Ondrej


> I missed the following points in my original email:
> 
> Please read the documentation on modifying patches [1] as it applies here,
> and add a comment before your SoB explaining your changes, something like
> 
> [tom: strip down to minimal booting DT for initial support]

These rules are for subsystem maintainers. At least it says so on top.

> This way the history of the patch is preserved properly for anyone looking
> back at it in the future. In a similar vein, replace the external git links
> with links to exact commits so they don't degrade over time.

