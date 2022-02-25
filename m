Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269434C4E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiBYTNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiBYTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:13:34 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A031B84D6;
        Fri, 25 Feb 2022 11:12:59 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id q5so8334735oij.6;
        Fri, 25 Feb 2022 11:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hsWKgvGzJx8KQAPzg/ZffFICmo2pX0WAshALYxArcSI=;
        b=LZUVj5oVYrHLDtWYRQq/7vZUFRaEa2grzeMKH0ntWgjojI0mSEeiPN8JVi9HfY7cUr
         vJfFlnNX5er5LJXPRzjvV4N3+YxGzM2yYTPLgHkSfl0JUuhvigP8oByl16WHnKCvJRo6
         e8dx9gOcMPPgNF3BlUSP8nZzMUEyZIiMpiTWusqxbiMS0MzXqempEW4QKCaYXA5kSrR7
         +z6WcyJqwlWgUAO0QPog0ELic3DMoFAdqnKcvl64vyuGU3X90019LtMBX3cZ6/PNbHNI
         sFYznk6u+TfqfQ122HLYgXX8UjtIOcFrJtahbu536PAcLbWhhEJl/TOwrWypZTdchJhm
         t9fg==
X-Gm-Message-State: AOAM533RYiBVCYyfzX2GsJY6kK2oxR2U8EBlq3JJzkvnPRo8TbPlWjbl
        L6GYhVBNRyW8JnPYB7679Q==
X-Google-Smtp-Source: ABdhPJxAfyFyZ2XrI1If28g1kdo6xoiQ8gbvJxdOs/yznvvzU7zyAqG9LZ2xK7FYlP9QNMTM7bhFzQ==
X-Received: by 2002:a05:6808:309e:b0:2d5:35e5:e1ac with SMTP id bl30-20020a056808309e00b002d535e5e1acmr595013oib.86.1645816379136;
        Fri, 25 Feb 2022 11:12:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a12-20020a9d5c8c000000b005ad51592bd8sm1533901oti.49.2022.02.25.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:12:58 -0800 (PST)
Received: (nullmailer pid 1269280 invoked by uid 1000);
        Fri, 25 Feb 2022 19:12:57 -0000
Date:   Fri, 25 Feb 2022 13:12:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        martin.botka@somainline.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk@vger.kernel.org, jamipkettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@somainline.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: add QCOM SM6350 display clock
 bindings
Message-ID: <YhkqOe2rP20qUb2W@robh.at.kernel.org>
References: <20220222011534.3502-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222011534.3502-1-konrad.dybcio@somainline.org>
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

On Tue, 22 Feb 2022 02:15:28 +0100, Konrad Dybcio wrote:
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6350 SoC.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../bindings/clock/qcom,dispcc-sm6350.yaml    | 86 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sm6350.h    | 48 +++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6350.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
