Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25D4761C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhLOTbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhLOTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:31:50 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2515FC061574;
        Wed, 15 Dec 2021 11:31:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso37207wmc.4;
        Wed, 15 Dec 2021 11:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x4k1zI3iK8DOJhhJ2DmMVfZXMtCAnERs0JGKLaP5zks=;
        b=NJgMzS5JVDp+TUVCMkznQf01HxZ3GyB9IF4TXBY0oWuHJcbxZHXfchrvt9vi4glgEh
         bg1kyJk7KSht6UVTTLmMWJf2Nb333+aUlD9CsAE3NNehWMqA8FdI/dgM89olrlK5HbTf
         bjdvKjcLfCZPhTF0MvqqckYJfqnbj1M/7eNeyZ31W5c2Wt4TlNV+44jCc66BCbK2/b/s
         gqmtHJjMJHSp8AFlMQyTjhmjKFn84n2GsW0u4dnDrwllWYrbAGVID6Ld4m6MNtfEVjQQ
         A28QyFVm6rZGo/7uSlsa3+ctDkrWpvNgDM43NWY8kblLGRfn49siHORt+xhASsma5vmt
         Jq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4k1zI3iK8DOJhhJ2DmMVfZXMtCAnERs0JGKLaP5zks=;
        b=GEawsUkU1m9/37PQinJoR6GreLrDVxhGAL/O/AfJIyefMog30d2Ng0HuiU+bs3qr3W
         5J7SfJ4hRVMxymrXlHzwBp47RWA+YVx+ZNpya5kPMveFboIuHWgK8VOAcWvMbb12Vm8t
         IVUmoJpJ4Yo2mJRmGoutPh7Tu8bITlydD071++RSCWlUTK5bE+cdfy2zolawqKh92gZr
         UcGYjnUHW4fYA6Hdkl1UByktPymczd7IwxtCVp+79lDCppngwnGhwqFEU2Q70QAfeaMh
         dkKaS79Nre2uNfC/Ja815uCbxbQFjPJwCGMw6NecHmYmFA34Ep5TN3CAhcybqg6e1OLx
         I3Mg==
X-Gm-Message-State: AOAM5303mrTuNoVj+d3wQfwxat7PF9OY84sHNX5a2wEd51fkwpW7w9G7
        5BE9QLrEdTdfxwTU17QpZ8Y=
X-Google-Smtp-Source: ABdhPJztwiKwqGSqUj73cTpvfQYIax4z+WK20VP03cDOKPhcbs9acfRIZLYOMNnC3TC6Sn+0jJvD1g==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr1649282wmj.37.1639596708645;
        Wed, 15 Dec 2021 11:31:48 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id f18sm2729458wre.7.2021.12.15.11.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 11:31:48 -0800 (PST)
Message-ID: <f8abf09f-36ec-b8b6-f3f3-de06f05c4021@gmail.com>
Date:   Wed, 15 Dec 2021 20:31:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 1/2] dt-bindings: arm64: dts: mediatek: Add mt7986
 series
Content-Language: en-US
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     John Crispin <john@phrozen.org>, Ryder Lee <Ryder.Lee@mediatek.com>
References: <20211122123222.8016-1-sam.shih@mediatek.com>
 <20211122123222.8016-2-sam.shih@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211122123222.8016-2-sam.shih@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2021 13:32, Sam Shih wrote:
> MT7986 series is Mediatek's new 4-core SoC, which is mainly
> for wifi-router application. The difference between mt7986a and mt7986b
> is that some pins do not exist on mt7986b.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> 

Applied to v5.16-next/dts64

> ---
> v6: separate basic part into a single patch series
> 
> Original thread:
> https://lore.kernel.org/all/315d7823aa108c909a3d36464fe54763b76ab2f4.camel@mediatek.com/
> 
> v3: changed 'MT7986' to 'MT7986 series' in the commit message
> v2: added an Acked-by tag
> ---
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 80a05f6fee85..a9a778269684 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -76,6 +76,14 @@ properties:
>             - enum:
>                 - mediatek,mt7629-rfb
>             - const: mediatek,mt7629
> +      - items:
> +          - enum:
> +              - mediatek,mt7986a-rfb
> +          - const: mediatek,mt7986a
> +      - items:
> +          - enum:
> +              - mediatek,mt7986b-rfb
> +          - const: mediatek,mt7986b
>         - items:
>             - enum:
>                 - mediatek,mt8127-moose
> 
