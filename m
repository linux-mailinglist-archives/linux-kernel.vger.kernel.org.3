Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5809157F177
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiGWUpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiGWUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:45:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52EE24B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:45:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b34so3813242ljr.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oWRtJFxeA8rQDYY14YhCd5s+fzvSzxieLEOwpQYrDOY=;
        b=fio+cSlxqlU8b4zxSMPl69tT4+qBrjVt1IhI5WOq1pt5+fb4k/HPX+uZ+hNkwuogZD
         +7qjZZ5wUKGY7QrFzwrFinlnhDhpYBNXvqZXn1SvvwdzUX5842HbV7EqO+Ppe6WWOQoX
         q03i8Q+fpi2+aPn2FenX3sorhZ5PF6N+IShUdaadDSRcGLhQz6odsZxBKkXcowC2qn3C
         DmKnEJqmNOJ6wsNpq/e5IAm0FUm8k6rVRwUebF5ng4D9C68H7IHrZQ4v6N0iD1rup7YS
         LIYCRFAW3zp2DTzsLyIhtwR3Y7+bY9ihdCnRHfmBC9vofacAt3sXebVHrKmRZTNCFHF5
         gG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oWRtJFxeA8rQDYY14YhCd5s+fzvSzxieLEOwpQYrDOY=;
        b=cWzng+vnA9fiwhXZl15InbsSV0hwA7Ah0VPvRpmBfquAJvI4c8acq7ZV4G1kMkorx9
         3saLBV9D2wC2RGNFPAHdRXF0zjH922nLOO5Gd52TVcPoCbdThFJsNjDcLEYm92KujO+0
         /71YvNkCu3H0Z63gNSoORPsqpWvp9Nv2sJDoeX2bk6cUW1TMw48fbwXq5QECgvhhASh0
         4oNuBPej3aogRJPh2Nytg77Rs9Li4IweTCc4G4I9WdvH6Asjsvvvjo2uxOz8uz9euMvA
         VW6dy6d58vABgTYKPP3UjsVxUcReB52K+Hg9UEnPGVlVQugzEKWwF8009OQC2dtug8Zk
         NMZg==
X-Gm-Message-State: AJIora9O6bCTyc6spb+MlAtwdqEVSK9FIfNj8oVEWJU+g0Y2Q05YEU5L
        LWZAPnWbKUQl9s6Fu8dPCRc2wQ==
X-Google-Smtp-Source: AGRyM1uipIB/g5ypN9oJ8cz6WSCgqhgQXxZWjhFogYY7VhE2R3ktdWk95KYkwjnbKTvzLRKm1Uw3QA==
X-Received: by 2002:a2e:a596:0:b0:25d:687f:d9ed with SMTP id m22-20020a2ea596000000b0025d687fd9edmr1861436ljp.424.1658609103841;
        Sat, 23 Jul 2022 13:45:03 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id u23-20020a05651c141700b0025a672e97a6sm1836173lje.80.2022.07.23.13.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 13:45:03 -0700 (PDT)
Message-ID: <8d656940-567f-d8ea-8cb1-4ca37dde3e0c@linaro.org>
Date:   Sat, 23 Jul 2022 22:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/8] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220722090609.52364-1-angelogioacchino.delregno@collabora.com>
 <20220722090609.52364-5-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722090609.52364-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 11:06, AngeloGioacchino Del Regno wrote:
> Add the bindings for the clock drivers of the MediaTek Helio X10
> MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++++
>  .../clock/mediatek,mt6795-sys-clock.yaml      | 54 +++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml

You already got a review tag, didn't you? In v5?


Best regards,
Krzysztof
