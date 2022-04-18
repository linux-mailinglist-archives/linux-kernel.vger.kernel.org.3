Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696EE505FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiDRWhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiDRWhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:37:12 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875A1CB3E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:34:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id u12so7817901ybi.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4bp7iL2yyspTqvnvsBL/XA5iBMINfoj3Y9MqEf5ias=;
        b=XdZ6lm3r6iGJEWoX2xq3dAAIzSePIvfMd+0qhDZi9Eu+cByTIUZXD8xXzbt8FjLMeX
         kJ6OWM/IMrZBDIfcG3ZYOoSufnV9NFcdStTZZEnaPQ2yF5n+QHyrigww7uw2R1k5qRqF
         31x27LkiOOsSxvtf2ai4WlCSF+zVPTv2f7Byz5gr5r2HAnBN3i7QCvHDDPEhx9t5DD2W
         w23OW+bllYbf10kRb4nreZ2LQyFYreVyTeRmCLeW3Tl9vVQADUjuPpvVy12e+ROnaxeI
         yvFXGNxiGQLhaKKLz0wnxTQX1YDlAKosP8us1rlaVKrA2hD5yPjZ6JZSPynBk2cuhREs
         IAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4bp7iL2yyspTqvnvsBL/XA5iBMINfoj3Y9MqEf5ias=;
        b=32eTeKbgEvkjxwDpJSlVvkWMGO6qYCxh4KRmQGREJTDvyvpYltQygudi5tTH3BxZ7G
         cmfR8dO16Y9s9Y9VN0rQnt6lhJSTOyEeX+UhauM1cXQNuyFjM84+5/WtgpVu69GlMe8A
         JfpSqoY2THUrAm8QT4jdbD/Stg1PKUDYOVN9pJJ1f810OfMgpJ679CHFUWjZlLt9Z1CC
         0JiWJiESdOpIU3DwOYtqhYcv9V7oAocOn0RBOgjYyhRjmHISTwtV80g0ZqENJ8fL2ksP
         8vZ8rHWLS6No6XbeP9Ab6bUVlBcgbhb9DbqYABf1J424w2RdcjR0LxLwqYSW9dC0OgCD
         iP0Q==
X-Gm-Message-State: AOAM5329vttwY58rIcnvE/eWpNloHEm2w++C+B+RhNVogI7beI01gpK9
        V2wtrnWYFKl6Hc5h3Ibj1FVLyQ3/US1KH9LtpPkepA==
X-Google-Smtp-Source: ABdhPJwpC2AeuDc6EDutWUIMPkpQ03faH9GU9Uc9JsUqK7xQEFvl1zcCNPXqdBezv2UU/sFi5kHmUekjVpiyAfONTkI=
X-Received: by 2002:a25:2e45:0:b0:642:875d:c9a5 with SMTP id
 b5-20020a252e45000000b00642875dc9a5mr11488600ybn.314.1650321270240; Mon, 18
 Apr 2022 15:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220418205509.1102109-1-bhupesh.sharma@linaro.org> <20220418205509.1102109-3-bhupesh.sharma@linaro.org>
In-Reply-To: <20220418205509.1102109-3-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 19 Apr 2022 01:34:19 +0300
Message-ID: <CAA8EJpqh1pTfNR2Qd7p69i4VvqPNtbd5gOjO-TYdWTTG1rKrrA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: phy: qcom,qmp: Describe
 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, vkoul@kernel.org, bjorn.andersson@linaro.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 at 23:55, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Since a few boards based on QCoM qmp phy use the
> 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties to
> describe the ufs phy nodes, add them to the dt-bindings doc as well.

Ugh. They give a false sense that they are supported. I think in
reality they are not used by the kernel.
So, ideally, this patch should be accompanied with regulator core change.
Or (better) drop them completely.

>
> This fixes the following '$ make dtbs_check' warning(s):
>
> sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
>   'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of
>    the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index c39ead81ecd7..411c79dbfa15 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -90,6 +90,14 @@ properties:
>      minItems: 1
>      maxItems: 3
>
> +  vdda-max-microamp:
> +    description:
> +      Specifies max. load that can be drawn from phy supply.
> +
> +  vdda-pll-max-microamp:
> +    description:
> +      Specifies max. load that can be drawn from pll supply.
> +
>    vdda-phy-supply:
>      description:
>        Phandle to a regulator supply to PHY core block.
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
