Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF96484993
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiADU5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:57:11 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44576 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiADU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:57:08 -0500
Received: by mail-ot1-f53.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so48224403oti.11;
        Tue, 04 Jan 2022 12:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRYU4aIcva6h5WbfW8xNSgFIrN0Ph4p5QkPfsjm9xvA=;
        b=MUbovyPZQJwPBU3+2xKIHRsUP3KCptn1WHfnBLSTwm+r4yEiSoBoD7mbJEBOUJJEsE
         cxMPxK1ubX+olyawF4L5qP4Q5IAUYoQKfa5oCBgoktm8O02Jm49tr2pf9duTOvv5qCPX
         vUFgv86XYcJ8kpDqxz4oHBBMskAC3k08Ejo8PYvfBAq90G5LygsqvU7lea0o7NMvjN5D
         h5D4U03g8R2w62O+hLaT7Ke/01RoxtmC8XG82ih/T2bhRhSYJqbRf+3AYcC1TVtDOaEM
         upEBRBooRp/gGGTVjQ6mN9MZpliO9hGDyS3fGwg5LBQ5DFNB6R74SQGamatSQkv46cpV
         YB5g==
X-Gm-Message-State: AOAM533vE+YOiM3eUn7rxVjbEz5xbzJTfaO9QvsWLBO9b6rG90gODhFf
        NEoXE16PEB0Lp/p/LWCzW2W41Bg6Bw==
X-Google-Smtp-Source: ABdhPJz5Xwg08PEhisrWtvDhosclwXKyEYwpjIQuXlqEpdpjRW4DzbRYezlGdOgylO8/BFi+FFsoOA==
X-Received: by 2002:a9d:a01:: with SMTP id 1mr36925034otg.302.1641329827418;
        Tue, 04 Jan 2022 12:57:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f59sm8285612otf.9.2022.01.04.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:57:06 -0800 (PST)
Received: (nullmailer pid 1412121 invoked by uid 1000);
        Tue, 04 Jan 2022 20:57:06 -0000
Date:   Tue, 4 Jan 2022 14:57:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Stephen Boyd <sboyd@kernel.org>, ~okias/devicetree@lists.sr.ht,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spmi: spmi can have at least up to 5
 registers
Message-ID: <YdS0oijFShdG40WI@robh.at.kernel.org>
References: <20211224163344.54177-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224163344.54177-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 05:33:43PM +0100, David Heidelberg wrote:
> Since Qualcomm SPMI Controller (PMIC Arbiter) can have 5,
> bump reg up to maxItems 5.

Already has a fix in linux-next.

> 
> Fixes warning as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: spmi@c440000: reg: [[0, 205783040, 0, 4352], [0, 207618048, 0, 33554432], [0, 241172480, 0, 1048576], [0, 242221056, 0, 655360], [0, 205561856, 0, 155648]] is too long
>         From schema: Documentation/devicetree/bindings/spmi/spmi.yaml
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/spmi/spmi.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spmi/spmi.yaml b/Documentation/devicetree/bindings/spmi/spmi.yaml
> index 1d243faef2f8..d7d9345d7c60 100644
> --- a/Documentation/devicetree/bindings/spmi/spmi.yaml
> +++ b/Documentation/devicetree/bindings/spmi/spmi.yaml
> @@ -25,7 +25,8 @@ properties:
>      pattern: "^spmi@.*"
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
>  
>    "#address-cells":
>      const: 2
> -- 
> 2.34.1
> 
> 
