Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F876475F83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhLORjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhLORjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:39:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2046C061574;
        Wed, 15 Dec 2021 09:39:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id cf39so32456829lfb.8;
        Wed, 15 Dec 2021 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fzaqJ5meWUrCpUjSsb9uzssS9OJDirXSHWdElGY2Tk8=;
        b=gEfx0dDuompkfWezqonxci1CaIPqQ7Y3CLZG+hG/zvK4zZfLRLrKcdNKynoxHKzXhX
         /rCNZCbuAry32EF93PoFR/lyeZ/aUV2j+Jw15KyAWFVW0PV9AljhwxGH3nIR3mr/viMU
         4Aegix9rKmYqrfhcUDuKoa7ocakSvk6oEdpX/MJoQg4bBtbwA+ZgJi3f7QPEEKOAfvKS
         ZkvFuzpYmeFgyclxFDew7Pev166JpS3XBm8NN565a8sIpflhfxp1RHV7sZ7JG5Uah5P2
         paCBjwibHl7j0TbG9yRfxb+0vkQos8DXru/5DRljoP3UluwMemZ33SwBVHg8gGT+9IbD
         1ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fzaqJ5meWUrCpUjSsb9uzssS9OJDirXSHWdElGY2Tk8=;
        b=IaYRsGyERJkHEMK4iBHbpNcZqutc3tMvc5Y1/CGiKhJX0mAj0aAL6RkIf5ZzkJU8Hh
         +TaqVy4j6m9YJyzuh8xxGJnrXndfbvm9l1rLOwLycvRLu4444oMvhdpmvNSRazps8e0j
         SzckczHYlTwU9FA+sehwDCGfrzcDEcJC0yL5lYA/IWwAJhPmCxz/CTPoc7IHqeSoUAAa
         72+8WGWb6pTdutPhKp/G8Qe+GAVfkM6zkGbB682DBnfQOSOMHeS18DiHCyCaRoEMZvP8
         GBqM92lW0QwdcPeC6RcKx2bQPqGxo2UWqenShe1pv7pUo3BzqUf9gwynp56aT5C06csD
         0sDw==
X-Gm-Message-State: AOAM532OzM0dOhAZAGl4PQQ5xPeolV31as3GGPsRyyIEEcv1XzWoA5v/
        Tb2W6e/47hDX6wzOJfjQ65k8Q2CHOzc=
X-Google-Smtp-Source: ABdhPJwp/P+WVJvywsDi0ZdsqMyufBgQy00WZlSqIAI2FPQv8OrlYLAcE+uj3wSe0eM6UiFSKbeTiw==
X-Received: by 2002:a05:6512:3b9c:: with SMTP id g28mr11016231lfv.651.1639589957644;
        Wed, 15 Dec 2021 09:39:17 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id w6sm562147ljj.118.2021.12.15.09.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 09:39:17 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: display: bridge: document Toshiba TC358768
 cells and panel node
To:     David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     ~okias/devicetree@lists.sr.ht, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211215152712.72502-1-david@ixit.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4fbabde7-e3f2-fe6a-db3b-182ddbbdf73e@gmail.com>
Date:   Wed, 15 Dec 2021 20:39:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215152712.72502-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2021 18:27, David Heidelberg пишет:
> Properties #address-cells and #size-cells are valid.
> The bridge node can also contains panel node.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/display/bridge/toshiba,tc358768.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> index eacfe7165083..3186d9dffd98 100644
> --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> @@ -69,6 +69,16 @@ properties:
>        - port@0
>        - port@1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^panel@[0-3]$":
> +    $ref: ../panel/panel-common.yaml

The panel is always fixed to port 1, isn't it? Shouldn't it be just
port@1 here?
