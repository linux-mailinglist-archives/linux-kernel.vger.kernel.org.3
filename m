Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4783949C28D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiAZENf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiAZENa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:13:30 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E75C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:13:29 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id w133so8430462oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=arlsOb01jlapXGYkUDdz2+HVDdsCdZVHayoQG3dctsA=;
        b=aRw558Bs+cD7R+EE0gKoDAtx5fJCW/0eUBB3Eb9xqOjGKCurtCz8BNg019D4D2LQEE
         64sMWUQoYJ2WxspIU/aTCLPh8JisbrmEtJxVDw5GihQR+VTJBuMrwj1Fa7JH08DPLjyj
         k7RUHgNYf1Uy14xWUQAWAJMbF3TRYtutPsP5L+8vUZBsGp6MRaHckNo7bResbmdUu2ab
         J/PVjvXQIRUxN8qrRrQm3AxcOvrL+lFhhfR3O3RYXJtbdvdrrAGwMNoFl1utu5X2mhxy
         hlIfMkMe2rAuRD2PZYhE4D4GFMmSEjZFOyn5uxe1vMk4ritPS5jLhGp31uowjG/DAem1
         hBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arlsOb01jlapXGYkUDdz2+HVDdsCdZVHayoQG3dctsA=;
        b=7Oik5cSdI0Za9V+a8FliMAgtpfMxs8JVtyAVUtGTK1OAyS9B8ihOsJMMBJiKCq1xXh
         Z9mFAOyWxIUWSjlqlCd8WFtOZhYgfk1acw4NK/NB27DyU5mIGC4rTaZ7cgMi11b1MKJa
         qYRo++Ny+b9xlK9r6a6YxCpiGnhfjmZffGtLyYc/6Q2q377yGIB6wBMB667BL4XNkjlI
         MycXt3F94E1/aA+Tvt/Mu19fF9Hi2w+FN93x0TF+spP9KBjNozNqWL1Vu68C6hXVV77t
         W/Tk6UOrtjPQufGTcMH6GVt/bbfDJQtoSLBJNTB4Us+OdNGbodkxuAtAEpIuD7BmuEN7
         cZnQ==
X-Gm-Message-State: AOAM5313l8cge4ro/hZ/aj4DkkdueuID/fGl0Nf1lS93sBD4tejvC4EU
        BvuH7ketU4jQftQH1xJoXruNLg==
X-Google-Smtp-Source: ABdhPJwIJPX03WhOM4Ospo3ClShjQf2IYkb6IpRHWm2I1wBOP49Jm24472UAfLlXwku/XJXVauXlrw==
X-Received: by 2002:a05:6808:f11:: with SMTP id m17mr2632520oiw.77.1643170409349;
        Tue, 25 Jan 2022 20:13:29 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id w62sm1254229oie.4.2022.01.25.20.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:13:28 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:13:27 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: document HP TouchPad
Message-ID: <YfDKZxciezuDXL54@builder.lan>
References: <cover.1643075547.git.benwolsieffer@gmail.com>
 <aa59002aeae45a95097300213fc34490aa8db250.1643075547.git.benwolsieffer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa59002aeae45a95097300213fc34490aa8db250.1643075547.git.benwolsieffer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 Jan 20:07 CST 2022, Ben Wolsieffer wrote:

> Add binding documentation for the HP TouchPad.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 370aab274cd1..f7418a8a49fc 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -119,6 +119,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,apq8060-dragonboard
> +              - qcom,apq8060-tenderloin
>                - qcom,msm8660-surf
>            - const: qcom,msm8660
>  
> -- 
> 2.34.1
> 
