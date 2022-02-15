Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF3B4B6E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiBONu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:50:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiBONuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:50:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E1DE0CA;
        Tue, 15 Feb 2022 05:50:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9B8BA1F448B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644933041;
        bh=JEcDT8iPPVtEnaL6xs6DtX0CKuxeUOZEe9hsBxgR2z4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OQa27yycZygiqlg97jFpe1s1CT+O65NkTKyAR1mNpRKZzCFu5feVvNmKiPkykjyk9
         /oCrPmjmmC2NtUxouPoNojQmfP/hItZ2ymEGFwBffcUVK95PnCj8rmqHrHVT0BTXkX
         XXHBBWb8HsMLF0KKcF8R3Fa75aEBhxK3//NjM0b/8LIpBeRTTEyaLpwZUAE68Eb57p
         QNeAggHo1x/ILYPniE9atM+/LJPZUhWuWlpiDrYPRFzhB2fQuvzDSZldwoDIGW2Xea
         0VGRrJymNHQgaxZLxe764OTGEl2dXmY1AW7VkI/q0eLEQe1cf61CgMct4Bq/hDwdV6
         Pw01HFV4aPYtw==
Message-ID: <8b728682-55f1-60a1-b41d-23ccac2a4e99@collabora.com>
Date:   Tue, 15 Feb 2022 14:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v17 2/2] mailbox: mediatek: add support for adsp mailbox
 controller
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20220128110829.17202-1-allen-kh.cheng@mediatek.com>
 <20220128110829.17202-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220128110829.17202-3-allen-kh.cheng@mediatek.com>
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

Il 28/01/22 12:08, allen-kh.cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This patch is to for MediaTek ADSP IPC mailbox controller driver
> It is used to send short messages between processors with adsp
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Reviewed-by: YC Hung <yc.hung@mediatek.com>
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---

