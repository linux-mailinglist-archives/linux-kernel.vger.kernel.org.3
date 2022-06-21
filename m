Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5409C55385E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352251AbiFURBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350883AbiFURBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:01:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF502286E3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:01:39 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o73so10579986qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndYFg9yJFFsm+MchCSau+vce/mgo6x0ybmLOESsjBAU=;
        b=FGvOHsGGUGmDXbxdMzvu/CDu6NuiY5QvnTnk1/HR+gu1fNI5L26/9Wo9ifp221Wh3p
         wfKeopgo8ivR4mjQrM6YDmsy1kMjzCfUFIwYUgKPQjrdrOPWt9bn7KPMvrD2eyl5s8hJ
         CpVAFnNGoovLlcunn8PvM7fh49U2rQjSWLgpBzQGubxFdDFwUxuXzHM7R3eWIDrFAXte
         gliH8epLnJYwan5t2e4UUIuk68H9+WuoTE/X2nkFAS37sKR2kismFsaFDQ8rhVkXJpwe
         SHd0pNYbEBN3++NazBy5etqW1jy9y427VaLEReT1YH4C1QcTwkolxF4z00aJV2EVQfkr
         au+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndYFg9yJFFsm+MchCSau+vce/mgo6x0ybmLOESsjBAU=;
        b=xsQfsxnfXNfCCN9Y8DzQS+S/2JSkPxBi4ZrSn2iQUT0ibJUdjNvxBE7DWmtb0s1p+F
         D/yOanW39MVvhu7rAS0EV+zx3jW4aXuBoEWX77V9l30T2Q0LMNtIgT5W42M/LDJeJIhY
         lIMQ7RjGFq1qO4x0ata7U7IAl8FPpk7tdhQGSjbIpMj+NCrV8/m6R0TNQbVxd4GqRcnD
         vDaZZHeph+2h4G8qmVApSFUhY9BQ6mj9jUTQMVLfh7VJZmgMNCmGucCFnAAEnAnQLbZT
         5wj+sO9UbRIURUl8c5Hn+LsvLIN73G5fJj2BV9eIzpffkLggdIyPafEZ9XDaSa/a3xQq
         stwA==
X-Gm-Message-State: AJIora8jzjWpA5N81UR+EEVwwEw25l+Dw3x2mLCaOMroQHuACMq0cb39
        +8SQqeVzA6+tzU5tNsPAAD+XzG3iwf14TvEh+2D/Uw==
X-Google-Smtp-Source: AGRyM1uXAP09+bwhOkQRsesIc4uC3aUOpDDew+bAcVuvJA0BtGFIEUAl8yeVqSD68KuR3Bs6PmzCsdahWfCGU4Cb8tM=
X-Received: by 2002:a37:a83:0:b0:6a6:7e4d:41dc with SMTP id
 125-20020a370a83000000b006a67e4d41dcmr20646327qkk.59.1655830897913; Tue, 21
 Jun 2022 10:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160621.24415-1-y.oudjana@protonmail.com> <20220621160621.24415-2-y.oudjana@protonmail.com>
In-Reply-To: <20220621160621.24415-2-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 20:01:27 +0300
Message-ID: <CAA8EJpqHBRHw4+0-P-KAT4JnAHkXUwTdXM9j2d-n66B3Yr+A+w@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: qcom: msm8996-cpu: Rename DIV_2_INDEX to SMUX_INDEX
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 19:07, Yassine Oudjana <yassine.oudjana@gmail.com> wrote:
>
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> The parent at this index is the secondary mux, which can connect
> not only to primary PLL/2 but also to XO. Rename the index to SMUX_INDEX
> to better reflect the parent.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/clk/qcom/clk-cpu-8996.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


-- 
With best wishes
Dmitry
