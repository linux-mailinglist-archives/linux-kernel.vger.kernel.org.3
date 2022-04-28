Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51252512C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbiD1HUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiD1HUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:20:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4B972C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:17:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so7752033ejn.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kiotrhzY6mHRDt2MpfojkktIKuOsbK8By3NB4Q/GZSI=;
        b=MTygZWqPOgvj4zfnDEGO0Dl7fWH8SPW4x5jXZgawyoAHH7BipTSQQY9dE4FYfaarZw
         Mn/0qJ6JvHHoztgL07j/MuzBEOgoRQRoUfnP+TJEDVfjXbVVje567VawSzeielDgUPT8
         9BvzFjKc7rZA5+WDHfGFTbBJ91bLc8yhfYW/BK5N8xB7S977ZqVMYCkK5tLMAu4O3HBC
         hfs3GPgom/wSf0ifKf7AAf7AiZvg46+ctEfdCTwqQYHoNmrr7H5EZikutbWucDRS9Qy8
         B5TcvJwcwEOg353CPL9N2hHCyCdLe+lKulnu1B3f2FtHc9YCkhBdwnPXu5D0UlDA4gRI
         esjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kiotrhzY6mHRDt2MpfojkktIKuOsbK8By3NB4Q/GZSI=;
        b=OWRc9hUIEe7v4vc6PbeaGgXorYghoi0yfa1idLkIRZfonwlq7+mjowFJpUAvCYOBMs
         gfzSxiDxsbbmZFXFLqTCtJD/ZIIeSfjBoctfbGB6L//A+aUQKzsa0IJwgd0uncEvSSzI
         KNwxyYIba90Z3ea6HvZqDZj8+w6zlEk9BYCRpvI8PEF6sKLBnz6NKJOqodI9KGx9P4BQ
         4EJS8fMJ2DSX4eM2abwfU9OVdw+N5QU6u+GlVYQTKD0yUz4k9B7kLOelurposl3nIkDn
         yVVXvvcS05JIl6DWHIq8lUnRaFcz/wnHjCV48I5MfgP4VvItiKis8Gkrjj7v2SBdjRbP
         3kiQ==
X-Gm-Message-State: AOAM531wuxwa/MIA4rltVcU70oj8RzTHsCUXWse+JwcHc8p44csDAxuz
        z8it+LLrECWYkbRRqzPffuluJw==
X-Google-Smtp-Source: ABdhPJwOzGc2ZqYmxfXfW9M4vuhzdmo/G5xgkjnVOJMaWrYUEVGUceHPm8UXhOi6f0Tq7bUzMH83Jg==
X-Received: by 2002:a17:907:2d1e:b0:6f3:6717:5f38 with SMTP id gs30-20020a1709072d1e00b006f367175f38mr26762237ejc.732.1651130248876;
        Thu, 28 Apr 2022 00:17:28 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm8045716ejm.188.2022.04.28.00.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:17:28 -0700 (PDT)
Message-ID: <a37b61fa-f199-0330-d741-ef737635d987@linaro.org>
Date:   Thu, 28 Apr 2022 09:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 11/15] dt-bindings: arm: mediatek: Add #reset-cells
 property for MT8192/MT8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
 <20220427030950.23395-12-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427030950.23395-12-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 05:09, Rex-BC Chen wrote:
> We will use the infra_ao reset which is defined in mt8192-sys-clock
> and mt8195-sys-clock.
> The value of reset-cells is always equal to 1.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
