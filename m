Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0C59C504
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiHVR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiHVR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:29:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EFA3CBE2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:29:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s1so13472900lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wY+75YmJF6F6iHSTUHNAJDV+N7PX1+5Hl6WRxPY2Co4=;
        b=Qk4olVB8xIDb10EgA54jPX/P/Qz8Qfd5ZPOIP6eHYJ8mMMiosL1SnTkZkjWYP/9ZIJ
         MzViCBXQnLKWsZq0B2Tdr+9IqUpzAHfAu2miVGL3P3pXvpxeAa8RENu7VjZ+s4GYBQEs
         +YDWLFTAdyBotMOlspmwa6FDCAb8kenPU0WDS5v8yozswPr2YX5klbb+dAuXDjuKhOAX
         NKd5grHVF4UaytXHMuYnYkXAQ8ZqpbMWSDA2PBCWg7mF9nBJqXL5hPSHmlSiPX2Gxgil
         ABmmT8RjtLpjDBcS5Dd6qnsvOW8D+M0x+BL/WE3QpeKi+kQDSbQhbC19Oo1qBupCJRPz
         TndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wY+75YmJF6F6iHSTUHNAJDV+N7PX1+5Hl6WRxPY2Co4=;
        b=VxEZEaQiB91AFzqbw04mQeJD+IuzFhW1XAW/MbXI4zTJzNTDEVyjjVKfEy+4rwByZV
         eCk930Z5F0Htmko6FwWXB+XMTR2vDfD/9i1TX5n9Ken28l0RROZJmqsJEi6BJE3+9ppx
         MMKWwKRSVD+hadMe4kQ1mExJDkdJjpCAKTdUeISou2k3fwiPQU0ppaTJZ4RQFW6kLtDe
         QOL3P0cLXJDJ3DlR6FiBeOpM5p958ReydUai/swLLDL1jc/wISz87LjLIPT2kJvN7dq4
         FFj1T0L6+fynOnmU/pBkycFj9g8PBHivQkrsF0ogcWju2veeveOsLMKFgApcSteGI7mh
         lF+g==
X-Gm-Message-State: ACgBeo08oFAd3JgTtAX0WqhUK5as3cby1w2j2e9INPfZV0W2xqVw+Kzj
        yjy4B8uJsYCy7XGE3vXzKeBC5w==
X-Google-Smtp-Source: AA6agR6+/WgJeFE32Q4SCQCRljiwY1ET62J6fHGTG4QgqjBOsMf+vYQvQjMAbaLH24s9T3+dpWet2Q==
X-Received: by 2002:a05:6512:2c8a:b0:48a:f7e9:973f with SMTP id dw10-20020a0565122c8a00b0048af7e9973fmr7197041lfb.5.1661189347595;
        Mon, 22 Aug 2022 10:29:07 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id s13-20020a056512202d00b00492dbf809e8sm378312lfs.118.2022.08.22.10.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:29:06 -0700 (PDT)
Message-ID: <0de7f878-1471-4916-9384-9d966e840d74@linaro.org>
Date:   Mon, 22 Aug 2022 20:29:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: mediatek: add bindings for
 MT8365 SoC
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
References: <20220822152652.3499972-1-msp@baylibre.com>
 <20220822152652.3499972-2-msp@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822152652.3499972-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2022 18:26, Markus Schneider-Pargmann wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add the clock bindings for the MediaTek MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hm, when did I review it?

> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> 
> Notes:
>     Changes in v4:
>     - Remove unnecessary quotes from $id and $schema
>     - Add myself as maintainer
>     - Dual-licensed mediatek,mt8365-clk.h


Best regards,
Krzysztof
