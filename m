Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74B5295E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiEQALk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiEQALi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:11:38 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B777863EF;
        Mon, 16 May 2022 17:11:37 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-d39f741ba0so22292801fac.13;
        Mon, 16 May 2022 17:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B59B15X2Y9707ITMe3Q0ZoBhueaMaEM8WsTZOA0UaUI=;
        b=k9Od3VBElk+dZsfFGmjrIczXTFr6MjGIwXflxcfNlXQSDLZ0eJs1wD6f+kkFcWV/nq
         zxLFtWyY2u+PXO3ub0F/RwjvhZ53c+S1XdqWL5+Y02uFCZgFJmmtKbd2br0lKHr/rqrR
         hVJz4WdLa62OiVCD/HsQNz/mda8mPAN2eNJ4NPrGu4Rtduc1r2V7MnoyDPcB9LXXEi43
         3TWSYyMTOFmRaw8QwSFWpp3U/UBtLOkspWpphs29rCIHpSJxeGdJBZr5ogJaZ5bDtgEd
         KJ3jBMaAW3inCIOfKcb3L4QWRNoAgkN9BdcX7LYdJ2Ivq2N2gvAM+khqbF00pAqfe4lS
         zm0Q==
X-Gm-Message-State: AOAM53304b+sDaJQ5Pc6GHqwJQB6YLD/So0fnmD3tKo7CmIL5P98BX93
        aELFxjjnRA4btnpyFYUlbw==
X-Google-Smtp-Source: ABdhPJy/FjSWyr0EuO88WWVHdVeVWy8f5dNYYK1eSBYd+d8aSX7IHAyFLoKjHN5yea6VyPWiXSOdNg==
X-Received: by 2002:a05:6870:9a09:b0:e9:20a7:6cf6 with SMTP id fo9-20020a0568709a0900b000e920a76cf6mr16579934oab.122.1652746297033;
        Mon, 16 May 2022 17:11:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x16-20020a056830245000b0060603221251sm4411822otr.33.2022.05.16.17.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:11:36 -0700 (PDT)
Received: (nullmailer pid 3620853 invoked by uid 1000);
        Tue, 17 May 2022 00:11:34 -0000
Date:   Mon, 16 May 2022 19:11:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Kiran Gunda <kgunda@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: qcom-wled: fix number of addresses
Message-ID: <20220517001134.GA3620793-robh@kernel.org>
References: <20220505154702.422108-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505154702.422108-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 05 May 2022 17:47:01 +0200, Krzysztof Kozlowski wrote:
> On PM660L, PMI8994 and PMI8998, the WLED has two address spaces.  This
> also fixes dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb: leds@d800: reg: [[55296], [55552]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/leds/backlight/qcom-wled.yaml    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
