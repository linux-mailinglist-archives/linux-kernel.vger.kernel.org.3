Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5714F6A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiDFTjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiDFTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:38:45 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3E16C0A6;
        Wed,  6 Apr 2022 11:35:28 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-dacc470e03so3871579fac.5;
        Wed, 06 Apr 2022 11:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lD3vW2QdGSWkKUsKxJuFURV13Koj8siq3oYJ/ytEFRo=;
        b=ib4XIvJ+nySd+s1q1nM26YobQgdS55ZLej6sFMq8/dKMRwUVQHxW7XIkLOIiO7tZCU
         7Ga4sA6ML4xzoqMj4PJLg2cjyy2ekhZ4x5fAjNemKCC28bZIQM8vFYk+Gu6jKffkz3ar
         o++xg7vFsk8h/osGPqZolGqTaIDP/UfVTiyYWakspmpRJ9WqNW6/h6LjbGoTTQl4QlDn
         GdsZTv4pmCILao7tGgl/Ylma7hosEy3McEJ6O/48L2ufuNxrMVAO5Ll86nVcwYdFyje1
         4Jub54THZkKMgnI8jpQmugFeZbAGaLUbFwmu86N5VY7wAe0kBXbjscpsi+hnuCRKFhKb
         Pwzg==
X-Gm-Message-State: AOAM531PpnqtWhIxmmcFLt0KhqbVIesFjR+MH6JptpdnoC2k0H+fyUqr
        sZnkjo4vecSwhMA+QZot4A==
X-Google-Smtp-Source: ABdhPJxZfNHQbZVonm6pbv+IB1gXixb8G0bFeIOVvzzRZDh2xSgW5e7ma6OONn0J94OxYNFNfV++cA==
X-Received: by 2002:a05:6870:c109:b0:d9:e74e:d09a with SMTP id f9-20020a056870c10900b000d9e74ed09amr4482067oad.142.1649270127937;
        Wed, 06 Apr 2022 11:35:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p14-20020a9d744e000000b005b235f5cf92sm7159488otk.65.2022.04.06.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:35:27 -0700 (PDT)
Received: (nullmailer pid 2553861 invoked by uid 1000);
        Wed, 06 Apr 2022 18:35:26 -0000
Date:   Wed, 6 Apr 2022 13:35:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        p.zabel@pengutronix.de, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: reset: add sama7g5 definitions
Message-ID: <Yk3dbop92OBvwrCt@robh.at.kernel.org>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
 <20220405112724.2760905-5-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405112724.2760905-5-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:27:20PM +0300, Claudiu Beznea wrote:
> Add reset bindings for SAMA7G5. At the moment only USB PHYs are
> included.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/dt-bindings/reset/sama7g5-reset.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 include/dt-bindings/reset/sama7g5-reset.h
> 
> diff --git a/include/dt-bindings/reset/sama7g5-reset.h b/include/dt-bindings/reset/sama7g5-reset.h
> new file mode 100644
> index 000000000000..670d8075f463
> --- /dev/null
> +++ b/include/dt-bindings/reset/sama7g5-reset.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

Dual license and GPL-2.0-only is preferred.

> +
> +#ifndef __DT_BINDINGS_RESET_SAMA7G5_H
> +#define __DT_BINDINGS_RESET_SAMA7G5_H
> +
> +#define RESET_USB_PHY1		4
> +#define RESET_USB_PHY2		5
> +#define RESET_USB_PHY3		6
> +
> +#endif /* __DT_BINDINGS_RESET_SAMA7G5_H */
> -- 
> 2.32.0
> 
> 
