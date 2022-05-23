Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1C530CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiEWJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiEWJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:17:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C350B1C915;
        Mon, 23 May 2022 02:17:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9BD4C1F42CC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653297444;
        bh=REzwy2jbEfxDlRNJ3gYCepX00BBtXmnPigKqEo22lqY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D9FDcKpm/V6yRmd3FNGHKKAzj+bP6sI/RUvJnUGA/L9Q6NnMjaWZiLg17f8OgDGs6
         /kqGAl1ZRQJr/1ejHXORNPOvXyy0OcCizWKPiZ1gymqf6/d7cQwbxcfku2jJUrYuH0
         BUWQ68P3a9lWBYW6+n3G8Hsb909xRgIF1gnftepXT0yyZjPRTgCDoMXtJScnBdDeRf
         Mfb/mKZ/CsAltCPWmyxDZ1zpIZ4gJijxWsfI4sdSkZKUqmfvsuyRBLMhmFN/qTzzQf
         m62m4JEBtGiXw/bPkfhRDGdCrtBZMVZDhpPwe5d4uDzhVSLw+E+tI8uxxB7726VuWm
         kkKvbGsDoNX4g==
Message-ID: <fed16322-1ffb-7744-38c5-4854882778e0@collabora.com>
Date:   Mon, 23 May 2022 11:17:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 19/19] clk: mediatek: reset: Add infra_ao reset support
 for MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, nfraprado@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220523060056.24396-1-rex-bc.chen@mediatek.com>
 <20220523060056.24396-20-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523060056.24396-20-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 08:00, Rex-BC Chen ha scritto:
> The infra_ao reset is needed for MT8186.
> - Add mtk_clk_rst_desc for MT8186.
> - Add register reset controller function for MT8186 infra_ao.
> - Add infra_ao_idx_map for MT8186.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

For the code:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
