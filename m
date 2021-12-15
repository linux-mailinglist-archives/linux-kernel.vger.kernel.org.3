Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F54947617D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344169AbhLOTR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:17:57 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46933 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbhLOTR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:17:56 -0500
Received: by mail-oi1-f180.google.com with SMTP id s139so32962517oie.13;
        Wed, 15 Dec 2021 11:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uBHq/0zl+a7Dq09M9cM13oZAbttHfH1OlcttpqMjJvw=;
        b=eDRLTyZmGuZnAKQ/p7xdfsn21UTpCLGoedjee7E5kgaofXy+A5R9okJjk+BTFi+HWS
         D03hsAVLDvSadzNtFZhg0wwu+VVp8naNbdTesGif6LcjJfRR4VLR2AvP4TMiCcFozqOx
         bvsmCbwst8LYLoCBUxzu/98QpYMHbq8zOPZeAzGdSTnZjNJri6qkGb8XuZhVI6vCFxip
         l12dAri6ahkyMcbGnk+hQueVX3ba1C7iFlEDIuy8gVAIix6BlB6l4ja4sNCSdREIlDmR
         P9oDwT5pBmVtLpbotHyUMvKAroZqc4hprQFfZPq6GM+YzVLW/Cp17YT+8CFrjNTpTne/
         O7Zg==
X-Gm-Message-State: AOAM530GGwsFTOba9owUcpH3pUjI6YyWcLvfKocDNUeDXe0V0OtJY7i4
        kmBvHDQoBSxdpwGrySgO5g==
X-Google-Smtp-Source: ABdhPJxVqQc4gHQs3V0KRcAfBJ6UgCVyfX1bVdv+jBG/NvRIrgHJRE/jZ23/FU/ZDThRckGwUM3s1g==
X-Received: by 2002:a05:6808:118b:: with SMTP id j11mr1194276oil.73.1639595875844;
        Wed, 15 Dec 2021 11:17:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y28sm506876oix.57.2021.12.15.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:17:55 -0800 (PST)
Received: (nullmailer pid 1675653 invoked by uid 1000);
        Wed, 15 Dec 2021 19:17:54 -0000
Date:   Wed, 15 Dec 2021 13:17:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add bindings for new Ingenic
 SoCs.
Message-ID: <Ybo/Ygixmmn9FPkx@robh.at.kernel.org>
References: <1639068516-5577-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1639068516-5577-2-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1639068516-5577-2-git-send-email-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 12:48:34AM +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the OST bindings for the X1600 SoC, the X1830 SoC,
> the X2000 SoC and the X2500 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> index 98648bf..a3b1429 100644
> --- a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> +++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> @@ -20,7 +20,12 @@ properties:
>    compatible:
>      enum:
>        - ingenic,x1000-ost
> -      - ingenic,x2000-ost

Removing this is not a compatible change.

> +      - ingenic,x1600-ost
> +      - ingenic,x1830-ost
> +      - ingenic,x2000-ost64
> +      - ingenic,x2000-ost32
> +      - ingenic,x2500-ost64
> +      - ingenic,x2500-ost32
>  
>    reg:
>      maxItems: 1
> -- 
> 2.7.4
> 
> 
