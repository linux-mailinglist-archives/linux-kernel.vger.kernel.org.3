Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1F4BCE3A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 12:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbiBTLlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 06:41:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiBTLls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 06:41:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCC333E00;
        Sun, 20 Feb 2022 03:41:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDDF661147;
        Sun, 20 Feb 2022 11:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9280DC340E8;
        Sun, 20 Feb 2022 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645357287;
        bh=mcf/nbUtt3kQFwvUjXM7DJ/iXY1xk8mILVycvz100A0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VWqZBTm5MjNelia8nPtrWJB7kv+8eiyNRzrUSKZijx2sYExSMtRgiJe+Ujq9LkS3H
         z31VagRuYh/bGNAtdxNfB3dzK40ktNj+LxUWy7YM767Zk/sznUXRvXwEe6EnAoMsP+
         fzRIp8aFqOqUbpjL9OQ5/Y36ltjLpVZRXtGR9Y1EpXZatihDZisxsHDYHjoLw9c6Ya
         MMeuVaNbDBt/uIbSyUzeNq7q8Xuty3Q69/MUt+kPmmEGguXPIX/WD0LgQjPuYnEN4a
         D45FQSppQIkSoKU3Kj8SaFxfcKyp4IlzmUb+JcxuN2biH4XD8OqhVT2wq8GPVbU0gm
         GswiMi1RCLd1A==
Date:   Sun, 20 Feb 2022 11:48:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings:iio:amplifiers: add ada4250 doc
Message-ID: <20220220114816.50a57225@jic23-huawei>
In-Reply-To: <69cc2a64-c273-f2f6-b25b-73fc2248bb18@canonical.com>
References: <20220214094115.48548-1-antoniu.miclaus@analog.com>
        <20220214094115.48548-2-antoniu.miclaus@analog.com>
        <69cc2a64-c273-f2f6-b25b-73fc2248bb18@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2022 11:53:55 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> On 14/02/2022 10:41, Antoniu Miclaus wrote:
> > Add device tree bindings for the ADA4250 driver.  
> 
> Please put the bindings patch as first in the series.
> 
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  .../bindings/iio/amplifiers/adi,ada4250.yaml  | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> > new file mode 100644
> > index 000000000000..22283ab48903
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/amplifiers/adi,ada4250.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ADA4250 Programmable Gain Instrumentation Amplifier
> > +
> > +maintainers:
> > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +description: |
> > +  Precision Low Power, 110kHz, 26uA, Programmable Gain Instrumentation Amplifier.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ada4250
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  avdd-supply: true  
> 
> Needs a description, not a true.

For a generic supply where all we really have is a name, I'm not sure
a description adds anything.  Of course, if there is more info that can be provided
a description is great to have.

> 
> As Jonathan said, you should allow spi-max-frequency (so
> spi-max-frequency: true).
> 
> No io-channel-cells?

I'm not sure you'd have a consumer of this type of device, so
it may not make sense...

> 
> > +
> > +  adi,refbuf-enable:
> > +    description:
> > +      Enable internal buffer to drive the reference pin.
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - avdd-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      ada4250@0{  
> 
> Generic node name, so "amplifier".
> 
> > +        compatible = "adi,ada4250";
> > +        reg = <0>;
> > +        avdd-supply = <&avdd>;
> > +      };
> > +    };
> > +...  
> 
> 
> Best regards,
> Krzysztof

