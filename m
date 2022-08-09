Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24EE58DC23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbiHIQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHIQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:34:19 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F027D1E3FD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:34:18 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10ea9ef5838so14579115fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=mrzCWl4wXLDQ9LiMVdz5G5o2linAVEwBqBEugoIDThQ=;
        b=bivxvKkx0DGxNAfoV4XfuCsR+5ahztvgm9So203muwY2a4BVP3r8bC9wtLs8g13Q7t
         qV6JzBPQEUE8RKRu9GgUqJvc8yTClkyIq0ThBmZb4SnoCzEgdKhHDPN9qlYjpq7TwN0c
         Xu0yrRv6qGQ/jztavSYa+eJWPO0QnG0jwGjec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=mrzCWl4wXLDQ9LiMVdz5G5o2linAVEwBqBEugoIDThQ=;
        b=XviSfiq1pjzvUsWjJ+osX8DaMnLcweaqvKmHV4bVB0EmT031Ua2mB9BDXP9Riz/2lu
         LjT+6+bDJPTwihvE/JUBUzWMXnX2m1oc7+z8ienS5sa/aYMkzPIClU+BFKIwdPTm5ZKX
         e/+A5s152oD8GVQE73Drf8kcU4DnVdmqB5ldaCb+Q0hzMJdSHCW3rhQyroNpr24iJb17
         3OPOruWD2iL+BAv+7t9X6yf39Z1/eD/MmrtcTX2BQjuzYrjH09dZxz05N7ZrtqUMDOsz
         vcK6uV6YyQhmGDsTnvCB03NPr7XuIV6IlLNUufq1Cm85L1Q3G6bg/QjfArOCNrk97r5+
         5KxQ==
X-Gm-Message-State: ACgBeo20kG+7r1N8Akx/jra+dL7VHgt35K59vnzyJaPx2uOrP3CT0pik
        dQKX7WUSY3TIExueU/K9MoGdUQsUQXnQcvTjNt8ftQ==
X-Google-Smtp-Source: AA6agR4U1XJNDLlgR9CxQ7I2mD1g5PVq2QU6uXNOOzNluG3CgW8UxXxij155UMrLOMvKFwE3aqqeK3YEI0VVeY8Lh24=
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id
 fo23-20020a0568709a1700b000e903d1f91amr10875285oab.44.1660062858237; Tue, 09
 Aug 2022 09:34:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Aug 2022 11:34:17 -0500
MIME-Version: 1.0
In-Reply-To: <1660026909-7365-2-git-send-email-quic_c_skakit@quicinc.com>
References: <1660026909-7365-1-git-send-email-quic_c_skakit@quicinc.com> <1660026909-7365-2-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 9 Aug 2022 11:34:17 -0500
Message-ID: <CAE-0n52t0MPDxGQNEdhNaqOBhUhr8FBew_cuEwmruN12k4f15A@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] arm64: dts: qcom: sc7280: Cleanup the lpasscc node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-08-08 23:35:07)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 13d7f26..71735bb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2168,9 +2168,8 @@
>                 lpasscc: lpasscc@3000000 {
>                         compatible = "qcom,sc7280-lpasscc";
>                         reg = <0 0x03000000 0 0x40>,
> -                             <0 0x03c04000 0 0x4>,
> -                             <0 0x03389000 0 0x24>;
> -                       reg-names = "qdsp6ss", "top_cc", "cc";
> +                                 <0 0x03c04000 0 0x4>;

This looks oddly tabbed out? I'd expect it to align with the first reg
property, so be unchanged.

> +                       reg-names = "qdsp6ss", "top_cc";
>                         clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
>                         clock-names = "iface";
