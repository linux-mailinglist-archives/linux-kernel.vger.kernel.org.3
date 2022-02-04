Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FAF4AA067
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiBDTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiBDTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:48:46 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D3CC061714;
        Fri,  4 Feb 2022 11:48:45 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z7so9948714ljj.4;
        Fri, 04 Feb 2022 11:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=duHpmFxlBbFk1XIYiQ3pxMiqpbVYnao3doZJUxGlgw0=;
        b=iW/MKdWog0NT3R/KNWxkTEvpMxLjViZJy4lj2FmGfRo4aUpWuJwFHxvTYUx77KylaI
         VlNaZ3GGHUn8lcI0l+P1gS92Iz9PfqFB/XQfx1MO9T9diAo7y4dKt6sBeJnfP4yWBzlZ
         6mC/CSLc0en48qVt5P+NQYJm5i0Pw3wVQJcGUsBjpqmfyE9b6Rn4sS7h42ci4xQNThwn
         sSjXutk/Ot1/WltbS8umyy/utVAmVVbbWuV1eiLn89fsqfimKj5erfNDz8RY4554fKXD
         vPyaSlr6qDglUw2hFh9dZLOFko28pzQr1VWo2SoLLogUq4lnT04vC9Ip/KSsyjXGWd8g
         nFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=duHpmFxlBbFk1XIYiQ3pxMiqpbVYnao3doZJUxGlgw0=;
        b=U9WSdUVIatvmZ5VzwuFjKztmFoeJpNnkj2WM0fHKQZ5e46PYZSz0c8UNcvyBkLPQ+0
         IOnZoGAEe9GvzBJFvofH9HYdHegJVQVQN7c5jJkV1s2BegxclyyjdLKjHLJSXedz2U03
         daMc/18Z2YmBUze+pKJoZZQiKB/X3RbyX/qqY/cUu4hh05naJz+ds9U09YE3whMD25+4
         V1K7hFH/ctxYRB3S3XAZXcd7wctoYCpkMZeZ98lLV3FyF7MvR3U1n5Xyh+i2VjvT7+yv
         IbLZbShEGv1H70E7dMSYQPOnL7aWTUWqjjoRKI7fbb0vF2mfriPS4Ay/l970vg9GT/6A
         YhGg==
X-Gm-Message-State: AOAM53363vaxp4iJygh2DdjATM5MCVmtd07Q/CCNVGUwaWhSjJIQqLud
        E/2TuXfI+yHoB9WryOuXOeg=
X-Google-Smtp-Source: ABdhPJwPWlZyp8vfQtVc5hmYtdbn1UjQfKbidce8/vheQguoDAKZYgg7P0sLNkT7rtJfzl1flMjFyQ==
X-Received: by 2002:a2e:3218:: with SMTP id y24mr281398ljy.260.1644004124302;
        Fri, 04 Feb 2022 11:48:44 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id j23sm435661lfh.35.2022.02.04.11.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 11:48:43 -0800 (PST)
Message-ID: <23d38615-6b75-8715-0f83-fc93755a708b@gmail.com>
Date:   Fri, 4 Feb 2022 22:48:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/6] dt-bindings: memory: lpddr2-timings: convert to
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
 <20220201114749.88500-6-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220201114749.88500-6-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2022 14:47, Krzysztof Kozlowski пишет:
> +  tZQCL:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SELF REFRESH exit to next valid command delay in pico seconds.
> +
> +  tZQCS:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SELF REFRESH exit to next valid command delay in pico seconds.
> +
> +  tZQinit:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SELF REFRESH exit to next valid command delay in pico seconds.

Hm.. these look incorrect.

tZQCL is Long Calibration Time

tZQCS is Short Calibration Time

tZQinit is Initialization Calibration Time

No?
