Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA84E9000
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiC1IW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiC1IWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:22:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F33532FD;
        Mon, 28 Mar 2022 01:20:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 099651F430ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648455639;
        bh=HQeSR6lP1YVK1RO4bOxyH8L1tAiJpL08/BP+E0788Es=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PchX6yCNagZcmv/cIZIJ4xoFUc5KY5QbCuiRR37jrEqmzRqggK6rBEy4U6IALH/Cg
         nQg75bZpIBDhgWjVhrP+dt09LT6d6Y+7F5X7tlYzN02PalZ9AFWx3lHqu4f6M5QbBT
         qClRr8DTC6Se8DsJ7eAj7SamzrDrebtzkYD+T6kHkqTosplCkMTRDkFjsKCpAdbmb8
         dinN0voPiVoekx70EL0nQMLnt8k70i3vxr1GMYoTN4yLlavuNKnyxZX8tmR8HtYVBW
         2pgMlThJOvOVn7YLTrd6X0SxA/B9wz51KXngl1+M4b8KPkM/UHAXRXPt/DMyptTYRQ
         MhQGu8sTxltIg==
Message-ID: <9aade139-2e69-a061-de69-ab60ccc666bf@collabora.com>
Date:   Mon, 28 Mar 2022 10:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 12/22] drm/mediatek: dpi: move swap_shift to SoC config
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, airlied@linux.ie,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
References: <20220327223927.20848-1-granquet@baylibre.com>
 <20220327223927.20848-13-granquet@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220327223927.20848-13-granquet@baylibre.com>
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

Il 28/03/22 00:39, Guillaume Ranquet ha scritto:
> Add flexibility by moving the swap shift value to SoC specific config
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
