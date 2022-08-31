Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370685A7616
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiHaF71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiHaF7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:59:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F36BB91C;
        Tue, 30 Aug 2022 22:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B914DB81DB8;
        Wed, 31 Aug 2022 05:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED23C433D6;
        Wed, 31 Aug 2022 05:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661925561;
        bh=Sv3zrf8KpU3BGK4FJ/+tlCbwePgRoRrP5taWOD3/2+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2rhMHT910chZUzsj3qTfbIH9GrGHu+shU1QikKSgpzDqxio25Bqv8B8iiic25z4I
         FJvLkINmr2jNuUon6kXF6ezUAQA9CNTzY6Y+aEUIyR4/GVGJq8DRTbivrqLMbPNOyN
         AlgISojOPSJAl17j+nYDHi5gFP+P7IaTMVl7QPiM=
Date:   Wed, 31 Aug 2022 07:59:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kewei Xu <kewei.xu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        qii.wang@mediatek.com, liguo.zhang@mediatek.com,
        caiyu.chen@mediatek.com, david-yh.chiu@mediatek.com
Subject: Re: [PATCH v2 1/1] dt-binding: serial: mediatek,uart: update
 bingding for MT8188
Message-ID: <Yw74yHdI8lDLG4+u@kroah.com>
References: <20220809084457.31381-1-kewei.xu@mediatek.com>
 <f8a391de-dd47-1eb9-0e15-e6a651517a6f@gmail.com>
 <b77553ac2c9c934abcf3b5e5b5083ad695584c42.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b77553ac2c9c934abcf3b5e5b5083ad695584c42.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:03:37AM +0800, Kewei Xu wrote:
> On Wed, 2022-08-24 at 15:59 +0200, Matthias Brugger wrote:
> > 
> > On 09/08/2022 10:44, kewei.xu@mediatek.com wrote:
> > > From: Kewei Xu <kewei.xu@mediatek.com>
> > > 
> > > Add a DT binding documentation for the MT8188 soc.
> > > 
> > > Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
> > 
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > 
> > > ---
> > > v2: Resumbit the patch based on the linux-next branch.
> > > ---
> > >   Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> > > b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> > > index 4ff27d6d4d5b..fe098d98af6e 100644
> > > --- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> > > @@ -42,6 +42,7 @@ properties:
> > >                 - mediatek,mt8173-uart
> > >                 - mediatek,mt8183-uart
> > >                 - mediatek,mt8186-uart
> > > +              - mediatek,mt8188-uart
> > >                 - mediatek,mt8192-uart
> > >                 - mediatek,mt8195-uart
> > >                 - mediatek,mt8516-uart
> 
> Hi gregkh,
> 
> Just a gentle ping on this.
> Could you please give me some suggestion on this patch?

It's still in my "todo" queue.  It's going slower as you didn't cc: the
serial mailing list so when I processed all of those pending patches, I
did not catch it.  Give it some time, it will get there eventually...

thanks,

greg k-h
