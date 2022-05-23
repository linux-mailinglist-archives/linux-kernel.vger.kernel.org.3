Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A91530D14
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiEWKRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiEWKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:17:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F326C3E0C2;
        Mon, 23 May 2022 03:17:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 32CA71F42B75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653301028;
        bh=+CEmnlKnE+pry/LuSR00IJxwk/4DdZxU58h7kQU51Yg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Yt25R1SExf+QhJ0+O75tj5O8LBTj+6269bMusl6Bp4rS6HhNlIkwSDQVfB8Si8XS6
         hV1DzV9sFU16BzHZ+O0BMEnJT1Q3kEcE4iBSshgKYMpj2sN28piLmMvhsXPmLiCop9
         +UHRzkfTD4NhSCyUigqTaWX0oSV8PYiggPs7iMcw47Nqw7QGVgPFDdAnTXnYCtmYfB
         eNEs34tvcqa9g2q2VKgrgCqgmbiQeMURXC5oyCR1Wik0/YQdQmjS7Gr60Pe2aIn1uu
         CvTy5kV6VzBMk4FW1OFgBharyBkQ4cSnCctoZ63A1h35QnDGlkVxTuMWNWGOoparZK
         iJ9Q7iYFmap3w==
Message-ID: <d91977d2-ebc6-de6e-5eeb-61c25ba0cc64@collabora.com>
Date:   Mon, 23 May 2022 12:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right
 FEATURE_SEL"
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
References: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
 <YnpeYGbo7JJK0lDk@sirena.org.uk>
 <b13b019f-f766-60df-3764-d375f64ea7d3@collabora.com>
 <YnphFjs4E4EYafT4@sirena.org.uk>
 <63169e65-cbfa-d495-754f-023dc8befa42@collabora.com>
In-Reply-To: <63169e65-cbfa-d495-754f-023dc8befa42@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/05/22 17:29, AngeloGioacchino Del Regno ha scritto:
> Il 10/05/22 14:56, Mark Brown ha scritto:
>> On Tue, May 10, 2022 at 02:46:28PM +0200, AngeloGioacchino Del Regno wrote:
>>
>>> Sorry for missing this tag, and also I'm sorry for the noise.
>>
>> Hey, if nobody broke anything all this testing stuff wouldn't be worth
>> it!
> 
> 
> Haha! That's true :-)
> 
> Thank you!


Hello Mark, Greg

I've just noticed that v5.18 was released, but without this revert.
Can you schedule this for backport on v5.18?

Thanks,
Angelo
