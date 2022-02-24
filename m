Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804044C3179
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiBXQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBXQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:32:28 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E631680A6;
        Thu, 24 Feb 2022 08:31:49 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id l20-20020a0568302b1400b005af8c95bbe4so1654521otv.1;
        Thu, 24 Feb 2022 08:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8WIXGASDgN1b64Ak50PdwgKePA+y4pl9eMfrSaeSs4A=;
        b=wO5lH854DSFhCuEqjE9NRANFIa70g1/Kj/mppfDoG0C/rSwsbgEIFWwl1MoKob2mI6
         A/dD1w1C7SoBTdmMDp66VddJpy78l2Y9uuhTDkw92DJLwfRW+921QBliClIT3gvE/R7k
         lgtzimQC1ft66PEpnpY+BEXYFDdARnMyrc9o9hib4YAgA6AR2HmKAv+W+reWdQ5pyArU
         HFLTuiwPHSkASIxP29P1S1UGgn4txSIon3R8zFrNDDTanxth5s2HxZ7X6rFYiDjVtupH
         4NnuDrpog7YI65TeRrU3B5G2OomsT/nCAlZLxLPSmcLRJjWQXbWAoB8ga0aFjvbmUwXa
         KaJQ==
X-Gm-Message-State: AOAM532JYC7oddKZRau5Sf6I+WJnOlW2b1/LUETGsFiHQxbQZ6XhNKmT
        sFhZxiazrgHuTEY0iK4yzeBBzyiF8g==
X-Google-Smtp-Source: ABdhPJxjcU1+RvX1vLs/qTjze2Ii24dDNmDifnbDD/2Tj8uOIQIcg97gGLGU+CU5pC8S7/+eaCkM8g==
X-Received: by 2002:a05:6830:192:b0:5af:898b:3f88 with SMTP id q18-20020a056830019200b005af898b3f88mr1244369ota.100.1645720278901;
        Thu, 24 Feb 2022 08:31:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z2sm1270536oot.3.2022.02.24.08.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:31:17 -0800 (PST)
Received: (nullmailer pid 3199816 invoked by uid 1000);
        Thu, 24 Feb 2022 16:31:17 -0000
Date:   Thu, 24 Feb 2022 10:31:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: amplifiers: add ada4250 doc
Message-ID: <Yhey1QmZa4RU0p50@robh.at.kernel.org>
References: <20220223120112.8067-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223120112.8067-1-antoniu.miclaus@analog.com>
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

On Wed, 23 Feb 2022 14:01:10 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADA4250 driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> changes in v6:
>  - add space before `{` in the amplifier node example
>  .../bindings/iio/amplifiers/adi,ada4250.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
