Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC7481DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhL3PaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhL3PaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:30:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44731C061574;
        Thu, 30 Dec 2021 07:30:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j18so51114992wrd.2;
        Thu, 30 Dec 2021 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1jof+DZebMLPiQc0TwDMmSnKuPJVGago0B+tjBwIYlw=;
        b=OZYYKWmxJBwf2rALtePHVS5iVQMWA2WaSnbsSEYQnasSAZbu2SogzxPvsH7rP1Z7GT
         UGJMXslRLv9dnu1DEgFUCQhuZmfavkZDCl1cKazBsWGvsFZShnCxYJ7dnOzbJMR8uxuf
         ilazXWBQFquKFYhUFEHXTR81dmAM0AETc+A+50T6ahvzFWkbNZwC+OVb8h2kymGRWjNo
         PMvMiCvY4ovqjukVwQL72U4imxJ0i/QtiOXJ3uoNF8ie6gcfa8K6LgMYuekZKw7zRMRQ
         BNOCziQY+5xLAWR2kxNKwmKTtBZ29pk//hWTqgCe2NgR9ZONCO2YeZHvjfMaHKnpusG3
         bKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1jof+DZebMLPiQc0TwDMmSnKuPJVGago0B+tjBwIYlw=;
        b=Ds1708EBanEvnYUoe2gqDZZKLOD6lQIA4fatNI/y594vg3uIqNsBsVEYbFRfZH98Qg
         i0gzcIwHf2gl+oXq67wq7xBcM/3LrfNVoCrQtqdw02P3QE+1wIz7ERJUjokni9FjdFOV
         Pwz92gEibFTpORxA/nqvn7asb9RD1Mf4xdaUD4RBchYUvL8RmOIUSwbvHzLbdQIwXtjo
         FiNwvZ1grMYH1hZG7nkJUuVEcZsRCWpO2+45ftLU9i9KrABQCtjJ8G13vzDK1qqc1kYz
         CUlY6obSx2YBd3DIbV+vcQmu5zl8ph1LHQZoMQm4S+WbnlJ+ifuXuSk4hiLi/vPzmv5K
         cLdg==
X-Gm-Message-State: AOAM530X3q43mbNBFk3DmH2GJhTmMXXsoh9YJQ2c/xPDhv3F0EtzSww/
        RhQLH9brzIlvA6816z9Xb0Y=
X-Google-Smtp-Source: ABdhPJx5+OCjcspjRbYTsb4M9GjVMlH0pAjXWZCbNoB4HSUcvc6rFly+j9tntV0aChPYTZHYQgTHLA==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr25558357wrm.173.1640878202749;
        Thu, 30 Dec 2021 07:30:02 -0800 (PST)
Received: from [192.168.1.145] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id d4sm23839556wrx.102.2021.12.30.07.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 07:30:02 -0800 (PST)
Message-ID: <98efb356-dc0d-fa7e-5579-7984f2bb3e84@gmail.com>
Date:   Thu, 30 Dec 2021 16:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v20 5/7] dt-bindings: soc: mediatek: add mt8192 svs
 dt-bindings
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20210721070904.15636-1-roger.lu@mediatek.com>
 <20210721070904.15636-6-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210721070904.15636-6-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please add a commit message.

Regards,
Matthias

On 21/07/2021 09:09, Roger Lu wrote:
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/soc/mediatek/mtk-svs.yaml         | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> index a855ced410f8..59342e627b67 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> @@ -22,6 +22,7 @@ properties:
>     compatible:
>       enum:
>         - mediatek,mt8183-svs
> +      - mediatek,mt8192-svs
>   
>     reg:
>       maxItems: 1
> @@ -51,6 +52,13 @@ properties:
>         - const: svs-calibration-data
>         - const: t-calibration-data
>   
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: svs_rst
> +
>   required:
>     - compatible
>     - reg
> 
