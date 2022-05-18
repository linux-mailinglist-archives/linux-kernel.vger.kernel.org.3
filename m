Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2252AF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiERA55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiERA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:57:55 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9A53E27;
        Tue, 17 May 2022 17:57:55 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e93bbb54f9so759405fac.12;
        Tue, 17 May 2022 17:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRwrJN9Tuf97sPdEBRzlBBjJviA/ajuLVWi6AxoPg1o=;
        b=LtKZGzepmTQr4JHddoKjv94kgwukCqE/H1FEH1TnguanB2PIG+YXn4mih4HTZxJ8ry
         tEuc5Jq/bB+/+2TzZwEMAtjQAkKonQJmKfNmd4OJ2v4Rv+IOUvtCUoyQv+JtTWJ15+MP
         BxELllX6/t9jkqdDWN8jmRHqzAhFz0eEIvT/f40Ac+u8oYBlePJBt72v4ONZDbzus//5
         xmX7XpHsSZvC1jb+iNbIUdYKy3dzo/VeNS+QPXitpV4t5EeHcaauHGfp5XNML04rD0um
         fMKuwBUZJsadGjZ78M76gS7//W+GyO9J6K4WGEoY5QS1MONwSWEwQiuO+8KvN3F540Zr
         9+Ag==
X-Gm-Message-State: AOAM533uYoUjcL5uJ0vMzJ1fegDXNTHIXiCvWvDnGPqR8K5PMXXWJeXf
        AEyZ9XpgXZmOcnF5d4/m2hWVlFdTpw==
X-Google-Smtp-Source: ABdhPJwbUiKkka/fSyIWroQaJiCr1nWt7uGP3fkSnZ4kdEtrVRjHz+ILagr0hc/y4GmGttP500zqSQ==
X-Received: by 2002:a05:6870:830a:b0:ee:1586:1009 with SMTP id p10-20020a056870830a00b000ee15861009mr14317931oae.271.1652835474463;
        Tue, 17 May 2022 17:57:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l5-20020acabb05000000b00328a1be5c3asm337504oif.25.2022.05.17.17.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 17:57:53 -0700 (PDT)
Received: (nullmailer pid 1982336 invoked by uid 1000);
        Wed, 18 May 2022 00:57:52 -0000
Date:   Tue, 17 May 2022 19:57:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2 04/12] dt-bindings: remoteproc: qcom,adsp: simplify
 interrupts
Message-ID: <20220518005752.GA1982303-robh@kernel.org>
References: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
 <20220517070113.18023-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517070113.18023-5-krzysztof.kozlowski@linaro.org>
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

On Tue, 17 May 2022 09:01:05 +0200, Krzysztof Kozlowski wrote:
> Interrupts between variants differ only with presence of last optional
> interrupt, so the constraints can be simplified.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        | 46 ++++++++-----------
>  1 file changed, 18 insertions(+), 28 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
