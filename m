Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54853AD0F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiFASvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFASv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:51:28 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351B13275E;
        Wed,  1 Jun 2022 11:51:27 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id h188so3830015oia.2;
        Wed, 01 Jun 2022 11:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2ZNwqKjItGDpeZxDzTcGrjLej9RBlHgjiNO+wPf9u0=;
        b=15yKPCx6b/81D4UyxkRv3vXyFI/CDsU7luQH9HUH7uY8b6i3ubb7nbbanWcAftcyGL
         BTCMhXvvl5g5eBKRkDIZu7T3IpErw0rtEi4C3VthVt8TDIMNceTzuDTtZ+epi8B42dy5
         xeHV0ZSoiF4iXFdrMj6G6MSAmPVut/5luy3+7x49kkmbFdY4kPc4jdMXZhVcc4j8FM1r
         n7Azx9GkRV2lRFnHyadS2++In7/KOug/G32p973lNYQgZRBy0MlsT5LLvEjTGe3AXI4B
         SykESyD2ilk80WzqrhKgsS9L9B6i7u+aCj3QeZXaOlZGxbiJgnNkOwxCGJgijpvVpOR8
         1QDQ==
X-Gm-Message-State: AOAM532FcRo4gWwLx6yqm7SrI8wjQhgI+lwfptZFPlgXbEy9xkZxObam
        +QhBOdvYODvNzpkoKpVYOg==
X-Google-Smtp-Source: ABdhPJwQFmyslgS5FHA+5KgsaoiseVIbZoReYgt/VB1UM4o0OIKiCyq+xA7b97+mzLJmmb3w5CRzLw==
X-Received: by 2002:a05:6808:10d4:b0:32b:1230:5cbd with SMTP id s20-20020a05680810d400b0032b12305cbdmr15489565ois.70.1654109486200;
        Wed, 01 Jun 2022 11:51:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lv21-20020a056871439500b000f28a948dd2sm981576oab.21.2022.06.01.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:51:25 -0700 (PDT)
Received: (nullmailer pid 215762 invoked by uid 1000);
        Wed, 01 Jun 2022 18:51:25 -0000
Date:   Wed, 1 Jun 2022 13:51:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        robh+dt@kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v4 5/6] dt-bindings: clock: Add Qcom SM8350 DISPCC
 bindings
Message-ID: <20220601185125.GA215573-robh@kernel.org>
References: <20220601124250.60968-1-robert.foss@linaro.org>
 <20220601124250.60968-6-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601124250.60968-6-robert.foss@linaro.org>
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

On Wed, 01 Jun 2022 14:42:49 +0200, Robert Foss wrote:
> Add sm8350 DISPCC bindings, while these bindings are similar
> to the sm8x50 bindings, the way clocks are represented has changed
> in ABI incompatible ways.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
> 
> hanges since v2
>  - Add my SoB - Bjorn
> 
> Changes since v3
>  - Separate from qcom,dispcc-sm8x50
>  - Remove clock-names
>  - Make example sm8350 based
>  - Changed author to me due to size of changes
> 
> 
>  .../bindings/clock/qcom,dispcc-sm8350.yaml    | 104 ++++++++++++++++++
>  .../bindings/clock/qcom,dispcc-sm8x50.yaml    |   4 +-
>  .../dt-bindings/clock/qcom,dispcc-sm8350.h    |   1 +
>  3 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm8350.yaml
>  create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8350.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
