Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF96545105
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbiFIPig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiFIPib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:38:31 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240F261B21;
        Thu,  9 Jun 2022 08:38:29 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id a10so22488486ioe.9;
        Thu, 09 Jun 2022 08:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aciXCtRvsxNKm3QmZmc3M0v0OBWtOSC2RTKujD1oQSI=;
        b=3qxSM+DXLw3wOXAQp2xZcWHbC1LFjUdtWc9JUVnc/FMI1pcMcr1iQvNyPYVKP9+bE+
         3bqTEXpq8/eCBjMqa8bxUryP4RZPQ50M8cZ5CRaj2taqn+4EYdVbGYt3p/t1RAGw3Lcp
         X3ufvLJed9x/GMZSCH+/yqgU5anBvFv+G4PtF9SXLt/TRvA9A+wxyqWzjAAZFRKCDkY6
         9Aev88iHWSJ9b/HBu67GDJtKVxgHq3iJPd+QuLWqc7TqWEEv8UqSp8fta1Hu0w+AhLlf
         vdwqWpMxDcpd9YpkABxQ6P7LhIaG/HPWj2FnNBIcMAIMWHC5S1XoK9+0hcJJvCQOt+Tl
         ncNw==
X-Gm-Message-State: AOAM531PxKWXwBRUC8ghcmsXplzVHRKFQSEmLjpOIdiRf15LlewkeJcC
        EIzQYyxBI1RBjIgdyrqfSw==
X-Google-Smtp-Source: ABdhPJw+fKj2cdpkgrJfuThrcRw2G3NRMDlKW2cVvanp6oQx+IZghhceQJwGMUbp3UQ57biVIVIyAg==
X-Received: by 2002:a05:6638:1607:b0:331:bcef:784d with SMTP id x7-20020a056638160700b00331bcef784dmr9883034jas.208.1654789109229;
        Thu, 09 Jun 2022 08:38:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m12-20020a02c88c000000b0032e40f3e40dsm8678909jao.124.2022.06.09.08.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:38:28 -0700 (PDT)
Received: (nullmailer pid 3840834 invoked by uid 1000);
        Thu, 09 Jun 2022 15:38:26 -0000
Date:   Thu, 9 Jun 2022 09:38:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Message-ID: <20220609153826.GA3828657-robh@kernel.org>
References: <1654709787-23686-1-git-send-email-quic_harshq@quicinc.com>
 <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
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

On Wed, Jun 08, 2022 at 11:06:25PM +0530, Harsh Agarwal wrote:
> Added support for multiport, mport, num_usb2_phy and num_usb3_phy
> properties. These properties are used to support devices having
> a multiport controller.
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml         | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index d41265b..9332fa2 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -343,6 +343,32 @@ properties:
>        This port is used with the 'usb-role-switch' property  to connect the
>        dwc3 to type C connector.
>  
> +  multiport:

Again, I don't think this is going to play well if you need to describe 
USB devices in your DT. For example, a USB hub with additional DT 
properties.

> +    description:
> +      If a single USB controller supports multiple ports, then it's referred to as
> +      a multiport controller. Each port of the multiport controller can support
> +      either High Speed or Super Speed or both and have their own PHY phandles. Each
> +      port is represented by "mport" node and all the "mport" nodes are grouped
> +      together inside the "multiport" node where individual "mport" node defines the
> +      PHYs supported by that port.
> +
> +  num_usb2_phy:
> +    description: Total number of HS-PHYs defined by the multiport controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  num_usb3_phy:
> +    description: Total number of SS-PHYs defined by the multiport controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  mport:
> +    description: Each mport node represents one port of the multiport controller.
> +    oneOf:
> +      - required:
> +        - usb-phy

This is deprecated. Why are you adding it?

> +      - required:
> +        - phys
> +        - phy-names

Other multi port USB hosts just have a list of phys. Why can't you just 
use phy-names to identify each phy:

phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs", 
  "port3-hs";

Rob
