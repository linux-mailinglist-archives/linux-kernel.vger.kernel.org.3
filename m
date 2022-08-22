Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF159C50A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiHVRbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiHVRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:31:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F7A3ED68
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:31:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v10so11271116ljh.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=UIBQLdznziJppE7OJpXEV1+Wn96b8SDqR1x+484CyS0=;
        b=UslXPosZJEVEMBCrm+Bq270dy0ernwsV/tH5hBf9F+jDyKMTpzjX3vU/ntechaMWyC
         f2V3lmnsowQFtbJYqlZmhLSahLY7uz2a0pPFVDC2HmynRQ2B7G+ATb+r4N3n88ZP7G2R
         EeHBM+SvXIFsu1/YOUyWD5KpYo4Rlcpj4PAZ4d5x2eM4zfJL7NglVUKbHZCJFzwcRNMc
         F3O6sb/JJlHq1MPi3jxXDKS76D9EeT1dg3mp6StAa4jljGjpf03dN2k3bA1CmpOa+ZXl
         U9FhuBipFIKX/9HTcg491Edkwuujswxqn6C6ZREzh8u5+4ISq8Np0HuqW7p635Z6ptw/
         Lceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UIBQLdznziJppE7OJpXEV1+Wn96b8SDqR1x+484CyS0=;
        b=h4EN+KgpyjAi25pido/S8Lvq8GaI2Htg4+6c+HFqkgh8QUKdBpLEB3C9jNuUmUTEcB
         sXhPV3b56FpR6zskxfli0GZqqZjlx8RzL9bk2ao+1MDaj3WIbyDuaSEgrLNcTRbPg9YO
         c51i8M2ovKq+SCmrlradTNBqWaj1ZHrQIV9d977M9SxrMGEvoqtlm558wvOamqUQDdms
         PjZNUbirD2kWB59JoZZvQUVpWjcQTWva0B5DJSORvooVOn0xuCdPmejchGFHOVXfKgTq
         oDGrl5+iPAM4XpJt1ihAI1PoB8NOwXIUBFYwbEJ03qN6+PWmmvWod4pIdRpyLBH4l/QW
         7YGA==
X-Gm-Message-State: ACgBeo35ZadWk7rYfpPzR3IM/sZ6A6RXAzrsVzW0htlz5R5/eTSeamta
        9GOseDIcUWAAiZUm1sALhYJC6w==
X-Google-Smtp-Source: AA6agR6VFNpgt+MgZFrbKH8HTyfO7Yf/rgWPBwBmR3CL0NGx4uLKRhwHLYhAMoTx3/06p4INGZihLw==
X-Received: by 2002:a2e:9604:0:b0:25e:4ed7:ef45 with SMTP id v4-20020a2e9604000000b0025e4ed7ef45mr5835729ljh.389.1661189473507;
        Mon, 22 Aug 2022 10:31:13 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id t10-20020a056512208a00b0048aeff37812sm2010642lfr.308.2022.08.22.10.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:31:12 -0700 (PDT)
Message-ID: <3815ce73-b021-4643-6bbb-ad0d35178b94@linaro.org>
Date:   Mon, 22 Aug 2022 20:31:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: mediatek: add bindings for
 MT8365 SoC
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <0de7f878-1471-4916-9384-9d966e840d74@linaro.org>
In-Reply-To: <0de7f878-1471-4916-9384-9d966e840d74@linaro.org>
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

On 22/08/2022 20:29, Krzysztof Kozlowski wrote:
> On 22/08/2022 18:26, Markus Schneider-Pargmann wrote:
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> Add the clock bindings for the MediaTek MT8365 SoC.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hm, when did I review it?

Ah, I reviewed v2 and still had comments in v3.

I see these fixed, so everything looks fine!

Best regards,
Krzysztof
