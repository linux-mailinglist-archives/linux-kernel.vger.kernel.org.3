Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0C50E604
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbiDYQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbiDYQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:43:37 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945210C88F;
        Mon, 25 Apr 2022 09:40:28 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id a10so17703139oif.9;
        Mon, 25 Apr 2022 09:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kq4Use/nzv/1qc2LWxCR5Fcv+zm/lp+ZYpRqPRLOcHM=;
        b=pU6Kuy3KklMj/9L8Dw9UShhlAN/9thDPK3RqxC0Ecx+0tbsj8ZNv2hmr9A6rLO1bpf
         K/ZYJNpxBqMtVlXK1tBpORYgrUkvOK04mT0oI0tk1em/e8j7cEyns/j835FJWzo4K53b
         5kKp5E1PihJS9hpuYb3ULGNYXRK4ru3HhC32WlfdDBiI9d9BIh9r6g7m7fsTXb5HL6GA
         0IffqUO2hY6fza/BUritCX4dBg158OzvLhi0AvqhpfYLNUkZxRfv3ppAV4uDLITv1xt0
         fPAHcyRhdUwn+Mo/wtquKvfBH8gTrbFXi3552dGoxoOsZooTbetItCTTObPYANsURb3l
         0Y7g==
X-Gm-Message-State: AOAM5322V9SZgexSHSnpXzrhJc+EVQPR1HiOhYBjtkKQZ01cTxkf6DwD
        I1gPfk/wbJU6HDXEkt+jOg==
X-Google-Smtp-Source: ABdhPJyNXU+yNQPCeNaHfa9AzjHjYdEIHh8iRxgwB7smYx7/8SxqxWzKv0J4s7irW75P6OeUSUeKMA==
X-Received: by 2002:a54:4899:0:b0:322:3b41:f551 with SMTP id r25-20020a544899000000b003223b41f551mr12354365oic.202.1650904827499;
        Mon, 25 Apr 2022 09:40:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y83-20020aca4b56000000b003251ffeaf7csm1849156oia.10.2022.04.25.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:40:27 -0700 (PDT)
Received: (nullmailer pid 4029107 invoked by uid 1000);
        Mon, 25 Apr 2022 16:40:25 -0000
Date:   Mon, 25 Apr 2022 11:40:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: usb-xhci: Add bindings for
 usb-skip-phy-init property
Message-ID: <YmbO+SH2XRijha7i@robh.at.kernel.org>
References: <1650517255-4871-1-git-send-email-quic_c_sanm@quicinc.com>
 <1650517255-4871-2-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650517255-4871-2-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:30:53AM +0530, Sandeep Maheswaram wrote:
> Adding bindings for usb-skip-phy-init property.
> Runtime suspend of phy drivers was failing from DWC3 driver as
> runtime usage value is 2 because the phy is initialized from
> DWC3 core and HCD core.
> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> This property can be set to avoid phy initialization in HCD core.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> index 965f87f..a64d29f 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> @@ -25,6 +25,10 @@ properties:
>      description: Set if the controller has broken port disable mechanism
>      type: boolean
>  
> +  usb-skip-phy-init:
> +    description: Set if the phy initialization is managed by controller
> +    type: boolean
> +

This should be implied by platform specific compatibles.

Rob
