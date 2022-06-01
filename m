Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A897539C99
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349648AbiFAFaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349634AbiFAFaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:30:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5C9D076;
        Tue, 31 May 2022 22:30:00 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2515Tss8017693;
        Wed, 1 Jun 2022 00:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654061394;
        bh=c/qfL2l2VIstbzo6BSYmwSI3H4BLd61De5L9vlVUu48=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ib0f/EqhVEn/uwxrtRGT9OE2E17RQbRkgykD9BSc2lC0mCCWHS6qljvioN6v1QyXc
         ZOkQj7e/uXLn/j1UW1qPaIA4xD8VVZov2m63+XcwdglIOHTFrSpvi77R2Ii132ff+0
         BdC2FrcnYf/DWjN/5Vg8ZZtGc+UCqk7lLeNNqhxk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2515TrGE096664
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jun 2022 00:29:53 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 1
 Jun 2022 00:29:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 1 Jun 2022 00:29:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2515TqQJ123375;
        Wed, 1 Jun 2022 00:29:53 -0500
Date:   Wed, 1 Jun 2022 10:59:52 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Move 'rx-sample-delay-ns' to
 spi-peripheral-props.yaml
Message-ID: <20220601052952.4htn4ycta2dkvd3l@ti.com>
References: <20220525210053.2488756-1-robh@kernel.org>
 <20220526054642.zw44mgw2bd2u5v76@ti.com>
 <20220526135404.GA3831942-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220526135404.GA3831942-robh@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/22 08:54AM, Rob Herring wrote:
> On Thu, May 26, 2022 at 11:16:42AM +0530, Pratyush Yadav wrote:
> > Hi Rob,
> > 
> > On 25/05/22 04:00PM, Rob Herring wrote:
> > > SPI bus per device properties must be defined in spi-peripheral-props.yaml
> > > for unevaluatedProperties checks to work correctly on device nodes.
> > > 
> > > This has the side effect of promoting 'rx-sample-delay-ns' to be a
> > > common property, but functionally it's no different if it was defined in
> > > a Synopsys specific schema file.
> > 
> > Functionally it is no different, but does this property make sense for 
> > other controllers? If not then I don't see why we should pollute the 
> > common list with controller-specific ones. For one, this now no longer 
> > makes it obvious that this property should only be used with the 
> > Synopsys controller. And if you keep making small exceptions for other 
> > controllers too, soon the common list will be full of controller 
> > properties and it will be a mess finding out what belongs to who.
> 
> There's at least one other case already:
> 
>   cdns,read-delay:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     description:
>       Delay for read capture logic, in clock cycles.
> 
> 
> Too many common properties is not a problem we have. Too many custom 
> properties doing the same thing is the problem.

I agree. But in this case these two properties have different units. 
rx-sample-delay-ns is obviously in nanoseconds. cdns,read-delay is in 
number of ref clock cycles. If other controllers also use this property, 
it could make sense to make rx-sample-delay-ns the default/common 
property and drivers can then make conversions between the units that 
should actually be programmed.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
