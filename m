Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7176476D13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhLPJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhLPJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:12:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2A4C06173E;
        Thu, 16 Dec 2021 01:12:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so42887306wrr.8;
        Thu, 16 Dec 2021 01:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x4k1zI3iK8DOJhhJ2DmMVfZXMtCAnERs0JGKLaP5zks=;
        b=g7B5mwruW7SaPK3YRN0vN1C4bg9zqB9Ywk1YaN1ZHC+C4M2xe5bcvX2h8HaZaIZhBp
         LGEjbMupndL+W7AnOtC1K0bnqTtZ38dkmRj5vaDJFyXIReAGosUh9/t5aTkWy+6PW8ep
         cQeJy5kTpMdVr2MsYex0AyAE3xFP+iB5oKMD7o8PmA/aL1IDyW1QbOJ5pqNYJgSJm8av
         t0DrQTB/p9rAC9X1jshQ/krBxgAuM2oI//I7Qui5F/KmTWU2cVWKil0zoXLZOBvudhda
         CzlVPhoiA6s0+R8K1GX4Jql16UYlDvKvo/RXW6kLGiJiN335cO1bEKcPSVItYxLx5cxO
         W0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4k1zI3iK8DOJhhJ2DmMVfZXMtCAnERs0JGKLaP5zks=;
        b=SabAZiJ3XhqXwPJZEaBZroLcjmZk4h/3b50LD57PabgP2MOPw7y2fU+Qzfy0xEG9x5
         wEsiwwFlQQnUnMw5vjviUw7Q8sE1/UEOu8YwBW1zBH2xRVvZeb6IWKnIa5XAcFCvOi4H
         esgzpnW/DQy4ol6hry/2MaD/bA5lYD1bQcRO6Y0SL3uGCznjAW6X6GgSgI16dQt0a6Ud
         91GlRyxmSyxuS6znOp/plX+XoFuFil59U0/QFRqNIKlC7dl2+r2depSbkPTggMhCIGdr
         GhXYmrNeNXD4YjpWBJCHPRK3S8R5hDf5sPvZi+53Mw4JV0kQu9FsBi9CjdZNLAPxduc6
         AMzQ==
X-Gm-Message-State: AOAM531hHVSZXOGM93uRzrlZELKvra0BG8TDPnQPSHy67ajXsJywVpho
        SkF+GmMCyuu0W+pWvVCnRC8=
X-Google-Smtp-Source: ABdhPJyJAX5eTdhQft6rbyMCvlaLfw/tuoiMzMaSKhEPruM32RpV2ndbiE23NWpVs+J19vPeJ/k2+A==
X-Received: by 2002:adf:c146:: with SMTP id w6mr8274090wre.541.1639645950098;
        Thu, 16 Dec 2021 01:12:30 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id l6sm4444640wmg.3.2021.12.16.01.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 01:12:29 -0800 (PST)
Message-ID: <5c9d87cd-2d11-6272-ee40-e0c3aad15e1e@gmail.com>
Date:   Wed, 15 Dec 2021 20:31:21 +0100
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
