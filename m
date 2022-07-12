Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493FB571DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiGLPE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiGLPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:03:17 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE46E093;
        Tue, 12 Jul 2022 08:00:02 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id u20so8050896iob.8;
        Tue, 12 Jul 2022 08:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yEnL/KIgKCXSzN8Ltrj7vvOsqZOeF/KHqy5gLlC4xaE=;
        b=FgkQqrjDC1D2wMLqVg7JUHwRcUrtQ6kSNR1EJ8aN7fmNa1o5ogpTTULlJE4iZK5zhj
         5kQWhI3HA0Qm5uR3gtsVkR9ym6J4D2DLXdRCbVgt/uiTFnGfR2I519j8rSdzrYhnpaQ6
         tPMLDpNF6qu9/6/iSl86bwvFeZyPhMaqSspU7sl/Jqz+XhlzWWXNlF4dqjTEcIULbtTf
         lkQfAxlLE+P5c0JJLVCv9SXVtEFnSC5XAiJ7VoOJ8GZPXb7YCrLNnVWlSAYkE+ZSO1A3
         7sXe4pRb/YlO1kkkgkjK0TfkJCJ29tzfGjIdi3k3AHY3SZRRX5dJZ9PWLuIH/hKIbgop
         Bnyw==
X-Gm-Message-State: AJIora/Dh7Hg6Hd37XTZcV+nbpE8m+EWx0iFDZAtdvDvNiqcXuytVuk7
        td9qztT8PmYcrQvUDARed4Eym9kxBA==
X-Google-Smtp-Source: AGRyM1srwAoh9+nd31Kl3lWr+FwP4VX3QljvAhk93cCuGk7a5QOtzDblJssDYK7XMfHSAc4aFnUi2Q==
X-Received: by 2002:a6b:103:0:b0:67b:731c:86a5 with SMTP id 3-20020a6b0103000000b0067b731c86a5mr11644464iob.76.1657637998864;
        Tue, 12 Jul 2022 07:59:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l19-20020a056e02067300b002dc0c1b8edbsm3820209ilt.83.2022.07.12.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:59:58 -0700 (PDT)
Received: (nullmailer pid 1851041 invoked by uid 1000);
        Tue, 12 Jul 2022 14:59:57 -0000
Date:   Tue, 12 Jul 2022 08:59:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi
 pinctrl bindings
Message-ID: <20220712145957.GB1823936-robh@kernel.org>
References: <20220629091716.68771-1-srinivas.kandagatla@linaro.org>
 <20220629091716.68771-2-srinivas.kandagatla@linaro.org>
 <20220630210848.GA3295428-robh@kernel.org>
 <864aac78-d3a4-0008-345f-d210582b100e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864aac78-d3a4-0008-345f-d210582b100e@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 11:06:18AM +0100, Srinivas Kandagatla wrote:
> thanks Rob,
> 
> On 30/06/2022 22:08, Rob Herring wrote:
> > On Wed, Jun 29, 2022 at 10:17:15AM +0100, Srinivas Kandagatla wrote:
> > > Add device tree binding Documentation details for Qualcomm SM8450
> > > LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 138 ++++++++++++++++++
> > >   1 file changed, 138 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
> > > new file mode 100644
> > > index 000000000000..b49d70b9ba9a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
> > > @@ -0,0 +1,138 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
> > > +  Low Power Island (LPI) TLMM block
> > > +
> > > +maintainers:
> > > +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > +
> > > +description: |
> > > +  This binding describes the Top Level Mode Multiplexer block found in the
> > > +  LPASS LPI IP on most Qualcomm SoCs
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: qcom,sm8450-lpass-lpi-pinctrl
> > > +
> > > +  reg:
> > > +    minItems: 2
> > > +    maxItems: 2
> > 
> > What is each entry?
> 
> These are tlmm and slew register base address.
> 
> This has been like this in previous bindings for sm8250 and sc7280 lpi
> binding.

There's always bad examples to follow.
 
> Are you suggesting that we should add a description for reg for more
> clarity?

Well, 2 descriptions:

items:
  - description: ...
  - description: ...

Rob
