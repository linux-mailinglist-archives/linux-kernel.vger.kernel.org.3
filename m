Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E894FE4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357062AbiDLPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357157AbiDLPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:32:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0849F34;
        Tue, 12 Apr 2022 08:30:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4C8611F449DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649777437;
        bh=lQ4NdSCZzsjrOwPly6smii3XDpZabMAoBkBVD0ftePQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DypMHo/iqBWeOVAIsUtbr1TgMRAo4Egs4mPvgCYZkmDXSh575Wnsh2QlOf4+zqnZ3
         HTc+h+30pelHZrWbwZMI5mxhwWB4ip2KId8dHBa1Hdul5lrLZ03e95mkFmtWa6Lrf+
         rwomvfA6S+IH4/wD0SLVUnRByMfS8kW8J3AGX83mzQnhbR3vb42SDAAkVrb0J7djP5
         zh/RBmU1mEP1yWGCGFzM1LuMe2QrvVjGYOynP1YYnV9Cp72fk4DlELrtKCKkcvLgYR
         1W/NwnhXSpzpC0pD7RFoZjPUG1x1d/zhWdLVzl1kRe0VDGNZZdUrUMIsNoF9uN/e3h
         CGn/SyVelKLJg==
Message-ID: <138aad1c-63d7-371a-ff41-4fd7022d365d@collabora.com>
Date:   Tue, 12 Apr 2022 17:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] soc: mediatek: svs: add support for mt8186
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com
References: <20220412112127.21570-1-jia-wei.chang@mediatek.com>
 <20220412112127.21570-3-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220412112127.21570-3-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/22 13:21, Tim Chang ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> MT8186 svs has a number of banks which used as optimization of opp
> voltage table for corresponding dvfs drivers.
> MT8186 svs big core uses 2-line high bank and low bank to optimize the
> voltage of opp table for higher and lower frequency respectively.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>

For the code only, as I am unable to test:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

