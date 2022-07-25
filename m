Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568E35802A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiGYQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiGYQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:27:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B291CB18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:27:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w15so10813042lft.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a8qgtbyQ2Sb8S21ck6j2VRxOU1twEycLNKRZP70WuG8=;
        b=JhtERbfmoVEvbWgiY8SuIKSc43gL6rNbUppkuVwEQjXZ7KDlqomb8akiU6M2py8RTh
         keUK/ttlR+gj+ew2QoYldWSiuXopIcE/oY59thxBNiu/vKCNmTI5pkBA6aUxm0JvvtZs
         EWk6+6iE69emTjZlUTZVBBUT6GGPlbLXxMOdC4fVgwvNEVHT+aTPHkEW2ml53r83EjNF
         T3MPNymLb/VEkNNYNEQTgwkzJNNQUjv+eLPIgdWjiB2MkfAnTeC8T3FNKyHLf650xZ4D
         o/MUc/NqZFExoNlA6RAU580SH47kbJCqeIGSclpIxzWWEdLxso9AoRG0exMZkwW8BGXq
         VzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a8qgtbyQ2Sb8S21ck6j2VRxOU1twEycLNKRZP70WuG8=;
        b=AHJzHzMBYYGzB+1K9GCv6Ak3iUDtpyuUG5VecuS++XM4J1H1LCKEFBw2MYJbleLJ/6
         GGQVoBQcT28qKBr/OXzYP8lOgubXhBB2kRjY9dme9BVkH7xDttR1zYPf/fNt6y+hjKIN
         JRHFxq8nuf3JYhCc1Dvy/alXbYQWQHxBnGxAp9cdKpOPvLe1c61A9xw6SIYu/VXEpnAD
         uPIRgv88GJuRYls0l3NPHfu5RZLl+4mlzHZls8oNjwWeK3+jUGO3gj12OPbw+WzHW6+F
         69uHfmp+fDvYhLYyo7xnL5IpcEg4I628CQcvPTAu1PGrNafgtClJXcO1WZ2ooPvj/rqm
         PmqQ==
X-Gm-Message-State: AJIora95BEoqM+I/1M7Laof0pVbNJ1pcCl5iZG3NtPUHIilYqtaJZs2a
        pS4aR9tKjZ24z4flgDDl+VQp7g==
X-Google-Smtp-Source: AGRyM1ukQToOk9Zpdc37MBg/4uZr4idwBKkMofuxwfvIVe/VMLESuNHBmYViO8Fap4CebE5hIwIXsg==
X-Received: by 2002:a05:6512:693:b0:48a:7c23:1896 with SMTP id t19-20020a056512069300b0048a7c231896mr5121392lfe.111.1658766449738;
        Mon, 25 Jul 2022 09:27:29 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id f6-20020a05651c02c600b0025a724f2935sm2812818ljo.137.2022.07.25.09.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:27:29 -0700 (PDT)
Message-ID: <a1ecd715-4f74-640c-09d6-5b74e026ecb0@linaro.org>
Date:   Mon, 25 Jul 2022 18:27:27 +0200
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
 <8d656940-567f-d8ea-8cb1-4ca37dde3e0c@linaro.org>
 <6d6d05cf-9c56-a29a-64cd-1de62c530167@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6d6d05cf-9c56-a29a-64cd-1de62c530167@collabora.com>
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

On 25/07/2022 10:13, AngeloGioacchino Del Regno wrote:
> I'm sorry, yes I got Rob's review tag in v5 and I somehow forgot to add
> it to v6 :-(
> 
> Should I send a v7 for adding back the tag?

Yes, because otherwise it will pop-up at Rob's patchwork for a review.


Best regards,
Krzysztof
