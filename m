Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231444D7FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiCNKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbiCNKaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:30:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56CE3F306;
        Mon, 14 Mar 2022 03:28:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C73B91F4354F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647253729;
        bh=bwHJoPxyu/AsruLxj2fvTwgEqOZ11tvgaKSJ2SduNvU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C7Pxy4F/H7J0euO4lGClMCo9eeB6EsBAqQe2Cwxtqs/Rj+fZfImezffwz8imhnSUS
         PXw0pBauG13We073OAWMG8HwjQIqgNSMWPxi44sV8xQDZBtIxNjvmSR4RvoVuCApCG
         j4aO7+o67W8/NbD9orC2PYd1bXVjE3R28VC9Vvb5OlCg1lHufKIa6XygCH8F+RLJac
         BbnJa/Cb5mbFm4g0JObcD20Zw2QxqHkV3Mp4yL1UQUAOqsZiP+QMLEqF+C/7sVdXee
         gLfi5vzapDWRvbLc+r/I7kOtDmjp5G/sp4vKMilLGvN9Bu7ZjALK9AMNaA28x+MZ9Q
         tjvCVw2taCy3A==
Message-ID: <2cdd1e7b-d1e0-7cfd-ff24-18320dbe2a51@collabora.com>
Date:   Mon, 14 Mar 2022 11:28:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 07/19] ASoC: mediatek: mt8186: support i2s in platform driver
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
 <20220313151023.21229-8-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-8-jiaxin.yu@mediatek.com>
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
> Add mt8186 i2s dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8186/mt8186-dai-i2s.c | 1355 ++++++++++++++++++++
>   1 file changed, 1355 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
> 

