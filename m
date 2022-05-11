Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B151523B12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbiEKRCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiEKRCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:02:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A0264733;
        Wed, 11 May 2022 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qGbO2F4BgGoDa01K+lTe/8HxmdXnwujci0ArhS0FRT8=; b=JUpmsc/qHSdRlsIfTcfeWYxkEZ
        3iA/qnwVbuw8FHxZlWbCoFb5V7vwvxiTxAExDI4kh6ejcKLyu1FpD6K9ZDF+ZgmT7Q5cub6NdzCJt
        2Nwj6wToecfx/xGR1mZiDtjyBTAoP6lLKBFmMcTKMHDVpbKwPaV/8MmlZaGQ6OUsZYck=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nopjG-002Ko2-Cq; Wed, 11 May 2022 19:02:26 +0200
Date:   Wed, 11 May 2022 19:02:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Message-ID: <YnvsInrh03BVh7lN@lunn.ch>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:10:00AM +1200, Chris Packham wrote:
> Describe the compatible properties for the Marvell Alleycat5/5X switches
> with integrated CPUs.
> 
> Alleycat5:
> * 98DX2538: 24x1G + 2x10G + 2x10G Stack
> * 98DX2535: 24x1G + 4x1G Stack
> * 98DX2532: 8x1G + 2x10G + 2x1G Stack
> * 98DX2531: 8x1G + 4x1G Stack
> * 98DX2528: 24x1G + 2x10G + 2x10G Stack
> * 98DX2525: 24x1G + 4x1G Stack
> * 98DX2522: 8x1G + 2x10G + 2x1G Stack
> * 98DX2521: 8x1G + 4x1G Stack
> * 98DX2518: 24x1G + 2x10G + 2x10G Stack
> * 98DX2515: 24x1G + 4x1G Stack
> * 98DX2512: 8x1G + 2x10G + 2x1G Stack
> * 98DX2511: 8x1G + 4x1G Stack
> 
> Alleycat5X:
> * 98DX3500: 24x1G + 6x25G
> * 98DX3501: 16x1G + 6x10G
> * 98DX3510: 48x1G + 6x25G
> * 98DX3520: 24x2.5G + 6x25G
> * 98DX3530: 48x2.5G + 6x25G
> * 98DX3540: 12x5G/6x10G + 6x25G
> * 98DX3550: 24x5G/12x10G + 6x25G

Hi Chris

When looking at this list, is it just the switch which changes, and
everything else in the package stays the same?

I'm thinking back to plain Kirkwood. There were 3 Kirkwood SoCs. We
had kirkwood.dtsi which described everything common to all three
SoCs. And then kirkwood-6192.dtsi, kirkwood-6281.dtsi,
kirkwood-6282.dtsi which extended that base with whatever additional
things each SoC had.

I'm wondering if something similar is needed here?

armada-98DX25xx.dtsi which describes everything common to Alleycat5.

armada-98DX35xx.dtsi which describes everything common to Alleycat5X,
maybe making use of armada-98DX25xx.dtsi?.

armada-98DX2538.dtsi which extends armada-98DX25xx.dtsi

And then a board file which includes armada-98DX2538.dtsi and add the
board specific bits?

I've no idea how these different devices differ, so i don't know what
the correct hierarchy should be.

    Andrew
