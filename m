Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF811537572
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiE3Hdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiE3HdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:33:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712496396;
        Mon, 30 May 2022 00:33:22 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24U7X78F084352;
        Mon, 30 May 2022 02:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653895987;
        bh=ExBnzLiYFVziL0l+DfDaFgwz3sYIoqI8Aw25L0RFvvA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AnTbvWQX7WUXCiDp/9JEGkTBI3hvIJo+70oDNeNLwMbnneXuzQCKyh5omrnL/C0pw
         uFz0zB7vvLsUkZIXgvtmmRI0SO+hbPwAqtwl6JYXMgdI8fuAT9kI23qQ04Mz6m9BB8
         ncZgBNGZfV0FLkBFHkPvNwJoMdGkdfYdoxXudlho=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24U7X7lC064595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 May 2022 02:33:07 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 30
 May 2022 02:33:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 30 May 2022 02:33:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24U7X5SF097044;
        Mon, 30 May 2022 02:33:06 -0500
Date:   Mon, 30 May 2022 13:03:05 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: mfd: ti,j721e-system-controller: Add
 clock property
Message-ID: <20220530073304.strqmcwbbixqjrdu@uda0490373>
References: <20220527083556.18864-1-r-ravikumar@ti.com>
 <20220527083556.18864-2-r-ravikumar@ti.com>
 <0b561964-5718-ab1e-34c3-07eadae5b04e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0b561964-5718-ab1e-34c3-07eadae5b04e@linaro.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:14-20220529, Krzysztof Kozlowski wrote:
> On 27/05/2022 10:35, Rahul T R wrote:
> > Add a pattern property for clock, also update the example with
> > a clock node
> > 
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> >  .../bindings/mfd/ti,j721e-system-controller.yaml     | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > index fa86691ebf16..e774a7f0bb08 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > @@ -48,6 +48,12 @@ patternProperties:
> >      description:
> >        This is the SERDES lane control mux.
> >  
> > +  "^clock@[0-9a-f]+$":
> > +    type: object
> > +    $ref: ../clock/ti,am654-ehrpwm-tbclk.yaml#

Thanks Krzysztof,

Will address the review comments and send a v2
of this

Regards
Rahul T R

> 
> Full path please, so /schemas/clock/.......
> 
> > +    description:
> > +      This is TI syscon gate clk.
> 
> Don't use "This is". Just describe it without need of full sentence.
> "syscon gate clock" is a bit unspecific and actually looks like you
> describe "clocks" property...
> 
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -79,5 +85,11 @@ examples:
> >                  <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
> >                  /* SERDES4 lane0/1/2/3 select */
> >          };
> > +
> > +        ehrpwm_tbclk: clock@4140 {
> 
> No need for label.
> 
> > +                compatible = "ti,am654-ehrpwm-tbclk", "syscon";
> 
> Messed up indentation.
> 
> > +                reg = <0x4140 0x18>;
> > +                #clock-cells = <1>;
> > +        };
> >      };
> >  ...
> 
> 
> Best regards,
> Krzysztof
