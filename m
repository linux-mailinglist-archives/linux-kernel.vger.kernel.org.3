Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9212D52B91E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiERLub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiERLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:50:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FB417B865;
        Wed, 18 May 2022 04:50:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B6EBA1F44EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652874623;
        bh=v9BT4jY0LXkbBKEpNBl7A0GnoXGTuIN7ai0ivp4fxo0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MDHUAkFFlwdwoLrZiH6kWeRTcdEKGTPyapZ/YpbtlbTBTDYChw2zzczD8UNhaGaXX
         c7ib5AqOU0w8q3zOjUiMSs1FtnDJpFtXZqk+d/3X8SHH6FzLuptdxWC2LtFmXzQlFI
         2C3TbheXt2uFZTm7lhfp4QUqCYNFaOeDzqGhKqzhE3qunw3CiKJ+Rz4YmaSd8R3s9Y
         gdvFBxVuBF2pQ7HdfWLPJgKH5r5u6oOfUbEqConajhIkeVbJagLiATav4M1jQm4kQe
         Q3y5bhqwImy2ZiDVFg+OGnJUi5ZKo4Tz5ysJ9tSuRqOiW+t9V310+qCe36wgzVgC49
         0gfZZDVLNP39w==
Message-ID: <73f6ab7c-635e-1ff3-2d48-492c256ffcc9@collabora.com>
Date:   Wed, 18 May 2022 13:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: mtk-clocks: Set #clock-cells as
 required property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
 <20220518093631.25491-3-angelogioacchino.delregno@collabora.com>
 <81dcc83b-7ef0-779e-ad2b-8d0722b48ba4@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <81dcc83b-7ef0-779e-ad2b-8d0722b48ba4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/05/22 13:46, Krzysztof Kozlowski ha scritto:
> On 18/05/2022 11:36, AngeloGioacchino Del Regno wrote:
>> This is a clock-controller binding, so it needs #clock-cells, or
>> it would be of no use: add that to the list of required properties.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> These I considered as somehow fixes so I did not ask to remove the Fixes
> tag, so also not squashing. It's fine, though...
> 

I'm sorry Krzysztof, for some reason I was sure that your comments were applicable
on the entire series...

I'll pay more attention next time, and eventually I'll make one more question
when/if needed. I take your last comment as "leave this series as it is", so
I will not send a v3.

Regards,
Angelo


