Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F84EB0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiC2Pdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiC2PdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:33:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D05F1207EC;
        Tue, 29 Mar 2022 08:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C19B60EDF;
        Tue, 29 Mar 2022 15:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EFEC2BBE4;
        Tue, 29 Mar 2022 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648567885;
        bh=YEzE/YcpvqqkcMmxUt5/89JnyfIyasWtNCTkrpB/nTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGliDUx1XpLBTY+M1+jN/YhNuNDMIM4RV751BM/0ANbsgCKbza8Gehf6xf8u613Rq
         7fpofgTcZUopDwAS6kDSwxkKv2OFfqz+0lawL/vcw7Ap0vjmK0a53DEf1xO+LwVF/j
         6DNqkFAis10JEUtSzt+QjaSTSzYM64fD3EEKkgvjFPLnoCZfRCRS8JR9k6zLFzE66k
         uqznO/ah1xpYmcjNm1mBm695rxfYXDKptHbdr6faQBaXCy8+Rk0vZK8qDx+/SjHNug
         LKob2/v5EEGNS7KVGP5bPFwM7MIxNj8apHaIm+IFh8N3UtE2tNtNfUmwSEpY8cbLv/
         yDEnIbazRlQNA==
Date:   Tue, 29 Mar 2022 21:01:14 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Grzegorz Szymaszek <gszymaszek@short.pl>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable
 DMA LLI
Message-ID: <20220329153114.GA58120@thinkpad>
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com>
 <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:26:01AM +0100, Yann Gautier wrote:
> On 3/14/22 23:43, Linus Walleij wrote:
> > "On Fri, Mar 4, 2022 at 2:52 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
> > 
> > > On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> > > starting from revision v2 of the peripheral. But it has limitations,
> > > as all the buffers should be aligned on block size (except the last one).
> > > But this cannot be guaranteed with SDIO. We should then have a property
> > > to disable the support of LLI.
> > > 
> > > Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> > 
> > Actually I think this is present also on the ux500 variants. See:
> > commit 2253ed4b36dc876d1598c4dab5587e537ec68c34
> > "mmc: mmci: Support any block sizes for ux500v2 and qcom variant"
> > 
> > Spot the variant data "dma_power_of_2".
> > 
> > So whatever property you add
> > to the variant data (not in the device tree please) should
> > be added to the ux500 variants as well, it will *VERY* likely
> > have a problem with LLI elements not being a power of 2
> > as it is the ancestor of later STMicro variants.
> > 
> > It might actually be the reason for some annoying WiFi error
> > messages I have seen :/
> > 
> > Yours,
> > Linus Walleij
> 
> Hi Linus,
> 
> The STM32 variant uses an internal DMA, and the DMA functions are in its
> dedicated file. So I was planning to do the same as what is done in
> meson-gx-mmc.c: using a bounce buffer to copy from/to in case DMA
> constraints are not fulfilled. Not sure it can help for Ux500.
> 

Irrelevant to this patch: May I know why the internal DMA cannot be represented
as a dmaengine driver? We started seeing these internal DMA implementations in
the other subsystems as well with pointers towards MMC core [1].

Thanks,
Mani

[1] https://lore.kernel.org/all/CA+V-a8tfUgvzPyMe_FHuz=8mmC6dPHP7E=e+nCzOey04vCcAkg@mail.gmail.com/

> Ulf, before I send my new series (although it is not ready yet), would you
> be OK with the bounce buffer idea?
> 
> 
> Best regards,
> Yann
