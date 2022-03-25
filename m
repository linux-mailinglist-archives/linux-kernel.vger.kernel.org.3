Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD7A4E7D4C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiCYToh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiCYTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:43:30 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E058221DF19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:14:18 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-d6ca46da48so9003630fac.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=xroX1x4vfWAmQcD+WNgrxfLEz2UKk5daAF8OyyDV8E8=;
        b=LJQQCAmCZbfr9l5xxCdJzKz9F2magsaYfevnAZwZb6BtU/lljkhMhmUruElbPWYRSR
         UuwlW2K9uhj32EZUX+jrinNLGbg1tBPVN9RDjfXYvASNzVt9uw82q3EKkfMw06N70Ev+
         xS+sjEFeKchM9iGxTV5hgnfiOpi+elsMNkFWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=xroX1x4vfWAmQcD+WNgrxfLEz2UKk5daAF8OyyDV8E8=;
        b=8N6etz7jOK0Rgl3lfSITPa0Dkdm1gocGpMnopiF8vp6U+w1FOINt9bMMTRxPJgomin
         Okinhq7AR8nX/bxI3XkJAPlX95NoQ0YQRp/pX6H/6KS1gQCm2R7ZgPCne6peYnJKbJck
         IwwImO8g4jT69UsYuRk2vHAhpKmUgUpOqzpRlvFRWYP9W7WIqgKs+r0c09P+EKu6bSgX
         fX3xKB7OnzHzMiXjUmM2r0k60Bm3v0HMB2KCa61/epfvc6hJbbhZRMq+6e5oSyzajs1G
         6JFO7EGfQvGFFWYyjJ28CCp9pOwwL3SVEwF3yMY45uW3QPPy4JkWJ/JOEYs+DvhHt1Ko
         eb8Q==
X-Gm-Message-State: AOAM533wGJ6B+ydauE4cagpUT8Q8VBdB54igCRWGcTQyzehZtY+dt7U3
        pJUfWw+Qh0697W0dpSK+YwSQKXvGCH7bokSKxuOeNXvMwe8=
X-Google-Smtp-Source: ABdhPJxFnDvR+8O0qWhbA9VKyiH4QLwRIWZOGlc8HRnYIjqHnb6Nw0UGNH22srX4kIJMdYZuAU+YRhSRuizdqD+7dKY=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr6007460oif.63.1648231322654; Fri, 25
 Mar 2022 11:02:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 13:02:02 -0500
MIME-Version: 1.0
In-Reply-To: <1648209491-30165-2-git-send-email-quic_c_skakit@quicinc.com>
References: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com> <1648209491-30165-2-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 13:02:02 -0500
Message-ID: <CAE-0n523f-aAUkj1SUscNgw_Gh=mP8JfXV4u_hNeFhqtfr_Fgg@mail.gmail.com>
Subject: Re: [PATCH V8 1/7] dt-bindings: mfd: pm8008: Modify the compatible as
 per driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-03-25 04:58:05)
> Modify the compatible string as per the pm8008 mfd driver.
> Add reset-gpios property and make interrupts and interrupt-cells
> as optional properties, they are not strictly required and may
> cause yaml compilation errors when not added in the DT files.

Does it have an interrupt controller inside? If so, the properties
should be present even if the driver isn't using them.

>
> Also, change the node name in example to match with the
> pm8008_infra DT node.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V5:
>  - Remove compatible for regulators node.
>  - Move supply nodes of the regulators to chip level.
>
> Changes in V6:
>  - No changes.
>
> Changes in V7:
>  - Removed the intermediate regulators node and added ldos
>    directly under mfd node.
>
> Changes in V8:
>  - Change the compatible as per driver, remove interrupts from required
>    properties, add reset-gpios and move regulators to separate binding.
>
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> index ec3138c..12431ea 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> @@ -16,7 +16,7 @@ description: |
>
>  properties:
>    compatible:
> -    const: qcom,pm8008
> +    const: qcom,pm8008-infra

Why is the compatible being replaced with -infra postfix?

>
>    reg:
>      description:
> @@ -44,6 +44,10 @@ properties:
>    "#size-cells":
>      const: 0
>
> +  reset-gpios:
> +    description: |
> +      Specifies the GPIO to be toggled to bring pm8008 chip out of reset.

Remove description. Add maxItems: 1

> +
>  patternProperties:
>    "^gpio@[0-9a-f]+$":
>      type: object
> @@ -88,10 +92,8 @@ patternProperties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>    - "#address-cells"
>    - "#size-cells"
> -  - "#interrupt-cells"

Should reset-gpios be required? I'd expect this patch to be adding
reset-gpios and making it required and that's about it. Given that
there isn't a DT using this compatible upstream so far it looks like we
don't need to do anything like worry about backwards compatibility.

>
>  additionalProperties: false
>
> @@ -99,11 +101,12 @@ examples:
>    - |
>      #include <dt-bindings/mfd/qcom-pm8008.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
>      qupv3_se13_i2c {
>        #address-cells = <1>;
>        #size-cells = <0>;
> -      pm8008i@8 {
> -        compatible = "qcom,pm8008";
> +      pm8008_infra: pmic@8 {

Remove unused phandle.

> +        compatible = "qcom,pm8008-infra";
>          reg = <0x8>;
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -113,6 +116,8 @@ examples:
>          interrupt-parent = <&tlmm>;
>          interrupts = <32 IRQ_TYPE_EDGE_RISING>;
>
> +        reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_HIGH>;
> +
>          pm8008_gpios: gpio@c000 {
>            compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
>            reg = <0xc000>;
> --
> 2.7.4
>
