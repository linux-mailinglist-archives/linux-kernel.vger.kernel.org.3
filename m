Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA4530F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiEWM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiEWMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:25:57 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A7DFF8;
        Mon, 23 May 2022 05:25:56 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e93bbb54f9so18162327fac.12;
        Mon, 23 May 2022 05:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/GTLwoTiTehcRS4r9a+ERLbn5bIsSAK2Ky6sWKNN9Q=;
        b=X9NwGgiKvXtec91ZzOnkufErn3M0W3j43DhaRGzCbkq/qD1FRySacAImN5za9zzXBs
         nEpusZvVSel5YQARUYBRXKtfLRREDu+vbQeP/qcFMLRbEWrayDZ/1nu5bmocHhWjPcgc
         Vp1RlMwcC2h47c1hbfGhAdS/eMPxG/mIu3/FvSLNGIt7jYYUwP+82q34nlR6gTcujIzt
         CeNe76rj+jHEaxojHtrjUlIF36Q48+kPwckuDeYcvecJ83ksdOiZI2/w3jhRTgkx5L8b
         +j21+0U5M3TX2tWyUmFQst62CgDS6BBmhBi1ABsD4zdH/W9ItBlSj+rFASPxi8Imrnvd
         b7mQ==
X-Gm-Message-State: AOAM530BEQIcxIRgELZfLotGHFYVwJ6cWNNcHSyUQQ1pN2weGaCZHbh3
        HS+eyl3RKzHsl5liaFe5xA==
X-Google-Smtp-Source: ABdhPJyakI0goXn872cMHPFcb39rYcWU/v/szd30xaKjCwB1d4ycwJxN1SyKvhnnoyGPlYMPK/+eZA==
X-Received: by 2002:a05:6870:538f:b0:e1:def7:7640 with SMTP id h15-20020a056870538f00b000e1def77640mr11205240oan.34.1653308755763;
        Mon, 23 May 2022 05:25:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x14-20020a05683000ce00b0060603221261sm3946145oto.49.2022.05.23.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:25:55 -0700 (PDT)
Received: (nullmailer pid 1362443 invoked by uid 1000);
        Mon, 23 May 2022 12:25:54 -0000
Date:   Mon, 23 May 2022 07:25:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com
Subject: Re: [RFC 1/2] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Message-ID: <20220523122554.GA416176-robh@kernel.org>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 06:04:54PM +0530, Harsh Agarwal wrote:
> Added support for multiport, mport, num-ssphy and num-hsphy
> properties. These properties are used to support devices having
> a multiport controller.
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index f4471f8..39c61483 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -341,6 +341,35 @@ properties:
>        This port is used with the 'usb-role-switch' property  to connect the
>        dwc3 to type C connector.
>  
> +  multiport:
> +    description:
> +      If a single USB controller supports multiple ports, then it's referred to as
> +      a multiport controller. Each port of the multiport controller can support
> +      either High Speed or Super Speed or both and have their own PHY phandles. Each
> +      port is represented by "mport" node and all the "mport" nodes are grouped
> +      together inside the "multiport" node where individual "mport" node defines the
> +      PHYs supported by that port.
> +    required:
> +      - mport
> +
> +  num-hsphy:
> +    description: Total number of HS-PHYs defined by the multiport controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  num-ssphy:
> +    description: Total number of SS-PHYs defined by the multiport controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32

These seem redundant. Can't you count ports/phys?

> +
> +  mport:
> +    description: Each mport node represents one port of the multiport controller.
> +    patternProperties: "^mport@[0-9a-f]+$"

Think about how the USB device binding fits into this. A hub vs. 
multiple root ports doesn't seem much different.

Rob
