Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA764C4E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiBYTNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiBYTNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:13:51 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEC81BBF50;
        Fri, 25 Feb 2022 11:13:19 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id y7so8342148oih.5;
        Fri, 25 Feb 2022 11:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6CeaqLyIxWM5I+T0XX9mjVdw7W8EHbW4/9lxu7rLHXk=;
        b=ADUAFah9EY1b3PpUJFLQTogij27reCA4O1LVhFnFuR2IZRNd/47z2BhyxBA+7701F7
         sIYETehetWi7rsBKUKV59/u/2Fm4TABi034wmmmilpSCpPsx5jjdNeoOn/ocRHuMXk7+
         pCPJ6BGIDbysm4jTz5Z8B9zj8M806J5EQb7jm7iomTy2yqHfA0kikcWDMLiC4qf1ezKs
         uGAqGAP1xrL+axiKOQU+73zsIdxS//XHZtZrwJQ0lICDR8YJOtb/Qx843ToRKeTT1M89
         H0VYMMmpIuBvPWCh2Wmuio9YRJlxXHCYElzoqt/ShWajUzcfe2bmLpolB/6hQSZYm7yx
         RD7w==
X-Gm-Message-State: AOAM533d26niy0wckEdTLmtJ9zOMsJ1ut6na6Z8Kl0ogc25479s94J+s
        bSMJgVNAgYm1ZS2QrrO9xg==
X-Google-Smtp-Source: ABdhPJyh/wasr6vqvD+N7tIc56hS+EJ8IcxkguQEnVPLvXTdeOZ3f7bSVOYYC16KfQseaf3anQKekA==
X-Received: by 2002:a05:6808:23cd:b0:2d4:b5ce:e2fb with SMTP id bq13-20020a05680823cd00b002d4b5cee2fbmr2584419oib.78.1645816398643;
        Fri, 25 Feb 2022 11:13:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g35-20020a9d2da6000000b005af5fb99326sm1485024otb.63.2022.02.25.11.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:13:18 -0800 (PST)
Received: (nullmailer pid 1269956 invoked by uid 1000);
        Fri, 25 Feb 2022 19:13:17 -0000
Date:   Fri, 25 Feb 2022 13:13:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        jamipkettunen@somainline.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        martin.botka@somainline.org, Andy Gross <agross@kernel.org>,
        marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 3/4] dt-bindings: clock: add SM6350 QCOM Graphics clock
 bindings
Message-ID: <YhkqTXUGUj7vIXFJ@robh.at.kernel.org>
References: <20220222011534.3502-1-konrad.dybcio@somainline.org>
 <20220222011534.3502-3-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222011534.3502-3-konrad.dybcio@somainline.org>
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

On Tue, 22 Feb 2022 02:15:30 +0100, Konrad Dybcio wrote:
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM6350 SoCs.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 +
>  include/dt-bindings/clock/qcom,gpucc-sm6350.h | 37 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm6350.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
