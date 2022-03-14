Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19F4D7FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbiCNK0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiCNK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:26:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB5743483;
        Mon, 14 Mar 2022 03:25:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B01451F43505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647253522;
        bh=aEs1SFqoEgSqlYmwJeL2S9EUjavPhZ0L4qzqDRpfny4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LzuHfhhhy05sxCVVCJOoPAdJqjRDABOOt5S9sp7Ks3z/oFTmuJB3u1v7UGWtK9Cme
         JXZq+4vin3gzjUZgoB4H5PxuMgzPttAL0rlyXOZ4zYbkqLbJGJdIRnDa6offNrQvJN
         6Axy74Efz4VMD9AUYgIR8k0+fI/42onBtJ1oPN0ilBvrpR+SmckwhT0MZlQba6JG3C
         +bY4g/FdhV3GsnAhQkVxRhaiO59nyOCtKbXJSgznRuZvCOCwc+jAuv6SP1qEk3xfg3
         T/q4AZyawkdTNhMsdPWpNYXgk7tnQQxVGvDaY022TXM6wEwFrJ3v/wZ+CEiWuFK2u+
         qXxMC3JYW4wKg==
Message-ID: <3d980cef-cfa2-6161-9c5b-cd0705d8e8b1@collabora.com>
Date:   Mon, 14 Mar 2022 11:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 05/19] ASoC: mediatek: mt8186: support hostless in platform
 driver
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
 <20220313151023.21229-6-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-6-jiaxin.yu@mediatek.com>
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
> Add mt8186 hostless dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../soc/mediatek/mt8186/mt8186-dai-hostless.c | 298 ++++++++++++++++++
>   1 file changed, 298 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-hostless.c
> 
