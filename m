Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848404F6E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiDFXZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiDFXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:25:50 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BAF6C1E7;
        Wed,  6 Apr 2022 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8Tr0WGyvMrQMt+EjpEp3gg9RonkOaYU/ypqpop9zD0Y=; b=3/G4WViF61ZPur49VqH8DJ/jdV
        BEucAW+jSVcV910j7GIKUtDova5EfTRbSkx5e0LNGihTmAkKJ83PglsNF48/G+7iZJEMJBmn9EF9c
        WBu+NRUYOulLaKhN/YX8Oe6s8LylN6gWeCaYcywiQFa8frbizh8ZyxGlzF6PaEyBJTXc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ncF01-00EX4U-RG; Thu, 07 Apr 2022 01:23:41 +0200
Date:   Thu, 7 Apr 2022 01:23:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <Yk4g/ShFxNsCM8JR@lunn.ch>
References: <20220406032158.1449049-1-chris.packham@alliedtelesis.co.nz>
 <20220406032158.1449049-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406032158.1449049-4-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:21:57PM +1200, Chris Packham wrote:
> The 98DX2530 SoC is the Control and Management CPU integrated into
> the Marvell 98DX25xx and 98DX35xx series of switch chip (internally
> referred to as AlleyCat5 and AlleyCat5X).
> 
> These files have been taken from the Marvell SDK and lightly cleaned
> up with the License and copyright retained.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

> +&eth0 {
> +	status = "okay";
> +	phy = <&phy0>;

This is O.K, but most DT files now use phy-handle, not phy.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
