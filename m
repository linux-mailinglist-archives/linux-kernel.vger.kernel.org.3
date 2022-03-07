Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E34CFBB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiCGKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiCGKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:44:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08CB9BAD2;
        Mon,  7 Mar 2022 02:06:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DB3A31F4141A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646647518;
        bh=4n43d/kwvXqgTtP2E2cl7YjIgZdAaaHm4+szh2o0Gxc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EwoW0mzvhNAswzPhTZJMoUfN4KfgilCcPX4NOgtYoxJLCP1weeZ+RwOo4byFk1vKF
         fiaCMGPSktCLa2+cxO9t6SrLW/+DQohFOCQHiKdYMpzDBNd/xXNS6BkzH22VYYCKll
         t2QWOvkWgb3aL0gI399BWdl697lUu9afHg455bkHhnj9wjhNSwT8gvr+HOOJ5jzWJB
         zs8YNXL91r4jQw6HKEna8XG3NwDrL+6jj/AHhxZzMzUv4G8wPsKV+QNolanEmcU2ip
         kvvG0SJzKShZCkWm9LVj0q450AA6PkkQREXP7cRZMuvejSxQdNlAtSQx6rfL9wIyW8
         +Ru/yufyPPP/Q==
Message-ID: <e9b5aeb6-84e0-3bb7-f955-c986c8278320@collabora.com>
Date:   Mon, 7 Mar 2022 11:05:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v16 2/8] dt-bindings: arm: mediatek: mmsys: add power and
 gce properties
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        hsinyi@chromium.org, fshao@chromium.org, moudy.ho@mediatek.com,
        roy-cw.yeh@mediatek.com, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220307032859.3275-1-jason-jh.lin@mediatek.com>
 <20220307032859.3275-3-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220307032859.3275-3-jason-jh.lin@mediatek.com>
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

Il 07/03/22 04:28, jason-jh.lin ha scritto:
> Power:
> 1. Add description for power-domains property.
> 
> GCE:
> 1. Add description for mboxes property.
> 2. Add description for mediatek,gce-client-reg property.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

