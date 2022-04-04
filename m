Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA654F14DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbiDDMb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbiDDMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:31:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FEE25280
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:29:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CCE9F1F44C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649075395;
        bh=Z7ztsm3Md7Jvnfrh+eL9+Lf65aVRzhlpG24eO0rHEvA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZII2WKTROH8jdnDAzt5U2pGxzVQKtQeF+d85nHqB5WvP26sBmU3HcY+ZgCSdalt/w
         MyE1oOQbTo6iJqLumvHZDDEHlrJNWLEIfxLp731qI2xtj3+KaUU1Oj1XHZv3lc3f90
         gKgvNpdpPQ6cc+nHoNygxlowKPXLsFwTSlTjlosRIFAlzG5K/MbJdBuDUUIL8IyJAH
         bijprzeZUBNtEcRVnwl7RWfNlFnVJxLR50su+PUPN1urxY3I3+mgf5jzho8UDRM2YE
         cQdF/iqxHw3p1GDHcSac7hp0nm8MNerucbcG8fWN21ORt0bQvQmZjWsgTjXZT15WRt
         kPoCuQtncnFPw==
Message-ID: <db1f701f-c2f6-bb89-635e-2871fc781140@collabora.com>
Date:   Mon, 4 Apr 2022 14:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: mediatek: Fix error handling in
 mt8173_max98090_dev_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Koro Chen <koro.chen@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220404092903.26725-1-linmq006@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220404092903.26725-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/04/22 11:29, Miaoqian Lin ha scritto:
> Call of_node_put(platform_node) to avoid refcount leak in
> the error path.
> 
> Fixes: 94319ba10eca ("ASoC: mediatek: Use platform_of_node for machine drivers")
> Fixes: 493433785df0 ("ASoC: mediatek: mt8173: fix device_node leak")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

