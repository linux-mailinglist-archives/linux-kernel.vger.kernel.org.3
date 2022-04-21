Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C9A509BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387307AbiDUJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387297AbiDUJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8675B13F80;
        Thu, 21 Apr 2022 02:07:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9683C1F45277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532063;
        bh=2ucsMMaorqV0O1+xEJV7r3jJ9B9DYT+m4ZImy6igSuA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lXKhzVjhHXP1gsTFoXCOwFrsNnKZ20AHs3L4ZLo+v0SMnE7umQtepEXQzjEzWSdVd
         h5NtBdY2Q5FPpKolRpSk7BCTCeXtP8w98LS5/28dxDVnZihxF7Ev67P0qsPUB2z5+C
         3m8XgRnwT8ajRQtU2rK60O7+yRVIlqQ09VMvVn6DAefzabRWJD9UipFsuy+f/JNEvj
         ppm/X/XVjTM/2eQfxlgQhDDk4HxlIjoagekHryRJNmUUUt8pDHyfTss5l55cODJvUs
         0tduheJwDSDY/m7PBvS/My8ZBcBTMcZ3myqxENo1a0JL1PRnU07AZY36CdiRlC1t9G
         8QVqYh4s0jAwg==
Message-ID: <f682995b-368e-6553-5b17-0c32b40b5706@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 10/12] clk: mediatek: reset: Add reset support for
 simple probe
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
 <20220420130527.23200-11-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-11-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> - Add a pointer of "mtk_clk_rst_desc" to "mtk_clk_desc".
> - Add register reset with device function in mtk_clk_simple_probe().
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


