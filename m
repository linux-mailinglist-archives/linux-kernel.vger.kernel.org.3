Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146BC50F017
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244147AbiDZFLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiDZFLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:11:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C4F1EFD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:08:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1njDQt-0005ED-SQ; Tue, 26 Apr 2022 07:08:15 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1njDQq-0003DQ-Qn; Tue, 26 Apr 2022 07:08:12 +0200
Date:   Tue, 26 Apr 2022 07:08:12 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: silabs,wfx: add
 prt,prtt1c-wfm200 antenna variant
Message-ID: <20220426050812.GA3419@pengutronix.de>
References: <20220425132844.866743-1-o.rempel@pengutronix.de>
 <20220425132844.866743-3-o.rempel@pengutronix.de>
 <14881918.tv2OnDr8pf@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14881918.tv2OnDr8pf@pc-42>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:58:51 up 26 days, 17:28, 50 users,  load average: 0.06, 0.12,
 0.10
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

On Mon, Apr 25, 2022 at 05:38:20PM +0200, Jérôme Pouiller wrote:
> On Monday 25 April 2022 15:28:42 CEST Oleksij Rempel wrote:
> > Add compatible for wfm200 antenna configuration variant for Protonic PRTT1C
> > board.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/staging/net/wireless/silabs,wfx.yaml     | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml b/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
> > index 105725a127ab..ce107fe45d7c 100644
> > --- a/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
> > +++ b/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
> > @@ -39,6 +39,7 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - prt,prtt1c-wfm200 # Protonic PRTT1C Board
> >            - silabs,brd4001a # WGM160P Evaluation Board
> >            - silabs,brd8022a # WF200 Evaluation Board
> >            - silabs,brd8023a # WFM200 Evaluation Board
> 
> I think you also have to declare this new entry in wfx_sdio_of_match,
> and/or wfx_spi_of_match and wfx_spi_id.
> 
> On the WFM200 variant, the antenna is built in the chip. So I think you
> can point on the same configuration than the brd8023a.

We have attached Molex 47950 antenna on secondary RF output. Is it still
compatible with brd8023a?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
