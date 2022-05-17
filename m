Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5016B52960D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiEQAaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiEQAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:30:15 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A25F40A1D;
        Mon, 16 May 2022 17:30:15 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id v66so20646367oib.3;
        Mon, 16 May 2022 17:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YYZ9P6JoTLhKizGObZkJgYrG6pnr1ZQ7jT3oo1ocLpY=;
        b=nSw+4DG11xG6kcFB1RWoV4abbjuQyyd0yswdPonRqJd1dxx3NfsrxZRrPvwcDqpIi4
         FAV5ZhTeDlipkgkGUckQDx++X0LtPSAzk+5TinXBNW+0U1uwHMt3XbSzmCU3PZpyT+Oj
         fmcamsIrgN1ktiyD3BKQ8Fb0SdLh3tgrpjAITF66+92U/gE76ADBNF4VHqp7RCdlr8oo
         MVaYI5hsXLSLWrEVOI3XwwrnZJSEBZclZllRqt6kVqB4V5dTlAbvG94ScRZG15EHPG8U
         oqB7kvT5DANWn67ECgtkQle0zuUKHhJ5kv2XTzLClZ4CQBlVLS3pNAuVX7GgeVG8XctC
         Bhog==
X-Gm-Message-State: AOAM533KnSXLa6mOVRyIva3aS8JkaTxNCQe7rGp52SRqCw5ET+7tsxrd
        VGZpiQ2TA3cIVZY0KzKT6w==
X-Google-Smtp-Source: ABdhPJxsYFrgbzwlYqcoH92/HrrcbohAC6umxvccBvqgRDnmgl+giRrQrQGF0e5cdlAXIGqG8F8ftQ==
X-Received: by 2002:a05:6808:1a20:b0:326:9023:f7b1 with SMTP id bk32-20020a0568081a2000b003269023f7b1mr8747224oib.171.1652747414400;
        Mon, 16 May 2022 17:30:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870e40100b000e686d1388csm5951201oag.38.2022.05.16.17.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:30:13 -0700 (PDT)
Received: (nullmailer pid 3654143 invoked by uid 1000);
        Tue, 17 May 2022 00:30:12 -0000
Date:   Mon, 16 May 2022 19:30:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 03/11] dt-bindings: pinctrl: qcom,pmic-gpio: describe
 gpio-line-names
Message-ID: <20220517003012.GA3654086-robh@kernel.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
 <20220507194913.261121-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507194913.261121-4-krzysztof.kozlowski@linaro.org>
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

On Sat, 07 May 2022 21:49:05 +0200, Krzysztof Kozlowski wrote:
> Add missing 'gpio-line-names' property and describe its constraints for
> all models except PM8226 (which seems not really used).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 221 ++++++++++++++++++
>  1 file changed, 221 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
