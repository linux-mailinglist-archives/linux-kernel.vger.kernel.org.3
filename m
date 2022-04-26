Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65F750F9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348495AbiDZKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348337AbiDZKLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:11:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D9209069;
        Tue, 26 Apr 2022 02:34:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F17291F42EAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650965650;
        bh=rb6ZxyZT0dyUbID79DdULqa8/WRjiOlgTOrn8dU0NJg=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=A0G98VygsLasScLoSR3LYJ/RpGMk1rJduo9ZbtTHiA8z6ACqNh2+IuiM74QRylEhY
         X9Jme/cyDF8oAUZF+VvXvrw2E14SL8ldIonkiW9GnNud1is3t2MnePuFWqZp7BcvVJ
         ZTGnatfyE4hNboFXSsxOeaBadkyhATJtx1McVKChj1oOPsjWuQNtP/LLeccxbWQe8M
         JWcxIEch7KGTZvX3CrlqlifWeyiEd1ldxq4AJZlGe6vGywN9c94FiYePl9Nq+IdtBn
         HkVtDhLB+5dSkWK1c7Ca4hcEUjXS7dQWFLvkWouXvnQV2rl9Kq7Sh6fSByd0EETRec
         X6jquPXMEaiyg==
Message-ID: <d235bfc8-8f43-aa87-b79a-ce15d81877d3@collabora.com>
Date:   Tue, 26 Apr 2022 11:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V3 06/17] clk: mediatek: reset: Revise structure to
 control reset register
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-7-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220422060152.13534-7-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/04/22 08:01, Rex-BC Chen ha scritto:
> To declare the reset data easier instead of using many input variables
> to mtk_register_reset_controller().
> 
> - Add mtk_clk_rst_desc to input the reset register data.
> - Rename "mtk_reset" to "mtk_clk_rst_data". We use it to store reset
>    register data and store reset controller device. It's more easy to
>    manager the data for each reset controller.
> - Extract container_of in update functions to to_mtk_clk_rst_data().
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

