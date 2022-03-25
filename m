Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7434E784B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359185AbiCYPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377958AbiCYPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:44:18 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91685584
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:42:43 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id d15-20020a9d72cf000000b005cda54187c3so5763901otk.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=y+mMvimQyRReQzRmfPyQugpTb6KG//ze5sefX1RwzhQ=;
        b=KEOJLdQ4cdEZxgsF3zBF9Ye2G1hZitw7712GCu1+psLG5lYYcqVhFc3hVFweWwrEjY
         oTyog9ZPYy6+sCLYPHGjl5LLTwwUIerWjM1jmd/9HknBXGXgjbD+KSVyGL+15zqKKIzQ
         pGQNjZGXzEDOM9g2mdBcqdMsb7hHunZ9kdYBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=y+mMvimQyRReQzRmfPyQugpTb6KG//ze5sefX1RwzhQ=;
        b=Rcyz4UcUNDVw+Z8w/F4yhxtTsSM1FAVVim8KuOPjMHjMXfx0SNpZ8SbMg7rQITnmUO
         bS/qsVokDjyeR8wZ/+Q1FxgNowiycr6q39jMAgU+ZbCBerZbccizGNX6X6B0N2vduUTt
         W+1ARte7UZ/hhmH0V5izn8LCMQ3/E2ZVj2LVSv361d0VcVszlSRbfH+PB6iBi8lvQU0A
         VSipVKWQXt0uo8CwVD+US30JVz2W4OrbXZ/QNh4+5miBSNmUVGr9Jchvy9eGJZThAHXW
         ZMqp4GuNWGSyd+WxYhh4OkgQOwrbYMCjsbUN+ZRYEVIJzQP+NfNWuMlIoKTPViwuDudq
         y7uA==
X-Gm-Message-State: AOAM531MAJShARj4e17g38DcNCHi6hnjNY4Ljsl7RTWrmJrswdaD0J2k
        iWHc4OKsayg8Cl/dUmdmEC/5t0i71qnE7F/l3iSGpw==
X-Google-Smtp-Source: ABdhPJwJ5Gq+nN3wnkjwmbTENOeA32A+fUspgT2HrNlzuSrTrJWLFo0Sp9DqVPbF7c9Pm2B0FHJmuD0002UbyLd9osA=
X-Received: by 2002:a05:6830:61b:b0:5cc:e44:7dc3 with SMTP id
 w27-20020a056830061b00b005cc0e447dc3mr4431819oti.159.1648222963153; Fri, 25
 Mar 2022 08:42:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 10:42:42 -0500
MIME-Version: 1.0
In-Reply-To: <20220325081100.1.I9f06fec63b978699fe62591fec9e5ac31bb3a69d@changeid>
References: <20220325081100.1.I9f06fec63b978699fe62591fec9e5ac31bb3a69d@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 10:42:42 -0500
Message-ID: <CAE-0n50hUGbH7_khhbsg3fbX_MCK0gEoStk-3xoUzje_a1=KQQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-herobrine: Audio codec wants
 1.8V, not 1.62V
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-03-25 08:11:05)
> The L2C rail on herobrine boards is intended to go to the audio
> codec. Let's override the 1.62V specified in the qcard.dtsi file to be
> 1.8V.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index dc17f2079695..c2075f3e7c4b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -339,6 +339,16 @@ keyboard_backlight: keyboard-backlight {
>  ts_avdd:      &pp3300_left_in_mlb {};
>  vreg_edp_3p3: &pp3300_left_in_mlb {};
>
> +/* Regulator overrides from Qcard */

This one isn't in ALL CAPS? :)

> +
> +/*
> + * Herobrine boards only use l2c to power an external audio codec (like
> + * alc5682) and we want that to be at 1.8V, not at some slightly lower voltage.
> + */
> +&vreg_l2c_1p8 {
> +       regulator-min-microvolt = <1800000>;
> +};
> +
>  /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
