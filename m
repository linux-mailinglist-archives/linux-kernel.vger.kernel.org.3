Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA30B5310C0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiEWMNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiEWMNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:13:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23D438D8A;
        Mon, 23 May 2022 05:13:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A7AFA1F430BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653308019;
        bh=v3cp80sJ9SzSDK/J2d7gZT2Ia9ALGOeIATvRiWBZxiA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F67iLJlAISqVNgoEhXyYh06NdBSFoUMKa4R29WyycbIZEFE+cvYcv6SVta3K5c0Q9
         WhWyJHZXC8iUUn5tZQoMA3cucIBgmAZdJKcmnpfPLRkX4vjr3LDAYjrWaZ57QJucPG
         +xV03Uk9wUHk4kdEOhYenY0c3M31u9JTDA/F2C0xeTmJ5hDoNoG1/aOnv3NNrA08cr
         XyuJbF5ISgXNUzG7e7Af7irOEO1oGC74C6/eaDPcpBYBe/LrSiMxqBhFTspAtFUUpb
         p8joRwiLPfF7oIAwOCKG/LyGzfdUuhII8lipnXfs8Su7M4gMDKqOqoHXlfMwHR++IH
         hdtehbD7YE7sw==
Message-ID: <da1e4b31-de71-1fda-eff7-2e70fe1331ac@collabora.com>
Date:   Mon, 23 May 2022 14:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right
 FEATURE_SEL"
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, jirislaby@kernel.org,
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
 <d91977d2-ebc6-de6e-5eeb-61c25ba0cc64@collabora.com>
 <Yot5uls/3vLzZu7I@kroah.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Yot5uls/3vLzZu7I@kroah.com>
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

Il 23/05/22 14:10, Greg KH ha scritto:
> On Mon, May 23, 2022 at 12:17:06PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 10/05/22 17:29, AngeloGioacchino Del Regno ha scritto:
>>> Il 10/05/22 14:56, Mark Brown ha scritto:
>>>> On Tue, May 10, 2022 at 02:46:28PM +0200, AngeloGioacchino Del Regno wrote:
>>>>
>>>>> Sorry for missing this tag, and also I'm sorry for the noise.
>>>>
>>>> Hey, if nobody broke anything all this testing stuff wouldn't be worth
>>>> it!
>>>
>>>
>>> Haha! That's true :-)
>>>
>>> Thank you!
>>
>>
>> Hello Mark, Greg
>>
>> I've just noticed that v5.18 was released, but without this revert.
> 
> What is "this revert"?
> 

"this revert" == "this commit", reverting

6f81fdded0d0 ("serial: 8250_mtk: Make sure to select the right FEATURE_SEL")

>> Can you schedule this for backport on v5.18?
> 
> I need more context here, sorry.
> 

As stated in the commit description, some MediaTek SoCs are incompatible with
this change, hence it's actually breaking late serial for some machines.

> greg k-h


