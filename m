Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765F84B0115
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiBIXPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:15:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiBIXPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:15:35 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FB4E0542B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:15:23 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s185so4198747oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 15:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ktkjxd3U0JmlaFnaNcBberOjA7QvY7xZY4GMDZF6GTs=;
        b=rT3vggge4MvLAYz8ehb1gDHsIZQ2jYCjwcS7hvkQ4ulgYOQ+OvFiB4kq2Xz/bnyGIq
         hQ65+ocP8xocxt8jz9ZixNlEAgKq/sdXbO64IZ9j5DovrQIPVczcuJyb/l7BwWEP5t52
         G50Kdx96U8b442xnWvePHyAahkttBkSzzlk7CYZWbvZa0pyU9Wz8NcNhe5CajSA4wYTr
         YRg2E5b3ANb1+cLPrYfySKkeaDYhrrx/ex/zQxYrwWv3s+rVbynh9+II2kuWkyg+/B+5
         ueJRH9wrgNv7liccRp58MR6VN7yvOm+4AfMpc+jDoXQBZ597Kq2GxP9XVugN3eUtN8KB
         6klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktkjxd3U0JmlaFnaNcBberOjA7QvY7xZY4GMDZF6GTs=;
        b=ppqw2V11hRDYmpzKoNJyRS9CHom5lkd5tF4qtyodPAzKfB47sii63/o8iJI/U+YD6a
         goMrCBY2PzatPL1/6PBjR7OiZvbX0/x0x2uYvK2lIrUQ+UDIl53lBDt4rJ6HYgWDEo3q
         dvR03lqCnn+rphUHn/BYv9+DcRG7SXSgnpMvkQsIVZr5kTrIC/O+qI2wR6gT0sEN+0l8
         ofr8ZwIZ1HR/9eJ9EScO1XgkUvfGYlGbaShnPhIgnJ35zeh3fLv9jdbvYmdaaXSxTXHQ
         ksqqSrdHoSY6WDEgxVSWg2qZgadaW3t4m6ZelnCU82ivvpcJcYur9BIW24oJTcdU5MAW
         2Dqg==
X-Gm-Message-State: AOAM530R8x8ZYqBeNPjJESjPDwQvbE11XA6U6dU70MktYv+SaWJAENn4
        gf/+i3YC5sSMb1oL2tj4egb/1g==
X-Google-Smtp-Source: ABdhPJwSwIG6P4P9VqVnQt3T5UfuEZz7hxUA4IZtMOLvLySVMm87BKO4mFMFZWwtpNO+Ms2lI8o/kw==
X-Received: by 2002:a05:6808:1897:: with SMTP id bi23mr2151901oib.217.1644448522445;
        Wed, 09 Feb 2022 15:15:22 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id c29sm7147074otk.16.2022.02.09.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:15:21 -0800 (PST)
Date:   Wed, 9 Feb 2022 15:17:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: add qcom,tcsr bindings
Message-ID: <YgRLkrowk56YtjtY@ripper>
References: <20220122001609.15904-1-ansuelsmth@gmail.com>
 <20220122001609.15904-2-ansuelsmth@gmail.com>
 <Yfhzqvrj6bIPmV2S@builder.lan>
 <Yfmq3IpjHZXdtEQR@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfmq3IpjHZXdtEQR@Ansuel-xps.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01 Feb 13:49 PST 2022, Ansuel Smith wrote:

> On Mon, Jan 31, 2022 at 05:41:30PM -0600, Bjorn Andersson wrote:
> > On Fri 21 Jan 18:16 CST 2022, Ansuel Smith wrote:
> > 
> > > Add qcom,tcsr-ipq8064 and qcom,tcsr-ipq4019 Documentation for the
> > > tcsr present in ipq8064 and ipa4019 required to configure and
> > > set various peripherals present in the SoC.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/soc/qcom/qcom,tcsr-ipq4019.yaml  | 93 +++++++++++++++++++
> > >  .../bindings/soc/qcom/qcom,tcsr-ipq8064.yaml  | 47 ++++++++++
> > >  2 files changed, 140 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
> > > new file mode 100644
> > > index 000000000000..3a82ccbb6588
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
> > > @@ -0,0 +1,93 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/soc/qcom/qcom,tcsr-ipq4019.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Qualcomm Top Control and Status Registers binding for IPQ4019
> > > +
> > > +maintainers:
> > > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > > +
> > > +description: |
> > > +  This binding describes the Qualcomm Top Control and Status Registers, used
> > > +  for accessing configuration and mux settings for a variety of peripherals
> > > +  for ipq4019.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: qcom,tcsr-ipq4019
> > > +      - const: syscon
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  qcom,usb-hsphy-mode-select:
> > > +    description: Select usb hsphy mode for ipq4019
> > 
> > Why isn't this driven by the USB node, where I presume you otherwise
> > need to duplicate this decision?
> > 
> 
> From what I understand this is global, setting this will apply on any
> usb present.
> 
> > Is this platform not capable of OTG?
> > 
> 
> I assume it's capable by selecting the correct mode using tcsr.
> 

I expect that the USB controller will receive extcon (or
usb_role_switch) requests to flip between the modes based on something.

When this happens it sounds like the USB controller would have to
propagate that change to the TCSR bits as well, and if the USB
controller driver is able to flip the bits then this shouldn't be needed
here?

Regards,
Bjorn
