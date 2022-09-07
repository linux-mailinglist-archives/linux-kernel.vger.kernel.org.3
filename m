Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7115B0ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIGVEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGVEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:04:07 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8021B07C1;
        Wed,  7 Sep 2022 14:04:06 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-127ba06d03fso15562771fac.3;
        Wed, 07 Sep 2022 14:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aQSKe2CH6b9g5mXBEzOcX3asnf3UcbDFBQH+uLWaqLQ=;
        b=YyZXFKRa7nvRKYfaBoAVGulwiap6Zo5Z0JDmGagkza9ubWtzKZ+NBwKK2OilWZfURL
         byUlamCUnWWdsTx9QOk6Y54CV/Xsj+cR1rpRMxvDjdkXZXX2DsxWpFRDf43gK+4svllr
         3VAzrq9IgWubTNGdKJezrkUMe1h//PbY/jlOiuc2FmeAVCED9kaTHPsO29KT2Ng1jfyB
         FtqWee6UBL2NjI2EZfoBjQEzY7Z29oklgNuzDapZuW9adxe8AQ3rUgO8mIzfk6EoDz4U
         1CaLr7aWeJR98XGX2AkmAAgXALDzoeWAO50th1r69w0C/1qHPkP9orLiMd2vQV+SgvOa
         /znw==
X-Gm-Message-State: ACgBeo0v9E7YyzkZUzeFZOTNKRmul1xAcDksO9G4VeQYyomnbgNy1K+f
        N8URAfT6UpvG8ZXniVxAyw==
X-Google-Smtp-Source: AA6agR532XhH323tj7DaASBATDK/KgBu30H+uIFV8zPVW0kuu7V5FaKTfxRVXm0TEjBc7Q3+xeDuQw==
X-Received: by 2002:aca:b01:0:b0:345:4295:e9b2 with SMTP id 1-20020aca0b01000000b003454295e9b2mr158556oil.28.1662584646172;
        Wed, 07 Sep 2022 14:04:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870f14300b0012752d3212fsm5165992oac.53.2022.09.07.14.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:04:05 -0700 (PDT)
Received: (nullmailer pid 342769 invoked by uid 1000);
        Wed, 07 Sep 2022 21:04:03 -0000
Date:   Wed, 7 Sep 2022 16:04:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] dt-bindings: phy: qcom,qmp-usb3-dp: add missing
 power-domains property
Message-ID: <20220907210403.GA342688-robh@kernel.org>
References: <20220902080705.12050-1-johan+linaro@kernel.org>
 <20220902080705.12050-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902080705.12050-3-johan+linaro@kernel.org>
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

On Fri, 02 Sep 2022 10:07:05 +0200, Johan Hovold wrote:
> At least the "qcom,sc8280xp-qmp-usb43dp-phy" binding requires a power
> domain to be specified.
> 
> Fixes: aa27597e594c ("dt-bindings: phy: qcom,qmp: Add compatible for SC8280XP USB phys")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
