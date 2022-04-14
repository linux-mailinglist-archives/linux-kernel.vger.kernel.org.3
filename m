Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8A5017F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245718AbiDNPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359243AbiDNPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:42:51 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D838615A15;
        Thu, 14 Apr 2022 08:29:45 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id c11-20020a9d684b000000b00603307cef05so22492oto.3;
        Thu, 14 Apr 2022 08:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3UETaIQeb6P+iXjP5IpxOK7ZKq81QNIBiRdKxlrRypk=;
        b=gqzZ8/8byZqIRJ3eIUBneLCOQcOrIRmxs3gJ8gaOyMvAW4QrlldFhezkhV+oE1kc/H
         3MmFeuvQ0T3MSxYohk3zSiW+yujoAatHQbF2OMia3z1B+ZGGx8pGhtU/4OIYoNct4k6e
         RGi0MWPWwGSJuTWueGRhypiLQac6X2ThbuO1Kr7b06tLHouS237bXlH3kFajlwzuGc2S
         vt+0i+BfqnvoQTJEJrubp3q7OsGSl6F3mm7mEwp2qBXQR9sLre5YLEm0U89Nndccnf5q
         6hzyWmkjJ/2lR78KzYJEXCWyGkTms5LnEW81E/fF3Q+eBqED/if0M6rh69dlEEKPUc2u
         wZSA==
X-Gm-Message-State: AOAM531kaOQcgy9SHjp3jNta2mu9cz7ssb1lpLkrZwcpqn/tiFUYHzgR
        mrJi2Q9+ojP9MM+gxvejlg==
X-Google-Smtp-Source: ABdhPJzs0u3Z4z9b2OPpfdX30VAA1RKhl/+i1o5tSuI8op0LdPKD1lzWlr/TEd8c+lGrvkEloUASFg==
X-Received: by 2002:a9d:1c4:0:b0:5cf:2f29:d8a1 with SMTP id e62-20020a9d01c4000000b005cf2f29d8a1mr1100878ote.273.1649950185148;
        Thu, 14 Apr 2022 08:29:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bl4-20020a056808308400b00322281cd376sm145153oib.11.2022.04.14.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:29:44 -0700 (PDT)
Received: (nullmailer pid 2089792 invoked by uid 1000);
        Thu, 14 Apr 2022 15:29:44 -0000
Date:   Thu, 14 Apr 2022 10:29:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: soc: qcom,smp2p: convert to dtschema
Message-ID: <Ylg96EDTqtIHQu5D@robh.at.kernel.org>
References: <20220411155528.502889-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411155528.502889-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 11 Apr 2022 17:55:28 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Shared Memory Point 2 Point bindings to DT Schema.
> 
> Changes against original bindings: enforce only specific names of child
> nodes, instead of any names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct qcom,local-pid and qcom,remote-pid types to uint32.
> 2. The DT schema warnings reported by Rob's robot are fixed already in
>    separate patches.
> ---
>  .../bindings/soc/qcom/qcom,smp2p.txt          | 110 -------------
>  .../bindings/soc/qcom/qcom,smp2p.yaml         | 145 ++++++++++++++++++
>  2 files changed, 145 insertions(+), 110 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> 

Applied, thanks!
