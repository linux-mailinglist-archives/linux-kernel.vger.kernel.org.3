Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988DE55CB43
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiF0JAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiF0JAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:00:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71936394
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:59:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eo8so12044682edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OJD3PXeQcR9dqZ5Y7yZVLU8WDdZSUs8hEAVEMiuij4s=;
        b=mBcUp//R90f/Wq5aerXEP5Jb3KTttQ3I+AqwSlNt/W7te4T7VYw+iFp0bnSvhyclS5
         SuaYvm9L+9uEl7UZwFbpIvCpwbiuSo6BhQ8jzrn/7Nl/3EBUqzMK1KEpc09m4+VuS9Ia
         TXyP+XGJZKLTzLyq1Qyl4jyhHiiMz6S0NgesKDKGmDv1QhulRYmsCGo/BAVk5kb8NqJx
         0q8wQgaqz43l3T+r/p1tHqEviIJYRfTiSvK8M0bHYs7qgkA5hfeHpPHUKo5lyc/MC+Oh
         jLNPwkhR9c/Sh1h18sYqi0iQUaayC9xcNnwwzbcunlvd/UpaZ3A23OkZS2rDJxAtogBV
         ikMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OJD3PXeQcR9dqZ5Y7yZVLU8WDdZSUs8hEAVEMiuij4s=;
        b=mqFsPYkokLfQmNKS02Cxbh8c3mi2MGmEbu6f88l2C7GLmOzSpw1QgDC9PcjaPtRbhl
         35qOesRNVk7vj/cFec0G8ULH7S/17XXTZCRnbTtKnhldBdJVnU9T8ciR/8fdSmxbKg4P
         pm6srHEQtIyx0dLAhS9HjyTIUbwHLYQ1iNMZyXmefL0FTfaTmdRndCr+hlm4ZBhPAE/6
         3OyyuQTwT4+q7Q641RQRe/E06fIzfcTeCXt4IUXKmmWVsM8Dx7t+leMC9Q9LDTG1n3aM
         UB8TGMPlb2SCmJKZENNGAZyy/YlNICly74qMaSEmEJaAmixvLCnwipsJbFC7xQvYvVYz
         pbSQ==
X-Gm-Message-State: AJIora/UpBr56ZwRlcSuzXEgaFj14/beQlEJWsnRLTINiNI8wNTsVDcK
        4RM/vLpw9dhRuGFcmT1pqImJBT47V5AnRw==
X-Google-Smtp-Source: AGRyM1vx9hW9lzNzpgqm+U8e8cip5LlD6oegAC5bL8EXEcSPE33v/USYPPy/Vv76y2er5Hvfx5q6kg==
X-Received: by 2002:a05:6402:1d50:b0:436:beac:a4e3 with SMTP id dz16-20020a0564021d5000b00436beaca4e3mr15491833edb.191.1656320398400;
        Mon, 27 Jun 2022 01:59:58 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090611d300b007109b15c109sm4806316eja.66.2022.06.27.01.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 01:59:58 -0700 (PDT)
Message-ID: <6fa1db53-6e4e-b6b1-2313-dee7aadad5ae@linaro.org>
Date:   Mon, 27 Jun 2022 10:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: Add MediaTek Helio X10 MT6795
 clock bindings
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
 <20220624093525.243077-3-angelogioacchino.delregno@collabora.com>
 <de5a0e6f-411f-0c7b-ae1e-1117a4126d2d@linaro.org>
 <9554982a-c48b-e902-2d96-b317c46df698@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9554982a-c48b-e902-2d96-b317c46df698@collabora.com>
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

On 27/06/2022 10:49, AngeloGioacchino Del Regno wrote:
> Il 25/06/22 22:30, Krzysztof Kozlowski ha scritto:
>> On 24/06/2022 11:35, AngeloGioacchino Del Regno wrote:
>>> Add the bindings for MT6795's clock controller.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   include/dt-bindings/clock/mt6795-clk.h | 275 +++++++++++++++++++++++++
>>>   1 file changed, 275 insertions(+)
>>>   create mode 100644 include/dt-bindings/clock/mt6795-clk.h
>>>
>>> diff --git a/include/dt-bindings/clock/mt6795-clk.h b/include/dt-bindings/clock/mt6795-clk.h
>>> new file mode 100644
>>> index 000000000000..9902906ac902
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/mt6795-clk.h
>>
>> Vendor prefix.
>>
> 
> For consistency, I'd really like to keep the filename as it is.
> 
> At least in this directory, all of the MediaTek clock bindings
> are using the format mtXXXX-clk.h... and that's not only seen
> in MediaTek, but also in Broadcom, Renesas, RockChip, HiSilicon,
> nVidia, etc.

Several new files are introduced with vendor prefix. The same as in
bindings - old bindings were without vendor, so for consistency we would
never switch to vendor one.

For consistency with Documentation/devicetree/bindings and with all new
files in binding headers, please add vendor prefix.

Best regards,
Krzysztof
