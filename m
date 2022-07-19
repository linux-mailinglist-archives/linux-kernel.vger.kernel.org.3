Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A70579696
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiGSJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiGSJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:44:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631D27B06;
        Tue, 19 Jul 2022 02:44:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D2E0B6601A84;
        Tue, 19 Jul 2022 10:44:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658223887;
        bh=iPLT7orT6p2DHBeQ2X3yYwTk7rc/ErbEjE1ySXD1v3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fzvMLRp7lJ2PLEUHXHUHztyjmDw33j1uwd1Du70q+jT1wHneym8PzxMAowsLKg0JP
         FXJxUo86sm4sz6lD/9QvRuTUwwY8T6EOVTG7zdKz4XGuwGI2WlNBRUPbi/1AUoOvO+
         W/8C3V4icsAdswCTfzA2vQruq0pqfoLyai/fLzPKkXg+Pf62cvWNbPO8/dco7su4/9
         aWypzqT5k6tLE1ph9gG1HuEKIzELNDmArEdR7dghn0qqCFeT0seOT1sLOe14Omn9lp
         dD4xo8tc/khJCz0Lx27RwFwU7F2hMNED8EOh1CUWv6j2RnvtscbSxsdP/B6UQsqGbn
         BE+hWOO6uvwFQ==
Message-ID: <c764d5c1-2d4d-e829-a728-eed253a66701@collabora.com>
Date:   Tue, 19 Jul 2022 11:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: Add compatible for MT8188
Content-Language: en-US
To:     Hui Liu <hui.liu@mediatek.com>, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     srv_heupstream@mediatek.com, zhiyong.tao@mediatek.com,
        guodong.liu@mediatek.com, johnson.wang@mediatek.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220719014657.28714-1-hui.liu@mediatek.com>
 <20220719014657.28714-2-hui.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220719014657.28714-2-hui.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/07/22 03:46, Hui Liu ha scritto:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> Add dt-binding documentation of auxadc for MediaTek MT8188 SoC platform.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

