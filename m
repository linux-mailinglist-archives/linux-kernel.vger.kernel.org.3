Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6C250F69C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbiDZIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbiDZInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:43:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898815A431
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:33:19 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1njGdD-0005tm-O2; Tue, 26 Apr 2022 10:33:11 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1njGd7-0008VO-GE; Tue, 26 Apr 2022 10:33:05 +0200
Date:   Tue, 26 Apr 2022 10:33:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: silabs, wfx: add prt,
 prtt1c-wfm200 antenna variant
Message-ID: <20220426083305.GA17577@pengutronix.de>
References: <20220425132844.866743-1-o.rempel@pengutronix.de>
 <14881918.tv2OnDr8pf@pc-42>
 <20220426072113.GC3419@pengutronix.de>
 <4686508.cEBGB3zze1@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4686508.cEBGB3zze1@pc-42>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:28:02 up 26 days, 20:57, 80 users,  load average: 0.09, 0.18,
 0.31
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:19:29AM +0200, Jérôme Pouiller wrote:
> On Tuesday 26 April 2022 09:21:13 CEST Oleksij Rempel wrote:
> > On Mon, Apr 25, 2022 at 05:38:20PM +0200, Jérôme Pouiller wrote:
> > > On Monday 25 April 2022 15:28:42 CEST Oleksij Rempel wrote:
> > > > Add compatible for wfm200 antenna configuration variant for Protonic PRTT1C
> > > > board.
> > > >
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > ---
> > > >  .../devicetree/bindings/staging/net/wireless/silabs,wfx.yaml     | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml b/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
> > > > index 105725a127ab..ce107fe45d7c 100644
> > > > --- a/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
> > > > +++ b/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
> > > > @@ -39,6 +39,7 @@ properties:
> > > >    compatible:
> > > >      items:
> > > >        - enum:
> > > > +          - prt,prtt1c-wfm200 # Protonic PRTT1C Board
> > > >            - silabs,brd4001a # WGM160P Evaluation Board
> > > >            - silabs,brd8022a # WF200 Evaluation Board
> > > >            - silabs,brd8023a # WFM200 Evaluation Board
> > >
> > > I think you also have to declare this new entry in wfx_sdio_of_match,
> > > and/or wfx_spi_of_match and wfx_spi_id.
> > >
> > > On the WFM200 variant, the antenna is built in the chip. So I think you
> > > can point on the same configuration than the brd8023a.
> > 
> > I assume driver update can be made in a separate patch. As soon as we
> > reserved compatible for this boards there should be no conflicts. This patches
> > series is targeting only devicetree and needed DT schema changes.
> 
> hmmm... I am not DT specialist, but it seems a bit weird to have a new
> entry in the dt schema, but no new code in any of_match table. 

Here is one example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml?h=v5.18-rc4#n28
properties:
  compatible:
    oneOf:
      - const: fsl,imx1-cspi
      - const: fsl,imx21-cspi
      - const: fsl,imx27-cspi
      - const: fsl,imx31-cspi
      - const: fsl,imx35-cspi
      - const: fsl,imx51-ecspi
      - const: fsl,imx53-ecspi
      - items:
          - enum:
              - fsl,imx50-ecspi
              - fsl,imx6q-ecspi
              - fsl,imx6sx-ecspi
              - fsl,imx6sl-ecspi
              - fsl,imx6sll-ecspi
              - fsl,imx6ul-ecspi
              - fsl,imx7d-ecspi
              - fsl,imx8mq-ecspi
              - fsl,imx8mm-ecspi
              - fsl,imx8mn-ecspi
              - fsl,imx8mp-ecspi
          - const: fsl,imx51-ecspi

httpt://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-imx.c?h=v5.18-rc4#n1063
static const struct of_device_id spi_imx_dt_ids[] = {
	{ .compatible = "fsl,imx1-cspi", .data = &imx1_cspi_devtype_data, },
	{ .compatible = "fsl,imx21-cspi", .data = &imx21_cspi_devtype_data, },
	{ .compatible = "fsl,imx27-cspi", .data = &imx27_cspi_devtype_data, },
	{ .compatible = "fsl,imx31-cspi", .data = &imx31_cspi_devtype_data, },
	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
	{ .compatible = "fsl,imx6ul-ecspi", .data = &imx6ul_ecspi_devtype_data, },
	{ /* sentinel */ }
};

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
