Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884EE50C31B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiDVWNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiDVWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:13:05 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CF020E3BC;
        Fri, 22 Apr 2022 14:00:43 -0700 (PDT)
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 5F921C6661;
        Fri, 22 Apr 2022 19:37:43 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B2CAEE0003;
        Fri, 22 Apr 2022 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650656223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xEfZcA39m5S9yD0fiH+ykU7GDg99hDzHx1O9tp4Ow2M=;
        b=BzQSzp3u9K4ucupEsK4/XLhEm7hdXJOdS5okj18TvD9MkdsJ8qUbak9Cde2Wtx1ARNJSI8
        xFPqsW+Unb7kxkC10v17qyUA5vYDJTQVz914siOYH2krxt1uchm8P0TzWCciz7v58FQBP7
        f+GjimnxkFcLulPtJY6OQc/p3YhMq9vVEwV5jua9HAoi25tUS+T45ncZ7yubxOWmrCIjUL
        qQHG1M/xDnCHL0xCadWQ7guMhKjjFtTV+OXAbrNGNAWV1JTEtWmaeSTL5qgL0QARxAAkHc
        YZPcIBFZOuBgy/+fzn2qb4LFaj074E8ey6L/v7eDcLapZeaYdfD4OHeF0LaNgQ==
Date:   Fri, 22 Apr 2022 21:37:01 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema
Message-ID: <YmMD3RPXfPdiYXyg@mail.local>
References: <20220422192236.2594577-1-robh@kernel.org>
 <CAL_Jsq+t5e-Dr0z9Zd_+jaqwb1afEVx4SdjbQZA4bHpWf8a2jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+t5e-Dr0z9Zd_+jaqwb1afEVx4SdjbQZA4bHpWf8a2jg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 14:28:53-0500, Rob Herring wrote:
> On Fri, Apr 22, 2022 at 2:22 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Convert the Synopsys Designware I3C master to DT schema format.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/i3c/snps,dw-i3c-master.txt       | 41 ---------------
> >  .../bindings/i3c/snps,dw-i3c-master.yaml      | 52 +++++++++++++++++++
> >  2 files changed, 52 insertions(+), 41 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> >  create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> > deleted file mode 100644
> > index 07f35f36085d..000000000000
> > --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> > +++ /dev/null
> > @@ -1,41 +0,0 @@
> > -Bindings for Synopsys DesignWare I3C master block
> > -=================================================
> > -
> > -Required properties:
> > ---------------------
> > -- compatible: shall be "snps,dw-i3c-master-1.00a"
> > -- clocks: shall reference the core_clk
> > -- interrupts: the interrupt line connected to this I3C master
> > -- reg: Offset and length of I3C master registers
> > -
> > -Mandatory properties defined by the generic binding (see
> > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
> > -
> > -- #address-cells: shall be set to 3
> > -- #size-cells: shall be set to 0
> > -
> > -Optional properties defined by the generic binding (see
> > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
> > -
> > -- i2c-scl-hz
> > -- i3c-scl-hz
> > -
> > -I3C device connected on the bus follow the generic description (see
> > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details).
> > -
> > -Example:
> > -
> > -       i3c-master@2000 {
> > -               compatible = "snps,dw-i3c-master-1.00a";
> > -               #address-cells = <3>;
> > -               #size-cells = <0>;
> > -               reg = <0x02000 0x1000>;
> > -               interrupts = <0>;
> > -               clocks = <&i3cclk>;
> > -
> > -               eeprom@57{
> > -                       compatible = "atmel,24c01";
> > -                       reg = <0x57 0x0 0x10>;
> > -                       pagesize = <0x8>;
> > -               };
> > -       };
> > diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> > new file mode 100644
> > index 000000000000..5b8b43e6f1e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i3c/snps,dw-i3c-master.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DesignWare I3C master block
> > +
> > +maintainers:
> > +  - Vitor Soares <vitor.soares@synopsys.com>
> 
> And it bounces. Someone else want it?
> 

Probably no one but me.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
