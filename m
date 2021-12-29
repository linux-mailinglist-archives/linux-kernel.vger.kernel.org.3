Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB848143B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbhL2OsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhL2OsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:48:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E8DC061574;
        Wed, 29 Dec 2021 06:48:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j18so44910729wrd.2;
        Wed, 29 Dec 2021 06:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OMlLUALYJKdFe/JZOoIbTwKW7ZzuyEQvczxSC+L2fy4=;
        b=gV5diQtKpyLmmu7MzK3MftjSDVmr/TNKs7RNreXjQ40dRcKDEhSERRqvVZS5aJpptu
         h3PZs7f/OILYzS23AA7Gnj7dcv0JxUvq9tYR76ymZHZveWRJ/yCYwPGoQGyReDQlqN5p
         2bbBOcLc+WooNqMT/AVLEeiw4wciVXqnVNx33k1pbHY313hpvYkdzN2xkdkvhS4YZV58
         feodJ/f2+iSdFhNQ+S5O+B1dbFVuOFOepzIoziV64fsujG75Ul4Hx3Z96uXxrnkmitcq
         VBWsMxPU893TcKYHdQ07KCR0IQi95uAP9OHFccCdLmNYTGelBoBm/K0q3JdclzCXPbW4
         Ov/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OMlLUALYJKdFe/JZOoIbTwKW7ZzuyEQvczxSC+L2fy4=;
        b=1mHqbyps5dwasvGLfypg/5rnTpVQzoNID3R0ySUkJSD6+6IxLwFF6A8tGHyjxC3wN9
         YxPByqUPebnJgIC5sFydkXcZ/MntOfCUs++QcQXPrcw7c/HOUbvY2OfknEsmivLEez0F
         Er7pku7GCGMaA81DnOrucXBUyrKXfnOV5ixE/zcIXwtlREXEkxX0NkeTwcJTubocgIxU
         pT5RAwsLOiDy43UCb0VrA/vgh65aF5gqUa38q2D27DKDtL/OnzpM2rVcaTcTlSxPj/RT
         ggtf/osATdn40OJ06k3LlixgHUSuefWfKPVry1Z9DxUQbFasu0N+x369hM9jhPGvj+lB
         SPKA==
X-Gm-Message-State: AOAM532K2uWBRHxueDTsG5aEMMg8gOzIqifa3QupFngQJqOFkFYYFLBa
        gLPr0jNHLDuWef0yCT3B49U=
X-Google-Smtp-Source: ABdhPJy+nTFpxhAiApnXGMcT2sANzUH6lS6azCYKQd7r4UcTWbghoRh8SdR196X/CImptF1IkNaZ2A==
X-Received: by 2002:adf:db04:: with SMTP id s4mr21643636wri.467.1640789295268;
        Wed, 29 Dec 2021 06:48:15 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id y11sm24767746wry.70.2021.12.29.06.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 06:48:14 -0800 (PST)
Message-ID: <a96ff42c-d8e0-3c26-633e-dad4db18a71a@gmail.com>
Date:   Wed, 29 Dec 2021 15:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 02/14] dt-bindings: arm: airoha: Add binding for EN7523
 SoC and EVB
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211220211854.89452-1-nbd@nbd.name>
 <20211220211854.89452-3-nbd@nbd.name>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211220211854.89452-3-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2021 22:18, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add devicetree binding for Airoha EN7523 SoC and evaluation board.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Now part of v5.17-tmp/dts32

Thanks.

> ---
>   .../devicetree/bindings/arm/airoha.yaml       | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/airoha.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/airoha.yaml b/Documentation/devicetree/bindings/arm/airoha.yaml
> new file mode 100644
> index 000000000000..fc19b1a6f37b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/airoha.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/airoha.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha SoC based Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Felix Fietkau <nbd@nbd.name>
> +  - John Crispin <john@phrozen.org>
> +
> +description:
> +  Boards with an Airoha SoC shall have the following properties.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - airoha,en7523-evb
> +          - const: airoha,en7523
> +
> +additionalProperties: true
> +
> +...
> 
