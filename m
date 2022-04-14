Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007DC501800
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355883AbiDNP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353453AbiDNPkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:53 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD2DBD13;
        Thu, 14 Apr 2022 08:21:01 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e2afb80550so5605891fac.1;
        Thu, 14 Apr 2022 08:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lqRJc6X1Uv0L9nq++wQS5HzuhbVfOhr/gAFMGNc6R2Y=;
        b=oEFrsuKmNujZGOMK5NNnLW1ECNUQe31gcUw4k1Z/YvFn87ashgyRFusJ1P9K+sZLR3
         xf5kkg5p1ZPdX/FZ8OtDLbrU6PV7aQCChlqO/efTiLxEa3fJUvwYEUq7T8pieozXfXPx
         065P7P8mobbWq0LY36EwrKht5SuIR+qvyckAoTuJPBcO3EOYyJYkh1Yrkret0WqvKOCf
         qET2e+U/I2+wCY/fy1L7SzV2lCYBS+DDAPvCsAYchJ1Wbp5PgvPKkWxRJIqP406ULx9h
         ZDD9VF+AyiEHYzOBqjGDfXf8Xaq4rvFD2I6vggj29RkI8LUxwyUV8sOZiFzTKbDtRV5S
         2zBQ==
X-Gm-Message-State: AOAM531aV4qDGcf2p8/KH7KbO21mx7/nv/bMt9yC1BOxJ2fJrLHiG2Gd
        ofSpZ1rjijDeog6tbLyPSw==
X-Google-Smtp-Source: ABdhPJxa75gqRlvYa8FhtXUMqFApngGD186Lmi8++a0QWdKFaMB5fVO1TNjyXAbtou2UEFajQ1tWOw==
X-Received: by 2002:a05:6870:461d:b0:de:4705:7fe8 with SMTP id z29-20020a056870461d00b000de47057fe8mr1701434oao.221.1649949661055;
        Thu, 14 Apr 2022 08:21:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bn41-20020a056808232900b003222f6e2ae8sm105922oib.29.2022.04.14.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:21:00 -0700 (PDT)
Received: (nullmailer pid 2077061 invoked by uid 1000);
        Thu, 14 Apr 2022 15:20:59 -0000
Date:   Thu, 14 Apr 2022 10:20:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Taniya Das <tdas@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-scsi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: clock: qcom,gcc-sdm845: add
 parent power domain
Message-ID: <Ylg7292ZqfwS4TUr@robh.at.kernel.org>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154347.491396-2-krzysztof.kozlowski@linaro.org>
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

On Mon, 11 Apr 2022 17:43:42 +0200, Krzysztof Kozlowski wrote:
> Allow Qualcomm GCC to register its parent power domain (e.g. RPMHPD) to
> properly pass performance state from children.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
