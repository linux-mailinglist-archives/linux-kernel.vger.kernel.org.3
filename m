Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DEB49546C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377350AbiATSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376673AbiATSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:51:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9B3C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:51:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a7so5926029plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=aAElqll6HcGOKdu1l+4BDFs74fKBxBPJQ/1HSNtgISI=;
        b=3brA5+YFUK34MXcTtFKlB0aLLKO/YP/rq83VzW1SYf97Ri8DZxIuLQ4zJJxwQBLzpJ
         NW2oj/gcvtvpHEohXKo2pPEI+iFeXuhv46Kcdz/axsh6dtmzisEW9Gt67C2H3i7+Ux84
         52FatSauhcQOgh/AX8D67demVSYOQ73JyUaFzaVqqAVZIV0ZZG+IzN8GxxR1xg1oRZ0z
         Spm5+2c37GczUWkqlbNAKiU3S0wBzSmTDiZuWTrrAkEtBc1+WS8AxWA0uVozybduJYVQ
         QZsFbHfOtUoY7ClI0w0j2vIUJgVdj3rfifazeMMLqypQd9pozZIezwatL6C3oSNPATj7
         jT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=aAElqll6HcGOKdu1l+4BDFs74fKBxBPJQ/1HSNtgISI=;
        b=UlH8ZEnq9h3Hy64qLlQtEm4FkSzXDWJBj4dYMEwvhyHcmBDcLugCBOZtZi4CW4dhaW
         LSoiG1ce4mmBu/S4gvYUznfqmZ/Rk4xK/0AeE6kSp5d/tvbvkJfAsoIt2TR9IyaKr+Jg
         8h0NoR+Rw5HQew9ak+LLqB+B9n8X/y7MV5LEG8jCKZqZBdJCO80sSCm5jq4mSpub8tXj
         s5JPsSFN2si7wFc86zDhXpD8ruHE2POkW9o7iNpY5J655XjVQFkcucnGWLrocVX6Rn2W
         DEnCe+orbUrGWOfDkUvhw3x9OlMGph1BoJDZzSj6xlOHHaHJmh3Xo/S38871ye25TOfS
         LAcA==
X-Gm-Message-State: AOAM532n4+iznG2YKxt3X+XQ70owM+SL1UKQeADGYvD+imoPWATADzXV
        7i1mUk2m38gLqpi4iMQLJY2d6g==
X-Google-Smtp-Source: ABdhPJx0HnJkGKqfD4Kv3vqyguY0PXPBkZwjEjaFA0kzfYMCst7atFsorC+k0j7udcuzCzvQAS+25g==
X-Received: by 2002:a17:90b:4c89:: with SMTP id my9mr416443pjb.74.1642704716407;
        Thu, 20 Jan 2022 10:51:56 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id x25sm3816569pfu.205.2022.01.20.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:51:55 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:51:55 -0800 (PST)
X-Google-Original-Date: Thu, 20 Jan 2022 10:45:50 PST (-0800)
Subject:     Re: [PATCH v4 2/3] dt-bindings: Add dma-channels for pdma device node
In-Reply-To: <5db314b798cd9cfcb5cb61bc56515220b7d50315.1642383007.git.zong.li@sifive.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-e5e649a2-96bf-4244-a29a-a75c913111a2@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2022 17:35:27 PST (-0800), zong.li@sifive.com wrote:
> Add dma-channels property, then we can determine how many channels there
> by device tree, rather than statically defines it in PDMA driver

Maybe "statically defining it" is better here?

>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> index d32a71b975fe..3dbb8caefc17 100644
> --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -34,6 +34,12 @@ properties:
>      minItems: 1
>      maxItems: 8
>
> +  dma-channels:
> +    description: For backwards-compatible, the default value is 4

Maybe "backwards-compatibility" is better here?

> +    minimum: 1
> +    maximum: 4
> +    default: 4
> +
>    '#dma-cells':
>      const: 1
>
> @@ -50,6 +56,7 @@ examples:
>      dma@3000000 {
>        compatible = "sifive,fu540-c000-pdma";

IMO we should have a "sifive,pdma-1.0.0" (or whatever the versioning 
scheme ended up being) here, in addition to the SOC-specific DT entry.  
It's kind of odd to start extending the SOC-specific DT entry, as the 
whole idea there is to let us have an out in case we find future 
compatibility issues.

>        reg = <0x3000000 0x8000>;
> +      dma-channels = <4>;
>        interrupts = <23 24 25 26 27 28 29 30>;
>        #dma-cells = <1>;
>      };
