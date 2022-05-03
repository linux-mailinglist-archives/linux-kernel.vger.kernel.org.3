Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2242351905D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbiECVmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243040AbiECVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:42:15 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7B941981;
        Tue,  3 May 2022 14:38:41 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 11698100002;
        Tue,  3 May 2022 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651613920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4e7Sv65BlxtfCAwzzTiuAVRpHIHdlis0/EJW+hJswEM=;
        b=X7S2yyiEWsrUJc/EzPA6b/XIba4Qkz6NHaXC8NYel22mP41XVCzF/J7ygJzIgYT6txCoNa
        s0gX4c+AS8TNumhap7CnxoqFib11natedG1Bz9jkLkN88NmbsUsQP377V5aa7GqrIu2DWF
        xMUvoBc1N8yJa1jRQ0k4Vff5AuOMlItYoIgOkZCe0IQP7p8cPgj5ljWT5TUDVeIcx0FUFm
        FdNXeN9YVL/HsWGaN+uiv6UPSuvNw+vHL6xT4RRvTrWZhuag7kOS35ctN2S/NHibJHN0wV
        9uOKfdVGcImQ5swSW6FxxbvJUJs5nTmSsa+Zxay29uVNpfOD5ChZtIuIKiFGfQ==
Date:   Tue, 3 May 2022 23:38:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema
Message-ID: <YnGg31lPwxAQOUtg@mail.local>
References: <20220422192236.2594577-1-robh@kernel.org>
 <CAL_Jsq+t5e-Dr0z9Zd_+jaqwb1afEVx4SdjbQZA4bHpWf8a2jg@mail.gmail.com>
 <YmMD3RPXfPdiYXyg@mail.local>
 <Ymb61YHl62AfSe2R@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymb61YHl62AfSe2R@robh.at.kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 14:47:33-0500, Rob Herring wrote:
> On Fri, Apr 22, 2022 at 09:37:01PM +0200, Alexandre Belloni wrote:
> > On 22/04/2022 14:28:53-0500, Rob Herring wrote:
> > > On Fri, Apr 22, 2022 at 2:22 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > Convert the Synopsys Designware I3C master to DT schema format.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../bindings/i3c/snps,dw-i3c-master.txt       | 41 ---------------
> > > >  .../bindings/i3c/snps,dw-i3c-master.yaml      | 52 +++++++++++++++++++
> > > >  2 files changed, 52 insertions(+), 41 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> > > > deleted file mode 100644
> > > > index 07f35f36085d..000000000000
> > > > --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> > > > +++ /dev/null
> > > > @@ -1,41 +0,0 @@
> > > > -Bindings for Synopsys DesignWare I3C master block
> > > > -=================================================
> > > > -
> > > > -Required properties:
> > > > ---------------------
> > > > -- compatible: shall be "snps,dw-i3c-master-1.00a"
> > > > -- clocks: shall reference the core_clk
> > > > -- interrupts: the interrupt line connected to this I3C master
> > > > -- reg: Offset and length of I3C master registers
> > > > -
> > > > -Mandatory properties defined by the generic binding (see
> > > > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
> > > > -
> > > > -- #address-cells: shall be set to 3
> > > > -- #size-cells: shall be set to 0
> > > > -
> > > > -Optional properties defined by the generic binding (see
> > > > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
> > > > -
> > > > -- i2c-scl-hz
> > > > -- i3c-scl-hz
> > > > -
> > > > -I3C device connected on the bus follow the generic description (see
> > > > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details).
> > > > -
> > > > -Example:
> > > > -
> > > > -       i3c-master@2000 {
> > > > -               compatible = "snps,dw-i3c-master-1.00a";
> > > > -               #address-cells = <3>;
> > > > -               #size-cells = <0>;
> > > > -               reg = <0x02000 0x1000>;
> > > > -               interrupts = <0>;
> > > > -               clocks = <&i3cclk>;
> > > > -
> > > > -               eeprom@57{
> > > > -                       compatible = "atmel,24c01";
> > > > -                       reg = <0x57 0x0 0x10>;
> > > > -                       pagesize = <0x8>;
> > > > -               };
> > > > -       };
> > > > diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> > > > new file mode 100644
> > > > index 000000000000..5b8b43e6f1e4
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> > > > @@ -0,0 +1,52 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/i3c/snps,dw-i3c-master.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Synopsys DesignWare I3C master block
> > > > +
> > > > +maintainers:
> > > > +  - Vitor Soares <vitor.soares@synopsys.com>
> > > 
> > > And it bounces. Someone else want it?
> > > 
> > 
> > Probably no one but me.
> 
> Can you change it to yourself when applying?
> 

Done!


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
