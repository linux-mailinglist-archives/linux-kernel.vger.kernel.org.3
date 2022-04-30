Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83DE515D83
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378140AbiD3N3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiD3N3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:29:17 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7083429C9C
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:25:56 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f863469afbso86316757b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64feOhocvLGn2fJsVd3fjrvb0tRje9mApVjwOF26BKs=;
        b=azUNnWcXCkr97DjIquiDIVbjSMXybkEmBz92ZEbhQT7Qicj/5fgDg4zJHbM2MoRkEk
         EinO0l6MFR1UyE2W8rteWaAsShr/qYH0PeEnHTPhR5GJ3gLF8/AYyPtaPlPyl5O/8pa/
         ClRNPRLvdQUVQ612nCoTt8v0EnY5c+8kYc/3X15ClSfxF9RMjhQlnervWD+Ne20R+5Ft
         XHNI4SJCW34yasJkOfLrCYRdPEpupz0QRTBp4SugOonFsT2SLhwlysc9VE9P5wi+g3xZ
         gmmq/YxQeblZwcLayc9HmNM3JEj/e8h6PcJoNRizeU8m1lu9QBAqGWEFwV+DMioCkmA+
         3D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64feOhocvLGn2fJsVd3fjrvb0tRje9mApVjwOF26BKs=;
        b=PtbhlulsZufBEpb5PpOgBi0qm6zucHqlsW/jqQ2URgoy+QXgMDNBtV3V6U6HRJ9OLJ
         RGwZVc61xesn/wBws9gU8vNvJ+AbHZRiITlr1f66yUP7Lis++eygJysbW3Ld+dXhBPpY
         G3VqrKuYPsllXsfQXN1Lln0QjFvtzToVjTUctJ8xUJP8i00Ytw98SHxD8qize0X6hqHO
         Hf1qYTrdsmQIoKh/rYc6mjAB1PLfULkP6oYbkYyy1iiNjfxHHiknwu1Hhk6ezNFquUjh
         l1CPZZE+Y5xHX3qtOGktNWBK4V5qUXjnzhOYws9QeG7DKtACNkKTfxPL382+10r/aGY9
         UhKg==
X-Gm-Message-State: AOAM5335A1HFX1dFz4TjS3QzgKnC7O9JoVx8QiHcnWAMOLiOZI0CDwzy
        MV1jgrXfV9patpjBjvDrY5nt33EDGepj0pRjj/0mMw==
X-Google-Smtp-Source: ABdhPJxoi3jJZl7joWc/2nnCDUb8N5KSDQA9caiC10LPVX4ArV5FkST7tiOSOjorT56fLrnw7cJe/TJuYyR9luW9+0Y=
X-Received: by 2002:a81:4c11:0:b0:2d1:1925:cd70 with SMTP id
 z17-20020a814c11000000b002d11925cd70mr3781507ywa.101.1651325155685; Sat, 30
 Apr 2022 06:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220430055118.1947-1-ansuelsmth@gmail.com> <20220430055118.1947-2-ansuelsmth@gmail.com>
In-Reply-To: <20220430055118.1947-2-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 30 Apr 2022 16:25:45 +0300
Message-ID: <CAA8EJpoxddxoWnX+aQbzeAQH_g04WsDqtQcY9vyu-XGJLfibkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: qcom: replace gcc PXO with pxo_board
 fixed clock
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 at 15:59, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Replace gcc PXO phandle to pxo_board fixed clock declared in the dts.
> gcc driver doesn't provide PXO_SRC as it's a fixed-clock. This cause a
> kernel panic if any driver actually try to use it.
>
> Fixes: 40cf5c884a96 ("ARM: dts: qcom: add L2CC and RPM for IPQ8064")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 996f4458d9fc..e6ca8d1d1c5f 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -304,7 +304,7 @@ cxo_board {
>                         clock-frequency = <25000000>;
>                 };
>
> -               pxo_board {
> +               pxo_board: pxo_board {
>                         compatible = "fixed-clock";
>                         #clock-cells = <0>;
>                         clock-frequency = <25000000>;
> @@ -782,7 +782,7 @@ tcsr: syscon@1a400000 {
>                 l2cc: clock-controller@2011000 {
>                         compatible = "qcom,kpss-gcc", "syscon";
>                         reg = <0x2011000 0x1000>;
> -                       clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> +                       clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
>                         clock-names = "pll8_vote", "pxo";
>                         clock-output-names = "acpu_l2_aux";
>                 };
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
