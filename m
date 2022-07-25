Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7D580465
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiGYTRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiGYTRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:17:46 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248B1C938;
        Mon, 25 Jul 2022 12:17:45 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id by10-20020a056830608a00b0061c1ac80e1dso9373121otb.13;
        Mon, 25 Jul 2022 12:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N2qVqcaI+/T60Q3nyO05hwi9i9zsck7gS8YRee5a38k=;
        b=C0qLgiLbvEvwqLRBKk4ZVv97OWqm6SDx2jlAPHHJiBJZ/kDvPFuLywKjtamwi5ft9k
         0AnU2dEa3+S8UN/Y1yCU/V0FLY+dZK3+YfnGMgD/4DqHf14PM0Jk9ZCw+SiFz3b54bbq
         wmgRGXZ6cqZC+O1RRdm0AoENG3MqGWHUXomu7m7fDSyYIvk9tUqVJDaIRdMsMqKTj/Vy
         e7q3Sy4gJA9kCk+KcbQvlo3sdX16ZsKMVW8AfgIL7lviLmBugdFBOOeOlLR7b1RlXCI1
         78dLyIK0zDTqIo/T3XJu5y3h1oAshryF0w4+8JL8qUxlNctHATm601yVbhIcXM8g9uAo
         oLHw==
X-Gm-Message-State: AJIora8Nzn8Pef5R/jxPlkYtHoMGht/B5tGYXlAMA4k3wm4O6uZpwSYx
        sgJEBiVA8+ap4FquiTqiKg==
X-Google-Smtp-Source: AGRyM1vI8+pv1JL6HWRu4b3H+fzvsD79ZmP78qQQQL6ie11qzh8N45ebXaX03WfLNQ2qQbK1mDkkQg==
X-Received: by 2002:a9d:4f17:0:b0:61c:d99d:9ad1 with SMTP id d23-20020a9d4f17000000b0061cd99d9ad1mr5409259otl.80.1658776665241;
        Mon, 25 Jul 2022 12:17:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i11-20020a056830010b00b0061cb445a5fesm5283846otp.55.2022.07.25.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:17:44 -0700 (PDT)
Received: (nullmailer pid 2535584 invoked by uid 1000);
        Mon, 25 Jul 2022 19:17:42 -0000
Date:   Mon, 25 Jul 2022 13:17:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: smd: reference SMD edge
 schema
Message-ID: <20220725191742.GA2535526-robh@kernel.org>
References: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 10:23:57 +0200, Krzysztof Kozlowski wrote:
> The child node of smd is an SMD edge representing remote subsystem.
> Bring back missing reference from previously sent patch (disappeared
> when applying).
> 
> Link: https://lore.kernel.org/r/20220517070113.18023-9-krzysztof.kozlowski@linaro.org
> Fixes: 385fad1303af ("dt-bindings: remoteproc: qcom,smd-edge: define re-usable schema for smd-edge")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
