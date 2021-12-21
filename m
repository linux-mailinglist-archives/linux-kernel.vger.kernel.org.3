Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583E247B95A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhLUFWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhLUFWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:22:20 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1EC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 21:22:20 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso15274298ots.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 21:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S7rrl45AdyxxKacHinE6NR1eVjErEjJCz4ycjQLwVQg=;
        b=oCNcDUAZbTfjq4JDIkmJAS2ynHZ19RLCG39RfHRpI81pC04bGnN4LTO2UVHMC7rlms
         AGbQJjZeMADxThyV9NplBENhPp+MlTbuPjjiagX2vGLu6JCMCKgwd+OGMnS0Z19OQKv+
         omm69/Kkxe+PE4evCyWRrQecA8MQ3EY+6iM8Hr4g7fRTFg1QSDAfmUkkpyjgBSHyR8wK
         ZdhT9nZuzlXFvyCMflottA5EYq4gD5CIE1XJMhKOWAP5W2gEqLE71F8onN3GrAARIcBs
         g07yb7f7RFTj7vSdcvct/y0rcs0gCcIpi5oUtWODaPnwD7lhktbFwdtTEQudE/FUSJvE
         6EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7rrl45AdyxxKacHinE6NR1eVjErEjJCz4ycjQLwVQg=;
        b=rgvftLG96HnXEyaW7WbwulzlEkwFHW1Kkuh9K3JCJVOh10e9me38dhdKK5vV9zZij3
         TliN+PAA7lnyT5pKxJ/wqKRX3s+CSmKp8jxaC1L2xoEfMaBC3tKEL+/GoezA2cXtGWYq
         vrbaNcd8Xyz+Fm5rd37D4FXE8a3oFiV7Jedin49wvPVWINowZwTQ/BShAdUt1VMcKFtu
         rEjAfPWp9qAriecfhOXgQGqJ752oFlyfB+oOgd9V1/NHgNaxpoXMUL0CIjb+n6fC/0U1
         Tr85yzZkNVkgMNzmJB5He70VfbGbA9egYOfbj34PM/i1fdVMlCQRFcf907tlOCRugyyD
         M86w==
X-Gm-Message-State: AOAM530DUxSL36KTECe+0buY0AcoCevncVlc2hcQlIOdKEoFS3rfQLjc
        NaDDi3BwYnLUpjg85KfXANXbXQ==
X-Google-Smtp-Source: ABdhPJzncsqjstcyJUyav6KPDF+CRGhZ+ROYuYW2Sw+DClXfd4rJnrU7jyTRy06q+QOeRE9/aW0+vQ==
X-Received: by 2002:a9d:7548:: with SMTP id b8mr1047567otl.92.1640064139484;
        Mon, 20 Dec 2021 21:22:19 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f9sm3582053oto.56.2021.12.20.21.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 21:22:19 -0800 (PST)
Date:   Mon, 20 Dec 2021 21:23:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY
 bindings
Message-ID: <YcFk0PdQxMhwrdU+@ripper>
References: <20211218141754.503661-1-dmitry.baryshkov@linaro.org>
 <20211218141754.503661-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141754.503661-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18 Dec 06:17 PST 2021, Dmitry Baryshkov wrote:

> There are two different PCIe PHYs on SM8450, one having one lane and
> another with two lanes. Add support for second (gen4, two lanes) PHY.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index d18075cb2b5d..41a8d00bd576 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -51,6 +51,7 @@ properties:
>        - qcom,sm8350-qmp-usb3-phy
>        - qcom,sm8350-qmp-usb3-uni-phy
>        - qcom,sm8450-qmp-gen3x1-pcie-phy
> +      - qcom,sm8450-qmp-gen4x2-pcie-phy
>        - qcom,sm8450-qmp-ufs-phy
>        - qcom,sdx55-qmp-pcie-phy
>        - qcom,sdx55-qmp-usb3-uni-phy
> @@ -335,6 +336,7 @@ allOf:
>                - qcom,sm8250-qmp-gen3x2-pcie-phy
>                - qcom,sm8250-qmp-modem-pcie-phy
>                - qcom,sm8450-qmp-gen3x1-pcie-phy
> +              - qcom,sm8450-qmp-gen4x2-pcie-phy
>      then:
>        properties:
>          clocks:
> -- 
> 2.34.1
> 
