Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB94F867C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346545AbiDGRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbiDGRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:46:33 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F2E22C6D8;
        Thu,  7 Apr 2022 10:44:33 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id e189so6373147oia.8;
        Thu, 07 Apr 2022 10:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fjgXlhLSRs2Ju18TruqdD1K3+T3KnDyivCzVK+UwhTA=;
        b=sM3XIDBHj5B0SgrNnUnwp9UUREfU8DJW49tptJ1UlttZpl9k6A1NVwx9fu4q07zyLx
         NMorfjcm/gCfCjRe8ZXYBDTLhFdSRRssk54xoMbsbYrsemTPsLPameeaoLHpI8YGyhHk
         tmll4LNIk5f7kS7n4zzci006ayF708nARVGxx5kz3vF1BuMwDWu5PdT2dMYKYkTdNv/v
         YTNrMY9CpaEdg2ec/Jl2TBxdKxWCnGyXtGUnoZ+4ClA0b2drxPHlu5snLcRpxZITdzq7
         mSPLnExDysmjPjTPhMRnz4bkwGVflmGqnntFshbQsK+ons5Ds/U+1xj2/oUghMjsFiG8
         mWLA==
X-Gm-Message-State: AOAM532Yyw82EmRcsjOQvOComDx/gDWo68Ju39lW6hJ0+bSbdaPqVJ+/
        qmP221uTj4A5B+D1rxoJJyVzMA4Rvg==
X-Google-Smtp-Source: ABdhPJxJgCTebUYiCOeNg9gfAs2VE5IfKFpuEaVXWjHl7jidBe+sMpG8NSplGBind9wD4LGfbJsvJw==
X-Received: by 2002:aca:2407:0:b0:2ef:5c86:5a09 with SMTP id n7-20020aca2407000000b002ef5c865a09mr6249766oic.160.1649353472255;
        Thu, 07 Apr 2022 10:44:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m23-20020a4add17000000b0032489ab619esm7446219oou.45.2022.04.07.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:44:31 -0700 (PDT)
Received: (nullmailer pid 1603902 invoked by uid 1000);
        Thu, 07 Apr 2022 17:44:31 -0000
Date:   Thu, 7 Apr 2022 12:44:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: qcom: update maintainers (drop Akash and
 Mukesh)
Message-ID: <Yk8i/0U1Y1MOVv7+@robh.at.kernel.org>
References: <20220405063724.12850-1-krzysztof.kozlowski@linaro.org>
 <Yk3X94DwNR4AcPP4@robh.at.kernel.org>
 <081c5f7f-31d5-f797-e107-1ea5c9639a5a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081c5f7f-31d5-f797-e107-1ea5c9639a5a@linaro.org>
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

On Thu, Apr 07, 2022 at 08:50:47AM +0200, Krzysztof Kozlowski wrote:
> On 06/04/2022 20:12, Rob Herring wrote:
> > On Tue, 05 Apr 2022 08:37:24 +0200, Krzysztof Kozlowski wrote:
> >> Emails to Akash Asthana and Mukesh Savaliya bounce (550: Recipient
> >> address rejected: User unknown in virtual alias table), so switch
> >> maintainer to Bjorn (as active Qualcomm platform maintainer).
> >>
> >> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes since v1:
> >> 1. Add only Bjorn.
> >> ---
> >>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml  | 3 +--
> >>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 3 +--
> >>  2 files changed, 2 insertions(+), 4 deletions(-)
> >>
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> > Let me know if you'd rather me pick this up (and the pile of other QCom 
> > bindings).
> 
> Yes, please pick them up. Few other Qualcomm bindings depend on each
> other (SPI+I2C+Serial to finally convert the GSBI which uses it), so not
> all of them can go via respective subsystems.

Done.

Rob
