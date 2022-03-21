Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D84E30F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352847AbiCUTxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352842AbiCUTxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:53:50 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B016F061
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:52:22 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id ay7so17387268oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ok3RVltL8xCbLsqr5CfkTVPVWz4EKRmC9g7u5BKP3cI=;
        b=OYavUS59dk26LyBiY+BKFcEy8oe1jkfCsSArFJSB7rd8OZWWrOT0siAlHH/9NgcdBw
         wOmfgRGJWgh+cgDTD5QHC1UDlyIWoU/O3mkHW0oYxQJlNqvFQxPcdnqzJLf9QhrGLA1A
         EhbzmrkEX5Ns2SmbMFkLDkCKxWvYIfvEV9RrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ok3RVltL8xCbLsqr5CfkTVPVWz4EKRmC9g7u5BKP3cI=;
        b=qTG2QaOkO/lq92mPlO0iqoCgk9mOD/Ej3j4YA6U6svLy3nqpOzfqdHrHO19lyg3a+S
         qzhOVwyG3/4l2uYjzxKYH7f160c/IG/5X6I6ayWdrditTqNjj0QNZoGHX6Ro2TD2bBuW
         IVNI89cV52b8RsVGVhVdKagtIaZzcA55u7Sfsu4Nmc+tgps83BUQKZPL1ElHwfbR+BBv
         2ta58IPYaANkJMKCbrxuFkY8S6D/P2MdEd5zJU/ta/4CHqxd0kJPL2tTLcR/Ykd8z907
         pLpl3iwihaMB5JX2zMGVmaVtB/kwNEF3lnHPVm3/sO8k+9VBg+lmln5pWngGJOKWNZpE
         TXJA==
X-Gm-Message-State: AOAM532ww/8QfxQ8mV+Az/EySkspUlKhhmgC+mfCSYzj2T4Uu7WdR+fl
        8SN8BnPYdCka6quDL/RyIIda+80bOI8gtH2wxinJbQ==
X-Google-Smtp-Source: ABdhPJw/w3E47RE2s1O6mJ0xGYZGoSVgYc7BhnMuoFT0ytHU1sjUK0Ss3SAsOoPu7b3lNEtFDeCqCZfCoVVY74aLXVY=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr399339oif.63.1647892341694; Mon, 21 Mar
 2022 12:52:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Mar 2022 20:52:21 +0100
MIME-Version: 1.0
In-Reply-To: <1647865696-19192-3-git-send-email-quic_srivasam@quicinc.com>
References: <1647865696-19192-1-git-send-email-quic_srivasam@quicinc.com> <1647865696-19192-3-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 21 Mar 2022 20:52:21 +0100
Message-ID: <CAE-0n51iMpwMXayMEbPrqO2b=wX-Lz8DYiZMNnzRNGY1BNSKYg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
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

Quoting Srinivasa Rao Mandadapu (2022-03-21 05:28:15)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 499299a..e6ec334 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -19,6 +19,7 @@
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,lpass.h>
>  #include <dt-bindings/thermal/thermal.h>
>
>  / {
> @@ -1980,6 +1981,68 @@
>                         #clock-cells = <1>;
>                 };
>
> +               lpass_cpu: audio-subsystem@3260000 {

The unit address should match the first reg address. This should be
3987000. By the way, 'subsystem' looks redundant. Maybe just
'audio@3987000' or 'subsystem@3987000'?
