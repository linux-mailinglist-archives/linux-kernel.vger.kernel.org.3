Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64F6517B25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 02:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiECANA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 20:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiECAM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 20:12:57 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B1C36142;
        Mon,  2 May 2022 17:09:25 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e9027efe6aso15799118fac.10;
        Mon, 02 May 2022 17:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g0IHaqYHFy6W+CDBnqmLrfWHtTbtuTJHrX16RdlyIGw=;
        b=DI7SOouJGTjnI7uz2dq1yFzcjlT9p9a8QNGgP8DAWl1ZX2rHpg9w6xivWpTBFIf3FI
         hqcSZ1c1Q8tRIpsuUw8Trt6/iDmeI0qZkEioge1tSIpdQFa/MVDEey6FFvasMCY2txcE
         IL7xQ/E9lLT7WDB+3uy9STAw9LY/Dy7ufxP8dZiJMVkf5bB76Q1RHRFgYgQ72RWNgr8u
         ruTaESNuE3JZyToFFlei9bhcDvZe3BUuiU/T52dehXlO6Pl6Up5Kcsiuw/+lygrsMJ1U
         AlyjgObvGWD++dIp+7VvwGeK5QNkDYCdCxhktwajBDCD8C4FpQQr1JwScdTYeTekA1PI
         HLmA==
X-Gm-Message-State: AOAM5312b2DoBaQo7L0Mxz58pkcS8K4iY4hIgRqTzJhpzS5LNxkpJYpB
        CfL6rU50VRtBefuiKkcYbw==
X-Google-Smtp-Source: ABdhPJxUaQL2/RSubxC/Oe0dX5biYKJocIU6vFCUZR3ycnkkmtvWPROvSQJGes/8JoVV9VKU6v3P/w==
X-Received: by 2002:a05:6870:3047:b0:ec:44c2:1718 with SMTP id u7-20020a056870304700b000ec44c21718mr784304oau.214.1651536564647;
        Mon, 02 May 2022 17:09:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k8-20020a056870d38800b000e2b873f013sm6395797oag.0.2022.05.02.17.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 17:09:24 -0700 (PDT)
Received: (nullmailer pid 2074906 invoked by uid 1000);
        Tue, 03 May 2022 00:09:23 -0000
Date:   Mon, 2 May 2022 19:09:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mailbox: qcom-ipcc: add missing
 properties into example
Message-ID: <YnBys80Panfun92T@robh.at.kernel.org>
References: <20220426101837.16201-1-david@ixit.cz>
 <20220426101837.16201-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101837.16201-2-david@ixit.cz>
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

On Tue, Apr 26, 2022 at 12:18:37PM +0200, David Heidelberg wrote:
> These missing required properties are needed for
> smp2p binding reference checks.
> 
> Also includes cosmetic change to the example formatting.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - add Krzysztof R-b
> ---
>  .../devicetree/bindings/mailbox/qcom-ipcc.yaml        | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied, thanks!
