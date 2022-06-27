Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2650855CCDA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiF0ItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiF0ItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:49:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AC06278;
        Mon, 27 Jun 2022 01:49:15 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB5FA6601828;
        Mon, 27 Jun 2022 09:49:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656319754;
        bh=o4KMjR/ZJMxFhZCtqu5FCmZbc0KpnWFELMON025GNow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YEcKuN9F7zr9YHZJ6SYqEkxZ03gQ8MkukZCgHEIgsdT0jrBqRB4H8xzKH2yIUiVix
         uAwnTIW0oa2ltYINpE6E5EWHfcW4oOXAinDlHd/Wk3VrObMjKuC9vN3CByop4pWHJs
         +PdewMxVydIslZSVxLsSTpRhzJQR6KvHtcPRvMr5r+mhDd+ZCAEJRBhph4SETfcs+6
         wqR+2tgzir/S++iNAm6++irP1L0fP99p7p1SPHrnGvAdwK53KGJ2EY9OFGyEHqpudc
         dD9MzF2c1ffEb8GtoDzj0wWHAQDjK851hRs+TffQlba/Mo7dLBSlDKKV7BzhuZO7ON
         iu3d7G+wgu69A==
Message-ID: <9554982a-c48b-e902-2d96-b317c46df698@collabora.com>
Date:   Mon, 27 Jun 2022 10:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: Add MediaTek Helio X10 MT6795
 clock bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <de5a0e6f-411f-0c7b-ae1e-1117a4126d2d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/06/22 22:30, Krzysztof Kozlowski ha scritto:
> On 24/06/2022 11:35, AngeloGioacchino Del Regno wrote:
>> Add the bindings for MT6795's clock controller.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   include/dt-bindings/clock/mt6795-clk.h | 275 +++++++++++++++++++++++++
>>   1 file changed, 275 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/mt6795-clk.h
>>
>> diff --git a/include/dt-bindings/clock/mt6795-clk.h b/include/dt-bindings/clock/mt6795-clk.h
>> new file mode 100644
>> index 000000000000..9902906ac902
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/mt6795-clk.h
> 
> Vendor prefix.
> 

For consistency, I'd really like to keep the filename as it is.

At least in this directory, all of the MediaTek clock bindings
are using the format mtXXXX-clk.h... and that's not only seen
in MediaTek, but also in Broadcom, Renesas, RockChip, HiSilicon,
nVidia, etc.

Thanks,
Angelo
