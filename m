Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721C4510665
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350531AbiDZSQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350452AbiDZSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:16:26 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A026C951;
        Tue, 26 Apr 2022 11:13:16 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id e4so21610642oif.2;
        Tue, 26 Apr 2022 11:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eAx2PLqzD0frmD0Kzzi8iEUnvgkRX+N1plVsUdZCM1c=;
        b=VyyGSjTq8bzuFOFt71RMLq3dSox+OUoCgn0DNVohuQntoF3mRH/+Ok8TBTQB86I1E8
         odv3fWz1m2IBH2Umo57GDAGiUDOvIAu74jkVYgkaI4vF4UO2NFMXnmIMDLC0X4LQ1B28
         393v32WBkYKaQa8a7NGGNzrVjzWrU/TWzxwHRa9+CEDjRMk2fcVr+IJr6beZZ/wDqU4Y
         +4XL7XXK7vp9TZZFh7OpPeIwXYkFHLfQVJsbinFuNYv3n+/KoKgOCiBgQiWrITlSEye3
         h46oIMTJztgqeO4TdT4bA1Kxf/bMD8lPtsOFODHpFMLZb7yxD2eWlX2+9Qv51Vj3EbtF
         hP0A==
X-Gm-Message-State: AOAM533MIwhNiisJWM+21eT76nuyccZuxaV70gSdPawM+1BhPe2cpy0x
        W7abwS7n2nLNJLS7iCC7gduTB+zlbg==
X-Google-Smtp-Source: ABdhPJy78nTT6+KFIUyZupPqSsmVbmUD0yluTyO1eKHY22JblRzuRltLEpnF8aDvcNyM3QqbfxzSdA==
X-Received: by 2002:a05:6808:1206:b0:2d7:65a8:65e with SMTP id a6-20020a056808120600b002d765a8065emr11200486oil.107.1650996795534;
        Tue, 26 Apr 2022 11:13:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o19-20020a4a9593000000b0032176119e65sm5930676ooi.34.2022.04.26.11.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:13:15 -0700 (PDT)
Received: (nullmailer pid 2285557 invoked by uid 1000);
        Tue, 26 Apr 2022 18:13:14 -0000
Date:   Tue, 26 Apr 2022 13:13:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] regulator: dt-bindings: qcom,rpmh: document
 supplies per variant
Message-ID: <Ymg2Os22eG4gwdbG@robh.at.kernel.org>
References: <20220426105501.73200-1-krzysztof.kozlowski@linaro.org>
 <20220426105501.73200-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426105501.73200-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 12:55:00 +0200, Krzysztof Kozlowski wrote:
> The RPMH regulator binding covers several devices with different
> regulator supplies, so it uses patterns matching broad range of these
> supplies.  This works fine but is not specific and might miss actual
> mistakes when a wrong supply property is used for given variant.
> 
> Describe the supplies depending on the compatible, using a defs-allOf
> method.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../regulator/qcom,rpmh-regulator.yaml        | 256 +++++++++++++++++-
>  1 file changed, 242 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
