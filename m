Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AB356C0C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiGHR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbiGHR7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:59:13 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF181EC5E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:59:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s188so27649345oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=YHV2Cc5LaBeGv/AExh1dctdQCQcN3cDdvTIsITOZX7o=;
        b=SldvymO6Yx3hvrPoQMk0aRKOPOW/TDdG0xvoqwq2gjl3jQDewEQNxT7IZ2n4Y6Gu4l
         1xcyHRkCgBMAuyc9PpJUug4dwDal14CECAA7tgXkyHs4GcEPkOxnJ2O2ak6sdWhta0wq
         q6WxCmt02sZKcOWwAvCuLlMjiru2aylxIdRlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=YHV2Cc5LaBeGv/AExh1dctdQCQcN3cDdvTIsITOZX7o=;
        b=pd0Ci5tD3WsO1p2PDttEs9/76zHuQP+d5evKaMEJInVHVl6lxg6fZnAjn+mY4DXt9E
         ujbb39Wzng0eqaI0ukoQ9eKOfQZe46nQDPnY4qOjfz5qxUG3EBdf3MCy0yMD7YkgVhQe
         AsFBa1iyAqWadk7iKKbk8RghRwqPFwlHVsyEFTSg1XUGzNmaUGV4OINtkgrZtR0GjZKc
         HUUD+eFw7FZxMy3PFzUw+0MJGMDaPtJ7fbm7eHsYTXKERoIOO9S0vZo01gL/LlWf3Qmv
         Wlf4Bj3DnPFXbsEXinvk4HPPQ/wBA2n8um9nyA2w32FaEIjypCxcBrv5Z5v2XaZMDNOx
         39TQ==
X-Gm-Message-State: AJIora/RYg3ANHcJWLB2ZgpuXRRb1y0s2JsWR0Pmt2H+egN3fumFLcjM
        Xu3jqScTkT8WVuNbdojcwXCL4DJA8Nx2Ogmk5HW7yxnDFPQ=
X-Google-Smtp-Source: AGRyM1uArgMx4SavTqMDhwhs03SUm2moqY8zMl1EvGjoPdvbyFKjlJ+ON6yeDAIwwIeg6LPbcSDqSg6//DxGeB4CkAs=
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id
 k7-20020a0568080e8700b0032e47890d2cmr578880oil.193.1657303151889; Fri, 08 Jul
 2022 10:59:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Jul 2022 10:59:11 -0700
MIME-Version: 1.0
In-Reply-To: <1657197381-1271-1-git-send-email-quic_srivasam@quicinc.com>
References: <1657197381-1271-1-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 8 Jul 2022 10:59:11 -0700
Message-ID: <CAE-0n53X8yyWr+Q+3RpciCeZcW+t+jgZs3eqNF9O8hJcw0cq0Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Move wcd specific pin conf
 to common file
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-07-07 05:36:21)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
> index 32a1e78..859faaa 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
> @@ -5,6 +5,70 @@
>   * Copyright (c) 2022, The Linux Foundation. All rights reserved.
>   */
>
> +/* PINCTRL */
> +
> +&lpass_dmic01_clk {
> +       drive-strength = <8>;
> +       bias-disable;
> +};
> +
> +&lpass_dmic01_clk_sleep {
> +       drive-strength = <2>;
> +};
> +
> +&lpass_dmic01_data {
> +       bias-pull-down;
> +};
> +
> +&lpass_dmic23_clk {
> +       drive-strength = <8>;
> +       bias-disable;
> +};
> +
> +&lpass_dmic23_clk_sleep {
> +       drive-strength = <2>;
> +};
> +
> +&lpass_dmic23_data {
> +       bias-pull-down;
> +};
> +
> +&lpass_rx_swr_clk {
> +       drive-strength = <2>;
> +       slew-rate = <1>;
> +       bias-disable;
> +};
> +
> +&lpass_rx_swr_clk_sleep {
> +       bias-pull-down;
> +};
> +
> +&lpass_rx_swr_data {
> +       drive-strength = <2>;

I suspect this was discussed before, but why do we need to modify drive
strengths on pins that aren't in output mode? I assume either rx_swr or
tx_swr is unidirectional.

> +       slew-rate = <1>;
> +       bias-bus-hold;
> +};
> +
> +&lpass_rx_swr_data_sleep {
> +       bias-pull-down;
> +};
> +
> +&lpass_tx_swr_clk {
> +       drive-strength = <2>;
> +       slew-rate = <1>;
> +       bias-disable;
> +};
> +
> +&lpass_tx_swr_clk_sleep {
> +       bias-pull-down;
> +};
> +
> +&lpass_tx_swr_data {
> +       drive-strength = <2>;
> +       slew-rate = <1>;
> +       bias-bus-hold;
> +};
> +
>  &mi2s1_data0 {
>         drive-strength = <6>;
>         bias-disable;
