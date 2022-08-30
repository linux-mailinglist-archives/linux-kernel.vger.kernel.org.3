Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82C15A686C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiH3Q1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiH3Q1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:27:40 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E09BADB2;
        Tue, 30 Aug 2022 09:27:39 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11c4d7d4683so17932213fac.8;
        Tue, 30 Aug 2022 09:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nrGHopWA4SxaPcIMAXQWMteQXLvatI3VFjw00yOiys8=;
        b=PiL+7hTGBJbAVgN3zBFMptDOqURROPFAsWPcObvnRvTNHc+Pd1uQSqC27PoF9INmWY
         kMBpCWUEgP06M1nVI8l6+9raJt1xImz6bGH9iYj9fYg+UVBo6WvwSA5w1sIXdYaskCR8
         kvc1WQw9j4b2NJr2AtISSnd+YovZA8TYzct73GGoACDvug4kS3miNZ52qV9HudRDVetu
         x/QebZzVaspR9fhkIeLzw9X+sHeQ+y5lxemndMGFa5+AhdAVPQqr5rJZaA+L9UyGuE2K
         nfq1cx9DiTNYOeD0zBkCbMqf2kBF+7wv5THHos+0lWyw1/kywmZOvbvYEQKT1JN+I2lZ
         x2Cw==
X-Gm-Message-State: ACgBeo1qC9GCQA0YmW8r1D9s5xfc1etxRj6GyJxDgn0BDL1Sr2fyI3fr
        5Ba18aflogK1Y77DfjlHTw==
X-Google-Smtp-Source: AA6agR4K4Zd97hEeLwPzAGXOJ2SgyClgJuHiPXjVdJBbZZUev3+Iq52Hq783Oeao68LEKDT6fNJFUg==
X-Received: by 2002:a05:6870:c388:b0:11f:2f8d:f418 with SMTP id g8-20020a056870c38800b0011f2f8df418mr2784875oao.118.1661876858473;
        Tue, 30 Aug 2022 09:27:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c24-20020a4ad8d8000000b00435b646f160sm6909437oov.5.2022.08.30.09.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:27:38 -0700 (PDT)
Received: (nullmailer pid 1532303 invoked by uid 1000);
        Tue, 30 Aug 2022 16:27:37 -0000
Date:   Tue, 30 Aug 2022 11:27:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: extend example
Message-ID: <20220830162737.GA1532215-robh@kernel.org>
References: <20220828130113.5845-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828130113.5845-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022 16:01:13 +0300, Krzysztof Kozlowski wrote:
> Add a more complete example with PM6150 to provide better validation of
> the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.yaml          | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
