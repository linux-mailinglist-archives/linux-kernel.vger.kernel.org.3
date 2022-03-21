Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD984E31CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353350AbiCUUbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348478AbiCUUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:31:43 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470E07CB0A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:30:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id ay7so17499515oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SVEe7hUZOZ574KT711GyJJUr8pqUU3sbXrrP/FH6lUQ=;
        b=HgN8E2bzL5A2bOlDz55Mv25/tt/RKwL9jSNjt40u/m04w3/7P+7g9c1HkyBvlAeQfV
         2dhF+CnMi7h+Hj27pLjB7vrt+MzJ33fr0SD0TfhrIdKlbvJbV3XL81l38mZBlmlSDQYN
         U405VmvwgH/ui0st6tSGtygKgfRSLlo87paTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SVEe7hUZOZ574KT711GyJJUr8pqUU3sbXrrP/FH6lUQ=;
        b=2e+ucJCNG2KrDyuPh0ppDmyaE19e2p2RpneV1BV/V5fCIrLRBqDiCIWrRhUlbJkOwB
         OUHJRJiA4TmHBCtNpOQ6egLNpnGTdcQzrlw0h7D3Q+hmpHt3cTxEg87rv49L22uxGdpd
         Pe7c2j7EjWethlXd4kHc4LhctbYuPotKPCNvI/lQ5BRmO29aCXK72Cvzqi6FXz6Eqk+c
         Ud0hkZdr+29ED1b2aMJ7IV6nT8iT1s9JNwlHxpcrazV9IjxayhciMO60pNa7Z2EASAT7
         JtM3/kV/eekawh3RnVmlU+VALvrQrTm8QnJiV2YBAllhnwT60CZjeOaoPU+1nSCPHY7/
         840Q==
X-Gm-Message-State: AOAM532wD2maTsYSF7JVFVFxPB8Q9DGdnfxe5yWf14TLaDU7i5ktvl3O
        Ttkgiy2X2IojEwCy92YqsVwnVRB1hCGu1vAkcv0CEw==
X-Google-Smtp-Source: ABdhPJy+w/ls2aSZCJrRsAdMrUWPb6dkwdIyuIvulQVig3ErIeGd57xFdDTojd0oyBT5QVRYIJdm9YWYMeqLFjZcwKg=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr428878oie.193.1647894616632; Mon, 21
 Mar 2022 13:30:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Mar 2022 21:30:16 +0100
MIME-Version: 1.0
In-Reply-To: <1647863959-3289-3-git-send-email-quic_srivasam@quicinc.com>
References: <1647863959-3289-1-git-send-email-quic_srivasam@quicinc.com> <1647863959-3289-3-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 21 Mar 2022 21:30:16 +0100
Message-ID: <CAE-0n5131FQaejVVHKwW9ZnoGM+uy6+jjJZMkh5Pa82=r5ojuQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-03-21 04:59:18)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 688fa95..4a7b18a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -462,7 +462,28 @@
>         drive-strength = <10>;
>  };
>
> +&sec_mi2s_data0 {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&sec_mi2s_sclk {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&sec_mi2s_ws {
> +       drive-strength = <6>;
> +};
> +
>  &tlmm {
> +       amp_en: amp-en {
> +               pins = "gpio63";
> +               function = "gpio";

I'm pretty sure 'function = "gpio"' isn't needed. When a gpio is
requested with gpio functions it gets muxed to gpio function
automatically. See commit 1de7ddb3a15c ("pinctrl: msm: Mux out gpio
function with gpio_request()").

> +               bias-pull-down;
> +               drive-strength = <2>;
> +       };
> +
>         bt_en: bt-en {
>                 pins = "gpio85";
>                 function = "gpio";
