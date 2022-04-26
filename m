Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F950F9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348465AbiDZKLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348471AbiDZKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:11:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F98209F19;
        Tue, 26 Apr 2022 02:34:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 70EC71F42EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650965653;
        bh=Z6n2q8wBqdT14TgYeHPogEpYZASOKVeIGrkc2DakH1k=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=eP4Q5RH0xTQ3ms8CVZker+XZ/hyknF1puDrOlKb3EgFws7cDlZxKUm0jjvYaRyI8g
         ITjwRsOyTHy93bt1V2vHH7YC8+x+K5cFsnUwhGn8a6ptTfHXACXxplrQU18bPwQw+S
         tJXPOeY5o/khpPsZjyFqCcXty8ebMyTNsbrJEgV+6NLsdo6FHsyjRRBigMK/KEoM7Y
         rA0TdNCX/daKPdJABBx70qvL+tUEydaIPdh0xgK/IjwbN81Sr7A4q2zLo7yLgOVQTQ
         TwB/r8LXm0NKhp7lKgpbxrtpiMKR2uU2dx0CLng1p9d+YEplHscwI+Z20NrHdWBJvw
         mv+vZMz7HRHJQ==
Message-ID: <edeff584-89c9-ab33-5c9d-f086be758640@collabora.com>
Date:   Tue, 26 Apr 2022 11:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V3 07/17] clk: mediatek: reset: Add return for clock reset
 register function
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
 <20220422060152.13534-8-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220422060152.13534-8-rex-bc.chen@mediatek.com>
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
> To make error handling, we add return for mtk_clk_register_rst_ctrl().
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

