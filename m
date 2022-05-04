Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD1551993D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbiEDIKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiEDIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:10:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041BC222B8;
        Wed,  4 May 2022 01:06:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2BA181F43E10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651651606;
        bh=g4o2JNm4Ctpm5k1rvLgGc8KPep2McYePUQzlec3QBWk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b/wlNUz6s3DO+++GsE2ms8gl75kjfDcHwqg0VE1PAi8+0eGfY9Hgd+U3h0xCQexaw
         onor0VkEbaFunBBtN0TyEFGreN1HUquBgcnuphdhihUaG2/gFDLi+ygm/T+Hdm7qsF
         Q8L0HyrMwPuC6TtwBQgOd8Yf/yESF3rkq+9+w4mebNjM9RHr2DTlT3pHLCrE8mJsTV
         E5aP3PfpTUcIRjN5mET63+Lb44KYzvrSkizpzqPphT13AWjMJjGm8q/psEcy5P25G1
         QDvWmIrpGxqdYpADcFcwY5F8oDdedjsnxnNOGL4l+qPaD3bMNF9qjK1egW74egsodG
         kTQkLFtbDO3TQ==
Message-ID: <a387728e-94f0-ccd0-3936-977db545efb7@collabora.com>
Date:   Wed, 4 May 2022 10:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 4/4] drm/mediatek: Add MT8186 DSI compatible for
 mtk_drm_drv.c
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de
Cc:     airlied@linux.ie, daniel@ffwll.ch, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220428133753.8348-1-rex-bc.chen@mediatek.com>
 <20220428133753.8348-5-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428133753.8348-5-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/04/22 15:37, Rex-BC Chen ha scritto:
> The compatible "mediatek,mt8186-dsi" is used by MT8186 DSI, so
> add it to mtk_ddp_comp_dt_ids in mtk_drm_drv.c.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

