Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E964CA1C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiCBKGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiCBKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:06:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB32AA2EA;
        Wed,  2 Mar 2022 02:05:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B87CD1F44C4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646215532;
        bh=Px5GBQ7EElBGp4NHQzwbv9Xg/hWCIXOMw+5mUBSPG2w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KgVMT15N2sjROZubbpp8d8WeavE8c+WnOJo8lSV3mcp4FWNTN5a0E1n5mF7b8L2r/
         WBE0z93+LCWoewqdEpB12TDge0xCWcKwvbZtpFAOTSSain4IsLWu1S6eiEObc7X7LC
         D8ds76/q5vrK87/dBQI5610sq0VcTAjTsTh+v30++rpJfKJjklLZaI+T22koGpxcZU
         mJER3zD0mRXJJK/xQPzmpCkCBhdwUmcvaHBAbp+J4Q8ddQiT9GltvlfDJQPUiZMB9k
         JyEax3kaPE2xHPgwtsAwj6mS1Im+5HB+hlOopN2wSE0dfgxBb2uTrffMiycESfJaD4
         oIaoCuVA9OlHQ==
Message-ID: <0b7ec857-2dd7-1037-2896-07103506ce17@collabora.com>
Date:   Wed, 2 Mar 2022 11:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v12 19/23] drm/mediatek: add dma dev get function
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com
References: <20220222100741.30138-1-nancy.lin@mediatek.com>
 <20220222100741.30138-20-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220222100741.30138-20-nancy.lin@mediatek.com>
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

Il 22/02/22 11:07, Nancy.Lin ha scritto:
> This is a preparation for adding support for the ovl_adaptor sub driver
> Ovl_adaptor is a DRM sub driver, which doesn't have dma dev. Add
> dma_dev_get function for getting representative dma dev in ovl_adaptor.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

Reviewed-by: AngeloGioachino Del Regno <angelogioacchino.delregno@collabora.com>
