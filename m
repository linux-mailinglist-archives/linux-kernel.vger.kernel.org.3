Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB0E4EFCA9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353276AbiDAWLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353258AbiDAWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:11:50 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838AB5A097
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:10:00 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-dee0378ce7so4205247fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6rY8NKT6m0nS75suQ+nFywMY6wDIOo3ms5SeTbFXvxM=;
        b=kwfOWInOCRYECvlHmEdCMRxg6iXPB40US4o+rR7nBbVs4TK8Xd3fhTJVHZw+Ipy+5/
         vZLKw3rgc3fV8tqsLjXS82Y9etsT89es+YtpxzQ62EcKTU8JmT299mEE+wiMZ9GzeJh6
         76DuwhxuZgF3SbR9FuuEqZa/f3t/o6hTNJ450=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6rY8NKT6m0nS75suQ+nFywMY6wDIOo3ms5SeTbFXvxM=;
        b=1s7eau8P0DT71q3d1Z/jJVDISK08J+47Wyh/7VmCDswnLdC2W8m16MdFKf5zqa6DkJ
         nONTsuK/q528IheE2Xx7hBy3LFf2pxwgKyHxf8mrGpiJljjtCabf2r+F+krCdu4SZMco
         6PamCZG3JL0SYd9JGf/rPkLjfxHmQmbwABPLX/m/9iN8keZvMuiyIzUHbSTJ1V3n4MZb
         /VmG8hayF+I+llqeVIRAHI5+AvPnZSTJaN9lxwwrRdRfTY/T0+oJdukXKCF6Sp7exa3C
         0KOCWyAxn8GeQmmDjfwbZS2VcID0KZ5TejqmKMlPm8EM9so2dMeCYzo4+S+r+ES66ih/
         JbXQ==
X-Gm-Message-State: AOAM5318slz24lYcM8qcPxa3lBQ9ksMLPtc7c36JdvyyHSvmZH974mU1
        4K6ZxHBYQfhMyOsaMGxR3hED0kW/YVx/NWqyZYVxdw==
X-Google-Smtp-Source: ABdhPJxQSBjHCimqKqmmEHvxpus5i7XPHVv6wtC8jb98htsIgcr/Uv9JRMFkIVcC3CNZ/kGzLXUj7+8PEY7X3yjZuXE=
X-Received: by 2002:a05:6870:b69c:b0:dd:b74b:4099 with SMTP id
 cy28-20020a056870b69c00b000ddb74b4099mr5768834oab.193.1648850999220; Fri, 01
 Apr 2022 15:09:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Apr 2022 17:09:58 -0500
MIME-Version: 1.0
In-Reply-To: <1647532165-6302-3-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com> <1647532165-6302-3-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 1 Apr 2022 17:09:58 -0500
Message-ID: <CAE-0n53BBzgU6AJ70JNUBBkDZ1c9ZmpX8ZXLcxLxmmg1=UnSLw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Add reset entries for
 SDCC controllers
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shaik Sajida Bhanu (2022-03-17 08:49:25)
> Add gcc hardware reset entries for eMMC and SD card.
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index c07765d..cd50ea3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -881,6 +881,10 @@
>                         mmc-hs400-1_8v;
>                         mmc-hs400-enhanced-strobe;
>
> +                       /* gcc hardware reset entry for eMMC */

Please don't add this worthless comment.

> +                       resets = <&gcc GCC_SDCC1_BCR>;
> +                       reset-names = "core_reset";

A "_reset" postfix is redundant. In fact, reset-names shouldn't even be
required.

> +
>                         sdhc1_opp_table: opp-table {
>                                 compatible = "operating-points-v2";
>
> @@ -2686,6 +2690,10 @@
>
>                         qcom,dll-config = <0x0007642c>;
>
> +                       /* gcc hardware reset entry for SD card */

Please don't add this worthless comment.

> +                       resets = <&gcc GCC_SDCC2_BCR>;
> +                       reset-names = "core_reset";
> +
>                         sdhc2_opp_table: opp-table {
>                                 compatible = "operating-points-v2";
>
