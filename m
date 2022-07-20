Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5959757C01C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiGTWfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:35:35 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25CBC28;
        Wed, 20 Jul 2022 15:35:30 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id v1so6443985ilg.4;
        Wed, 20 Jul 2022 15:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+JNTXrCvUZCWvrUEjoeK4DEdUzmVuvIzqvtnyaBDYs=;
        b=wlnvWMHqbjoMB91q0sgPs+vj5gAouno5Dajkl7USDNsSlBFkasZOam5ZRpAJRQSCIz
         H0+dNeN9HqZ76lkMzW2WAcrcEKafH0JCKepTUjNSacXqGUJdQM3sn8V16a6N5z8YhBwj
         VvHSs7CDYTP1aMZOFTaI3TUPrh90Vw7a7ZvdzNi7XdkNccTeHbusqUUxWnNbajN7x62O
         z6V+w9DcdnVlmG/pXLYOzPBwbqkz7T88qM9DNPUpG3zvdl4E852Il7/aC+xACRpXxVAP
         EPRoJhXQ+SS6LzcMFEVcKsAZsqvV3DqAKPy/rp6yh5/88wmZ5krn5Mk5bMGBDYzUTZNI
         rsvw==
X-Gm-Message-State: AJIora+KT3LAYC3SmcKYw4xE5mdEJfNlRFSo02MCjbt1+FggXsY4uuKM
        sjEUmTR8/Gg/KWCoJaHQ8Q==
X-Google-Smtp-Source: AGRyM1tRpZp9dVUYdPELLOlKs2qE/RdCpVCQkIQGG3pKo3QvhAnpDuvWJJn465cgxkvC9AGn/XqQLw==
X-Received: by 2002:a92:ddd1:0:b0:2d5:4877:65c8 with SMTP id d17-20020a92ddd1000000b002d5487765c8mr20608139ilr.267.1658356530116;
        Wed, 20 Jul 2022 15:35:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n42-20020a02712a000000b0033f3d432a2asm40170jac.174.2022.07.20.15.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:35:29 -0700 (PDT)
Received: (nullmailer pid 4105171 invoked by uid 1000);
        Wed, 20 Jul 2022 22:35:28 -0000
Date:   Wed, 20 Jul 2022 16:35:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: arm: qcom: document sc7280 and
 villager board
Message-ID: <20220720223528.GA4105117-robh@kernel.org>
References: <20220718073104.146985-1-jinghung.chen3@hotmail.com>
 <SG2PR03MB500654EF43123FBDF5F35C05CC8C9@SG2PR03MB5006.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR03MB500654EF43123FBDF5F35C05CC8C9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 15:31:02 +0800, Jimmy Chen wrote:
> This adds a LTE skus for Chromebook Villager to the yaml.
> 
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> -Add this patch
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
