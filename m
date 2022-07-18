Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04566578BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiGRUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiGRUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:25:01 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF0426AD8;
        Mon, 18 Jul 2022 13:25:00 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id n7so10240811ioo.7;
        Mon, 18 Jul 2022 13:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HOCBCcFfJEyYD9wGbRbtBqu4TE4XIEQ46nMdyUi8Sk8=;
        b=UW3YW2SLcKDIBSLKhx516e+3Owxn6ZihCf1egdsZ4FOS7CdTS2GS7iDPA01ORcJtnv
         Mqe1qlV9lcE1ScMSKFuanfr9l3uTvkneAxcqRJa7KBL97+0x1MSTt7EkQSK3vkUO+xd4
         V/8KSxdvu9wGqO/2sgpnHoF9LJvLBRmWaIKAEyEvOav/GkfpOo8K7ouYJlsYKY7Xh/5n
         pJukeEI67+gB47sm1N878p3DHcn6du7kghF1mqCstasn5cLVt0h43QzJBYy/9tN7lI0s
         2GoiY3N8VIqpon7DfaYXC1vA8Ls+ev4n2m2Tq4MOaNwJ2subjNI8RR2jp5Ja76ErKkPr
         3fIA==
X-Gm-Message-State: AJIora/1aRK9OaBPGFowAKYlxXSN3TqloSFlH2bFD0InNmrQoQrR4Mbb
        eDbixM3SzAgsLt+aIET6iXHVpO4CgA==
X-Google-Smtp-Source: AGRyM1tE0vY1WJ1kp6WbeB8pbS0/52VH2oAxMsKH2iDMAaI4ZsWS/wfE/nyJHQin9/FRau623jgDRg==
X-Received: by 2002:a02:ad12:0:b0:33f:4663:e784 with SMTP id s18-20020a02ad12000000b0033f4663e784mr15602884jan.29.1658175899980;
        Mon, 18 Jul 2022 13:24:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m1-20020a026d01000000b0033f4ee78c07sm5878346jac.29.2022.07.18.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:24:59 -0700 (PDT)
Received: (nullmailer pid 3488253 invoked by uid 1000);
        Mon, 18 Jul 2022 20:24:57 -0000
Date:   Mon, 18 Jul 2022 14:24:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: bus: qcom,ssc-block-bus: rework arrays and
 drop redundant minItems
Message-ID: <20220718202457.GA3488167-robh@kernel.org>
References: <20220712154602.26994-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712154602.26994-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 17:46:02 +0200, Krzysztof Kozlowski wrote:
> There is no need to specify "minItems" if it equals to "maxItems".  On the
> other hand number of items in an array can be specified via describing
> items, which might bring some additional information.  This simplifies a
> bit the binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/bus/qcom,ssc-block-bus.yaml      | 25 ++++++++-----------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 

Applied, thanks!
