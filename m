Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F2C57D7C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiGVA20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiGVA2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:28:22 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B489E84;
        Thu, 21 Jul 2022 17:28:22 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id x64so2651383iof.1;
        Thu, 21 Jul 2022 17:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WO428di4LZg8IxMV7xo6JPUaQZ3IN14jbIhbdoqPskE=;
        b=x45Op0fCwKwPXaigBr6HOSWuJXfHTuNqQwIvBkSVqnavnOMrDCphboTyOc2PRFHqB6
         0UIds36h927vAr2h6Y+3SeArQ0VosvgixKNfctdqN8tQfSlDPhinUUBZU2nvnAeLbgvI
         56fNzzlgAcMywKPUbNMz8uwpK3ZQWjn54lUx4jIwck0hTHCEzlEgKYY++XbiP79ZHsKK
         5P/O4fWBYa1NuNVqbhGA6J/4XKGCEuQToTEFFb9FStbervnt/zFQLfJN02Am9RLNmSnM
         aJ2rImRkQNOuAM1CeMGhFIYzGNQ1Iylnx2m2KJlB4Hbqt/1SuD+g/fmrhSRHseu5k1Ty
         T31g==
X-Gm-Message-State: AJIora9SEC1ymffENdAtgKW7sjuc7kaiaDU33djVCfNbC/T1NAT2O/WG
        BYsXejbhFABUW8qpXFOpJls3RmzUAw==
X-Google-Smtp-Source: AGRyM1tnKNCMQpavV/Li+Xqtngb52FH2eaXYek41EtPrXz1E9fo6RX2b6MkumPquG7NKq97OHOGzcg==
X-Received: by 2002:a05:6638:300f:b0:335:b12d:3126 with SMTP id r15-20020a056638300f00b00335b12d3126mr430318jak.210.1658449701331;
        Thu, 21 Jul 2022 17:28:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w29-20020a02b0dd000000b00335d7c314b1sm1397030jah.53.2022.07.21.17.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:28:20 -0700 (PDT)
Received: (nullmailer pid 2243972 invoked by uid 1000);
        Fri, 22 Jul 2022 00:28:19 -0000
Date:   Thu, 21 Jul 2022 18:28:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Peng Fan <peng.fan@nxp.com>,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        festevam@gmail.com, p.zabel@pengutronix.de, aisheng.dong@nxp.com,
        s.hauer@pengutronix.de
Subject: Re: [PATCH V6 1/6] dt-bindings: soc: add i.MX93 SRC
Message-ID: <20220722002819.GA2243938-robh@kernel.org>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
 <20220719073541.197788-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719073541.197788-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 15:35:36 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> resets and power gating for mixes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx93-src.yaml       | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
