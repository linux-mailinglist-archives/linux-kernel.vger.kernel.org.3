Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB7578F22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiGSAR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiGSARz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:17:55 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666EB33E03
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:17:53 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10bec750eedso28229969fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=u0irqfmHqQdSCttqKqkL2On19vi9rdiep3g+yXm0Hz4=;
        b=hWrpKodKFGkI61V6jnPTNLjRovQ5kYvbAQZUrKsh2o+j+MrWF81lFYn4JGCJQrjVfc
         hA7ur2d4iy+iA8ydciLdmYKXrSgaTqQgxMR+gAoHUm2l9SCLA2B4ZhNvW613M0oy7+h9
         tIb4kwwZxByVYw5iD/UPdrSOVeHpaZA5lmjIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=u0irqfmHqQdSCttqKqkL2On19vi9rdiep3g+yXm0Hz4=;
        b=2RhHodYZEsjUGNQw+rkDJw3PJFi8LTWmPziU+RA9i74V//sdV6l5e93Vz9iuVcLuDw
         3hNm0E/4Lt4dMviyKSo7yA+2pIF90R5e7FeI4hNReg+i0ZRcxRLliKXw5oxa94+/jH16
         KaTqjxCD7o0u7ibvns2A15/6KNlvlnYTePkYq8MX+k7G8+6z5hSrd+inrzQxOUzjlOGW
         vJsxVp4jpCIeMCnul8LwKow4w3YaNyeB+mzhL3GJFDJzGeTyYVwtny/ddRLF+tIlI5j/
         JgJzqyZYByA4btWw5Sb65bxDEA0efpSry+bvI2ZpBbXWUZs7DUh9k3qbt8GAIPz8EA5H
         H11w==
X-Gm-Message-State: AJIora8UxP/+Rxh3Wp8vkRHyw3NfeACw0xRK6BZrWSw5fxeYlGMTsJIy
        yI9EqZk8721uimgRqQmc0JB2VoP6ZzJG1RD9ecb/Ww==
X-Google-Smtp-Source: AGRyM1sdgaMRlYno+aEd3IrJirtVKeMwDWbJwEpcnwauQqs90jKZ2p9Qs1q3H6f9OsF05RR0VMCS6CQKBCA+CEG7iJ0=
X-Received: by 2002:a05:6808:2211:b0:339:e6c9:dc1 with SMTP id
 bd17-20020a056808221100b00339e6c90dc1mr14351607oib.44.1658189872810; Mon, 18
 Jul 2022 17:17:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Jul 2022 20:17:52 -0400
MIME-Version: 1.0
In-Reply-To: <20220718080252.789585-3-judyhsiao@chromium.org>
References: <20220718080252.789585-1-judyhsiao@chromium.org> <20220718080252.789585-3-judyhsiao@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 18 Jul 2022 20:17:52 -0400
Message-ID: <CAE-0n52cvF9AzVrExY4RLw802fBfBgQCFqDECqdfeezRUc3MtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
To:     Andy Gross <agross@kernel.org>, Judy Hsiao <judyhsiao@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Judy Hsiao (2022-07-18 01:02:51)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> new file mode 100644
> index 000000000000..ec8f2e555a14
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + *
> + * This file defines the common audio settings for the child boards using rt5682 codec.

Please limit this to 78 columns or so, splitting it to two lines.

> + *
> + * Copyright 2022 Google LLC.
> + */
[...]
> +
> +&lpass_cpu {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mi2s0_data0 &mi2s0_data1 &mi2s0_mclk &mi2s0_sclk &mi2s0_ws
> +                    &mi2s1_data0 &mi2s1_sclk &mi2s1_ws>;

This should be <&mi2s0_data0>, <&mi2s0_data1>, ... because the brackets
are about indicating the cells the phandle takes. The phandles don't
take any cells so they are closed immediately by '>'.

> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
