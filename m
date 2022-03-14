Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE74D8029
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiCNKqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiCNKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:46:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015A1E3C3;
        Mon, 14 Mar 2022 03:45:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3EDC31F41E94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647254703;
        bh=j588M5zB/9t7D4ivjAn/3OXlaIV0VdQg6MdXm4IofKk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zk8FhjIpdGaMPLwBRGovJ8HzZIFKyOryuzdJ4lhXvVF1S7EC3W1O+6oudNWxJWXkm
         vs5koGvEsgQRb0F+l9de2Guee/Aq44N6hZ8NK92crkLMMwLqHMl56tS2K4nArbraU6
         ULrKVlWcEEfR8GB+SZfUgjYsq7iGEyKelmJNQAzqe1Be+gFlGobagf97SqCOAzENwN
         8gM9f7LVM33AK8Zq4sN2BpE1BLo+DC043tHTjIc/uWbbxQVf0zhxKrm2gXjGvUfJqu
         R5EiuzwOgRjSsyGd1CV8N4PoRA+G7laLxzSL5ccNBr4+C/8KVEeQqUScJQUrfoN1+C
         hcl4AWu6OL+KA==
Message-ID: <d13b7bb3-989c-55eb-c7b9-41836ccb95a9@collabora.com>
Date:   Mon, 14 Mar 2022 11:44:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 15/19] ASoC: mediatek: mt8186: add machine driver with
 mt6366, da7219 and max98357
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-16-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-16-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> Add support for mt8186 board with mt6366, da7219 and max98357.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   .../mt8186/mt8186-mt6366-da7219-max98357.c    | 924 ++++++++++++++++++
>   1 file changed, 924 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
> 

Hello Jiaxin,

I see some duplication between this one and the mt6366-rt1019-rt5682s....
....for this reason, I would propose to split out the MT6366 bits into a
common file, something like mt8186-mt6366-common.c, as to reduce the duplication.

If it is expected to see MT8186 machines with DA7219 or MAX98357, then it'd be a
good idea to also do something about preventively commonizing these ones, like
it is being done in ... MT8192, if I remember correctly.

Regards,
Angelo
