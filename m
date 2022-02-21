Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0E4BDD2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377885AbiBUOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:33:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377891AbiBUOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:31:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F9220F2;
        Mon, 21 Feb 2022 06:31:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8B3F81F437D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645453886;
        bh=y5t0agtu6l3qWSmQbVWo6rSISFkXfwEvCQiHR69W0oA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oAFQm8l/ot0FPP2f89ruUayorvCOSwkBuo+0qBQEE2bE0qQrd4Z0wnDvJpvyj0slg
         kvrLWe2fqj9v5chmvz2Sy25pYYMnBTAb2TZuYG1efeNuKrguK+FTB7AjsQUKx+ycrN
         7SZ6TBQTUgkYG1iWVcnkBLgPIJ903yxFalYuPebQxdoO+nBN5R0ZXLQhLkPnm0ku0T
         +WicaupPFvqKxBl0azniqhiRU2u0lfcvH97/9g0jwBR47i6NsJ++E4TcycCGLlsQir
         BiHP7PX7PT9p+qh476CyD6FSJCfjQTGNoMaGZVuXBZ50+RdQarJ/SpiaIPh1iLOc1M
         57JLVqeEk94LQ==
Message-ID: <6cd731d3-1aa6-7bdd-65f2-7c32df87934e@collabora.com>
Date:   Mon, 21 Feb 2022 15:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 11/19] drm/mediatek: dpi: move the yuv422_en_bit to
 board config
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
References: <20220218145437.18563-1-granquet@baylibre.com>
 <20220218145437.18563-12-granquet@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220218145437.18563-12-granquet@baylibre.com>
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

Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> Add flexibility by moving the yuv422 en bit to board config
> 

s/board/SoC/g

After the change,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>


