Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED5545626
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiFIVHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiFIVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:07:09 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB74DFE61A;
        Thu,  9 Jun 2022 14:07:08 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id u2so18704379iln.2;
        Thu, 09 Jun 2022 14:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aPtqHDMoQGdoae6zzejWWCsMkFdeFOiCXUKMbTEVUPo=;
        b=ikGIMExk9VFeDyn9b/kA0KGPV0+9lERT9fNJ5hRhy6I0eg9ks6bnkpDiHJyMOXqTdN
         HrmIpQpXwaQQtqe3fg0iUk8GRWenSg8r2PFfKwhK1f/5Pf6NwPfDBd5Gak90aQ5+i7IU
         MfrRKf24eeBD1HM0wfFulnl2RsgE5dP3CAqm8/sKKL/P9X9x/MyNXAJe2UB2LI1sLy5+
         dxKoJbnq5t9b5lRKqr37ocVYJbZ/qoq19O0pka/TQrhmTycDUS55J/ljINlED6S8cyuN
         EVLeQ4nTSy85hrsWdOrYQaN6znkS1PrX/Ed1HJwCW1Es5cSIbhQFN6E9PEOy4qjPnj+p
         E8aQ==
X-Gm-Message-State: AOAM531SFbbOHKQ8qx5EWwEwDLzMSePXS4udk8QEjhbMyA+fp/Kuy9BX
        4soWZqnw6WuiLbHxS+mUWw==
X-Google-Smtp-Source: ABdhPJwNB4CbEkIovPz4grxr9Q45QXlG6X7GESmaoa/6jf6ML/U3s4aEwaZkR4NCZsc4RBaOypUmWA==
X-Received: by 2002:a05:6e02:1c89:b0:2d1:b0ae:88a1 with SMTP id w9-20020a056e021c8900b002d1b0ae88a1mr22730568ill.311.1654808828040;
        Thu, 09 Jun 2022 14:07:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n23-20020a02cc17000000b0032e2c859d8esm9960687jap.138.2022.06.09.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 14:07:07 -0700 (PDT)
Received: (nullmailer pid 100144 invoked by uid 1000);
        Thu, 09 Jun 2022 21:07:05 -0000
Date:   Thu, 9 Jun 2022 15:07:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kumar Gala <galak@codeaurora.org>,
        Amit Kucheria <amitk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom,spmi-temp-alarm: convert
 to dtschema
Message-ID: <20220609210705.GA100111-robh@kernel.org>
References: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 08 Jun 2022 13:27:01 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm QPNP PMIC Temperature Alarm to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../thermal/qcom,spmi-temp-alarm.yaml         | 85 +++++++++++++++++++
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt | 51 -----------
>  2 files changed, 85 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
