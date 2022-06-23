Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB995579F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiFWMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiFWMFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:05:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4584B40E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:05:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sb34so11535205ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PppxL2KUqFlV+/8Q6Av1eKZ6SPqrPZYPPPP8wnWzrpI=;
        b=qDAFx0FRaVkJCKKl6seZsibKMWsEzBDitPBMd/GIuG1a72QpBhz66kEQ6gMOwhuDJQ
         EN3cTlJljisc+k6oA5802OBA5maMZQ+2ohdH++0RW7+KS6V+++CmTTIjB45REHrGbanS
         YmRIQcLENNCJHioVVdSwrfb65soYBGDNvoOH8C5PopdroXuPOY6qJEgN37IbY7SVy71C
         AeTRyzZaFpev4v9SBXnWIpRrBrdhOWJhRyMFi0PIFOJa7TbLCTeZy8c/ZtmA+D9ELkgp
         hVfpxt8beJrkmrE8UfT68+GXPITtsYPiDTY73X1RDQT41dqbwIKyYDAPtJCLQlgIZZDk
         vKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PppxL2KUqFlV+/8Q6Av1eKZ6SPqrPZYPPPP8wnWzrpI=;
        b=pXg9FbPUel+NbTR/Itfj5uNBHb4IaUVhaaoMl2n6u5RLXReMpZYf4O6nBICgwXCSEl
         HdWADZbgi0GXKr9Kyq1rSLgpCn1yRQpl+y9ZHiEWXNI2i8MYygDaan+jNIVAoKIbycbV
         rk3ueB+uvI7OnknI0mVreywYebFgsd1DW090ntfIyNGowF8Pribyqi1qaeUZyiwhA7tC
         DkUMS6BFzfhQIWfzExX3m2aGUAMky+COXKEIksMjBMudpis9fmrFFW5SXiwYBEi+vwXr
         1kWtlcnguQmnCjsAKgFe4Ov2aNvYdmkMi/pT3jUKuMzypPvbJAy8kgXcw4NCyE2CK0GL
         Stww==
X-Gm-Message-State: AJIora9fIG6hMGkbuhYOhqH/YgH4pmRIfV5Tp916aQTdpKsg/rq6Su3X
        vzawZla6OMSq5w+FwxXcdy5g2A==
X-Google-Smtp-Source: AGRyM1vsUBr3PdB0hhAURyeHMPTDJEWaOUR4fFilhHFdevtuR+Szbs2SytIwDzsrjRR2URuwf5x2xw==
X-Received: by 2002:a17:906:6485:b0:712:10cd:e3b7 with SMTP id e5-20020a170906648500b0071210cde3b7mr7618453ejm.557.1655985919875;
        Thu, 23 Jun 2022 05:05:19 -0700 (PDT)
Received: from [192.168.0.230] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00711d5baae0esm10838324ejg.145.2022.06.23.05.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 05:05:19 -0700 (PDT)
Message-ID: <a2c5cdec-632e-3d90-c90d-1c3c0503e825@linaro.org>
Date:   Thu, 23 Jun 2022 14:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: r9a07g043-cpg: Add Renesas
 RZ/Five CPG Clock and Reset Definitions
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220622181723.13033-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622181723.13033-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 20:17, Lad Prabhakar wrote:
> Renesas RZ/Five SoC has almost the same clock structure compared to the
> Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.h header file and just
> amend the RZ/Five CPG clock and reset definitions.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/dt-bindings/clock/r9a07g043-cpg.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
