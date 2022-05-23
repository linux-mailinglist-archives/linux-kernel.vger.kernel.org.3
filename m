Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC3D530D57
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiEWJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiEWJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:09:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D60A4615A;
        Mon, 23 May 2022 02:09:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2E2971F42BCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653296987;
        bh=/sfhtu0EJohUa0an01RNJupcRbWDB39oZa1Mvb18IbQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YXnQr2gjB16+I2gt4DJQkMrEs4p16e02sC+yfzyaZdX/DF8o3rHBIpWaWkNLPh4uA
         moZVAgXY44+4TFo6g8k8X3zrBznP28EhfWk+xhMjA7PQiD5nCLx6i9xaXuXsYcQJ9i
         JfTna1UFvxHkcUP1uA7lzr7vR3avydfbImk5rHO9b+uoBM8VvWuLXQly6THvkwoC8j
         JHyn7+0GQmGamonjJ1IY+lvUCAdWDnpceEw6HSUXalm7GMyDaunOoE9ZOUIcudx1UM
         SNYSdJ3s97PuRqMALUSWO+GRdmUxXj12B9zq3j7K7C0SyhVDc5tbK2mYb0dKUtjFIr
         iA4g6NU5aQ1Ug==
Message-ID: <1dbc63ba-e89e-1a0b-b7a2-2939208a97f7@collabora.com>
Date:   Mon, 23 May 2022 11:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 18/19] dt-bindings: arm: mediatek: Add #reset-cells
 property for MT8186
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
 <20220523060056.24396-19-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523060056.24396-19-rex-bc.chen@mediatek.com>
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
> We will use the infra_ao reset which is defined in mt8186-sys-clock.
> The value of reset-cells is 1.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
