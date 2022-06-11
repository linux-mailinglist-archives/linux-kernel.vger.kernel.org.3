Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C27547250
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiFKGP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiFKGPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:15:55 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23DE3A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:15:52 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e93bbb54f9so1820130fac.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=VTKjR9J4dzoae+YBRke5SnGRPApYN87UxusBPdbF2KE=;
        b=AnUXfulXmU8MEv3PEde7hHyZIHBZMs7O2D5TI9BR3ZytKSqULoVY2tB2B/G/cSaRuh
         d25qEB69gWtDjyWLoPWKupuqsX9GEuT26cLSqiZS+nATU15Yy6mfK3bzUK5DkFoDlKTV
         GWWsHUpvRkIK6WxmiZiTF07JFDFKQxcmxOqlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=VTKjR9J4dzoae+YBRke5SnGRPApYN87UxusBPdbF2KE=;
        b=gZy8qaAo2/PYh7ylR/dp9qsb1Kqp3bWFtOQGzOTI0HswRJWtqLkKH2GZCp1JN7NII7
         RX5p+8tmYDo2BduvjquG40xHW2R55cqrA0yVfZMzmtsm9cA8L2qt2Y7H5r4YJ0Tbex/n
         0SdU2vasjz30rF6Y2dOmX+MAI0oWS2A/ahmizvb19HF7czhq42k0i1ENl757P5MsjB5f
         H8rMowMiaFj7PupzDnLEsP4eGxLrI8ey13jB8GMeweiX/crjQwz7wS76B1eEn2Z09B2R
         XHWW1HpAo3VC/o6EtQewSp1pRsoOZRsmu1TDu8EJQckkydvNK+vIh+8CFbVPWoUH6jA/
         pszQ==
X-Gm-Message-State: AOAM533dWmtvh0cxgWKzglCz0KqdkLvBO/MGJlWyCJ8yi4utDGv0NDBI
        1l8rt+hDGhqJhjMlRkT/neiVYbFt3AMUIhBa1O3tow==
X-Google-Smtp-Source: ABdhPJzbNfqQrErnPRd5zH8RtCVRU6bbLe/df5ml8E2KvzxEVk7l2sxNN9+pKPB5imCFCS9iZUpgVfe3ss32nRzIhGo=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr1882765oap.63.1654928151857; Fri, 10 Jun
 2022 23:15:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jun 2022 23:15:51 -0700
MIME-Version: 1.0
In-Reply-To: <1654921357-16400-2-git-send-email-quic_srivasam@quicinc.com>
References: <1654921357-16400-1-git-send-email-quic_srivasam@quicinc.com> <1654921357-16400-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 10 Jun 2022 23:15:51 -0700
Message-ID: <CAE-0n50k1TeE_JaZ7jT7n3QzHsF9f+pE57mRC9PeBgsNPtOtbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: sc7280: Add boolean
 param for ADSP bypass platforms
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@quicinc.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
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

Quoting Srinivasa Rao Mandadapu (2022-06-10 21:22:36)
> Add boolean param qcom,adsp-bypass-mode to support adsp bypassed sc7280
> platforms. Which is required to make clock voting as optional for ADSP
> bypass platforms.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> index d32ee32..33d1d37 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> @@ -19,6 +19,11 @@ properties:
>    compatible:
>      const: qcom,sc7280-lpass-lpi-pinctrl
>
> +  qcom,adsp-bypass-mode:
> +    description:
> +      Tells ADSP is in bypass mode.

Doubt "Tells" is required, but OK.
