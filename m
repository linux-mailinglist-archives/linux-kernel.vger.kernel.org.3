Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4105B4670A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbhLCDXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbhLCDXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:23:12 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED5C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:19:49 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so638361oof.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HDps2h2SWpU4Y94NDG4hPcR7AZPRkd1wfAyLJyas85E=;
        b=iqgpLT8egn4PIMWsEDOkPYE+RgYdrE6libBZXgFiThm4cinKjw7geQDuINCFfWn09A
         tIGLKTiGej1fB9A9oqta/iqAVKevU4g0Phacs2pjKP+4igkQzqvZAe1VsII8qFiQSR1I
         YXIvlweVfBAbmJS8fDPZhYjhraL/YCEku3vCYPT3eO6rn7k0G8+J2MAFn2i6Hbc3yhbc
         7Oq7ymRfxBprWwo6duLAEB/nO8VYoiL9XbkOhGHL0cvPxa7wfPWAVgFIQPMP8pt6UXY/
         wYQVtlT/9h0Ps0zbDW7WiTswJh4yvhb4GRSYQ6j+EotrsNQNkPEx3M1GSFpludCOrarG
         9BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HDps2h2SWpU4Y94NDG4hPcR7AZPRkd1wfAyLJyas85E=;
        b=UUKWFnvef2O8gYh4+X9pyNsbhwhM9YiZNVQwu6A7oCY3NtcM0uGBta3ZX8po8NZmeU
         qcEuhFKCKpA7zjjc/Zyx2IJNho2rkumPgB1ePVlMobtUvKp+pFj3oCzjIx9tXRKjFkzg
         E1DRoZXIBELCA6vbfHfdPX3VPk+K7gkYtpeKdYfZcTS416CnsIEBL0udFydN75VskT4/
         ioRlVB0TkMOdMbnQFvFlJemit7zQhiACT+frig18NhY0wxaDxULesRoKQ9NY2CQBKUS3
         jcgq9+lkzm/WZQQtP8mGaCuOCrx77qVEMy9BcqsWgZ15OqcjkhAIbiXz0M8gpY8EIFOK
         fmLg==
X-Gm-Message-State: AOAM533WAAZNjg/GaRzsb+uStVlQY6HDgPStk241oqdbhILoPdLX67ux
        pnKMHjMliGfIdGvDmv30xT1dOg==
X-Google-Smtp-Source: ABdhPJyysufsZZCbU1g7sOlT62sjkNFODXgIPH+tINlFxiO0KOVS5s/AJ0HJthESGvOmoWsrPbnv3g==
X-Received: by 2002:a4a:d486:: with SMTP id o6mr11038405oos.49.1638501588648;
        Thu, 02 Dec 2021 19:19:48 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s9sm440136otg.42.2021.12.02.19.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:19:48 -0800 (PST)
Date:   Thu, 2 Dec 2021 21:19:43 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: phy: qcom,qmp: Add SM8450 UFS phy
 compatible
Message-ID: <YamMz3JYoyDh8O4B@yoga>
References: <20211201074456.3969849-1-vkoul@kernel.org>
 <20211201074456.3969849-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201074456.3969849-3-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 Dec 01:44 CST 2021, Vinod Koul wrote:

> Document the UFS phy compatible for QMP UFS phy found in SM8450 SoC.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 630ceaf915e2..c59bbca9a900 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -50,6 +50,7 @@ properties:
>        - qcom,sm8350-qmp-ufs-phy
>        - qcom,sm8350-qmp-usb3-phy
>        - qcom,sm8350-qmp-usb3-uni-phy
> +      - qcom,sm8450-qmp-ufs-phy
>        - qcom,sdx55-qmp-pcie-phy
>        - qcom,sdx55-qmp-usb3-uni-phy
>  
> -- 
> 2.31.1
> 
