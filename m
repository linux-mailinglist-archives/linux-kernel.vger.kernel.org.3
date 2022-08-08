Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029558CF40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiHHUjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiHHUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD809596;
        Mon,  8 Aug 2022 13:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FEE60C63;
        Mon,  8 Aug 2022 20:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88607C433D6;
        Mon,  8 Aug 2022 20:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659991172;
        bh=bOsZl8AcXb7mOFin6B3q83VOzh/KjSu7QJBidaDPK/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVVq7nQ09hqex1SsBRtyBQ4G0DVWHOX9y4wVMS+M3xx0lWasENUMZ7yRLa4j5edt6
         EkbdXOhjrYEX6vcNqiU7dU+6O7kQE54LKQrgX08EbQQddxMLQlzRMdpJVD2wMmj4cU
         6n3IYP9YQXJHE9ltQmHCc0mMX56HoBsImnGMOJBMlSFfXz7fyDz7jbx+10de61nTVN
         3RBnGH42xDxHy/nTsgvf1Om0tsLNdIeHIqphuNcChEFmbJqhNTYWgAt/juggZrTGsM
         aC52pKN7GuKYXYZ2LnZrJCEsWiaLVmWTJql5/3TRb7gJ4BAl/ezgKK4hjesV6G2F1Y
         /Sy1ED9lJnnnw==
Received: by pali.im (Postfix)
        id A08BFF13; Mon,  8 Aug 2022 22:39:29 +0200 (CEST)
Date:   Mon, 8 Aug 2022 22:39:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <20220808203929.ci4eardma3jwnroc@pali>
References: <20220713125644.3117-1-pali@kernel.org>
 <20220808202456.lpwvhq22edb56ptf@pali>
 <YvFzGhBRPTXgdCd8@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvFzGhBRPTXgdCd8@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 August 2022 22:33:30 Andrew Lunn wrote:
> On Mon, Aug 08, 2022 at 10:24:56PM +0200, Pali Rohár wrote:
> > PING?
> 
> It is too late for the merge window.
> 
> > > diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > index 5ce55bdbb995..02ae1e153288 100644
> > > --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > @@ -13,7 +13,7 @@
> > >  
> > >  / {
> > >  	model = "Marvell Armada 3720 SoC";
> > > -	compatible = "marvell,armada3720", "marvell,armada3710";
> > > +	compatible = "marvell,armada3720", "marvell,armada3700";
> 
> Does it make sense to have a compatible here? The board .dts should
> provide it. And if the board does not provide it, we probably want the
> board to not boot because it does not have a compatible.
> 
>    Andrew

Sounds like there should not be a compatible string and model string.

I can prepare a followup patch to remove those strings from SoC dtsi file.
