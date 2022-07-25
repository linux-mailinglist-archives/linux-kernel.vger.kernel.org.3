Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABB4580746
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiGYWWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbiGYWWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:22:42 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751712558E;
        Mon, 25 Jul 2022 15:22:41 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id l188so3513551oia.4;
        Mon, 25 Jul 2022 15:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NziihmKhvTDMxLR3TeAOkHUMxBmt4TMUH7DKcZSQRks=;
        b=wmFhAchOZ8ghTWPRd/uGqi1jxZJTbvpxtQ7ZvXfyQ5dyg5X7O7/VCGYQouPiiOAY7s
         pwqpLRYCGzTUeaBTCHqpkPVwuJdEHu1NC5GWc2DS5/4JIGIMebxjo3cumNkOWSUfgvXT
         MGOvkv1uLpP80PVWagHIwj3p5KK9BbCFveZSwEJYq2WfM1GRc0jGuEBSkqIEnGnqKi0d
         c8P0zdLzfSX1vDqC5HhaqeAAQ0A6PC1+NKGZT9Sq++HoqgOT2/3RqwHQwR616th5KnhX
         9UaRPFPcf/Pv19cu+uz5JheFZrsVyg+Yrep4julv1JiYBnWzCky2vEGBz8qjT2pMf+ld
         j4Ig==
X-Gm-Message-State: AJIora9sfF/qccS9pLkindY1TgrqNLLp+DOE0lgk4rZlQHkQLD8l+lIS
        Hn7oeOa+ozm49udTHyIxLQ==
X-Google-Smtp-Source: AGRyM1sz3dyj2N3SvoH/2VVg7xnC3nkGgiFx3lU6Jf9MNXRwmoKmqVAoAxFgjKg1QYLt513rHFbMlg==
X-Received: by 2002:aca:3441:0:b0:33a:7941:bb07 with SMTP id b62-20020aca3441000000b0033a7941bb07mr13816883oia.199.1658787760722;
        Mon, 25 Jul 2022 15:22:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t18-20020a9d7f92000000b00616f2680487sm5475632otp.34.2022.07.25.15.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:22:40 -0700 (PDT)
Received: (nullmailer pid 2849371 invoked by uid 1000);
        Mon, 25 Jul 2022 22:22:37 -0000
Date:   Mon, 25 Jul 2022 16:22:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, wenst@chromium.org,
        nfraprado@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chun-jie.chen@mediatek.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        rex-bc.chen@mediatek.com, p.zabel@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: reset: mt8195: Add resets for USB/PCIe
 t-phy port 1
Message-ID: <20220725222237.GA2849337-robh@kernel.org>
References: <20220720102817.237483-1-angelogioacchino.delregno@collabora.com>
 <20220720102817.237483-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720102817.237483-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 12:28:16 +0200, AngeloGioacchino Del Regno wrote:
> Add the reset index for USBSIF P1 (T-PHY port 1), used as either USB
> or PCI-Express PHY reset.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/reset/mt8195-resets.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
