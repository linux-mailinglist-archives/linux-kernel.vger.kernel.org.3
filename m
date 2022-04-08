Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B234F909D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiDHIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiDHIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:21:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8597E09C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:19:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3CE601F46C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649405942;
        bh=n3PZ5EP+atv7EGkUpF8rFTDvYYK90dAfeWT4ALjfgCk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AGaSlQ5GwsYXwaRRFXeblbG7SziGG7emykikpIAfxEU0y7PwcVwq+u6+VC78eN7ac
         dvw4nM8YN/wlDXzinoeJexXRkswap/l5Ls4ByFmjq/HeK24G2a+ei3E/QPHNlU+kb0
         FACQyoSJTpUN6/Qwc7zjRsdxlPDWzX/WDlEMy/6m4XewBkGSzAmTCCLqrY3gX6T3hj
         I96FsuASNPhaQ76uG7hfT1gtyOnHu5KrRh3XnPIl3aQoVUBLlIbyAfSs8KB68bB0ZK
         EkXH2Wm3jvEvoVccIPRgGHjU+2jhsf2pcMh5mSC8js3K5Of3XDs8yFPmkJJr5iHzGr
         Z0TDgO0kfr0gA==
Message-ID: <ba1d3b7b-9bcf-9c45-c487-91da767b83f5@collabora.com>
Date:   Fri, 8 Apr 2022 10:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/mediatek: dpi: Use mt8183 output formats for
 mt8192
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220408013950.674477-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220408013950.674477-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 03:39, Nícolas F. R. A. Prado ha scritto:
> The configuration for mt8192 was incorrectly using the output formats
> from mt8173. Since the output formats for mt8192 are instead the same
> ones as for mt8183, which require two bus samples per pixel, the
> pixelclock and DDR edge setting were misconfigured. This made external
> displays unable to show the image.
> 
> Fix the issue by correcting the output format for mt8192 to be the same
> as for mt8183, fixing the usage of external displays for mt8192.
> 
> Fixes: be63f6e8601f ("drm/mediatek: dpi: Add output bus formats to driver data")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Lovely!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
