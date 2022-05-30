Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3358E53760D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiE3HxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiE3Hws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:52:48 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22639B9E;
        Mon, 30 May 2022 00:52:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24U7q00J053169;
        Mon, 30 May 2022 02:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653897120;
        bh=GOkPamMIZ3jld+xujzsh/azHiUlDUfOHBpiekpCg6Dw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vn8s/5WsQEQcXZulxrJBn4tgSQLi4jjCXGJaTY4lyA49xfx4bqh6Jiw+lKECDBe7F
         wFshlawKO+bSQ/NGuVBCMaTw6nYEKeM4NyEs2uqw4g8PdrAbC5qo0R+xiVoKFdD0cr
         zq7CaDWdjRM3CtsoZWDGNGtiSvcoOn4nKnPXYRHE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24U7q06q074500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 May 2022 02:52:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 30
 May 2022 02:52:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 30 May 2022 02:52:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24U7pxvU054752;
        Mon, 30 May 2022 02:51:59 -0500
Date:   Mon, 30 May 2022 13:21:58 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: ti,j721e-system-controller: Add
 clock property
Message-ID: <20220530075157.43rbptnpgqqtbdho@uda0490373>
References: <20220530073429.17514-1-r-ravikumar@ti.com>
 <20220530073429.17514-2-r-ravikumar@ti.com>
 <6c14aa95-00c4-960b-d71a-3967096f19cb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c14aa95-00c4-960b-d71a-3967096f19cb@linaro.org>
User-Agent: NeoMutt/20171215
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

On 09:37-20220530, Krzysztof Kozlowski wrote:
> On 30/05/2022 09:34, Rahul T R wrote:
> > Add a pattern property for clock, also update the example with
> > a clock node
> > 
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> >  .../bindings/mfd/ti,j721e-system-controller.yaml       | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > index fa86691ebf16..290b22cab52f 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > @@ -48,6 +48,10 @@ patternProperties:
> >      description:
> >        This is the SERDES lane control mux.
> >  
> > +  "^clock@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
> > +
> 
> Thanks for the changes, but the question what is this remains. Clock
> consumers use "clocks" property. Is this a clock controller (provider)
> instead?
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Yes, this is a clock provider node, I will add the
correct description and will also update the
example with a clock consumer node that is using
a clock from this

That should be enough right?

Regards
Rahul T R
