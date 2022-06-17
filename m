Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1A54F498
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380984AbiFQJsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381250AbiFQJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:48:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0756833A;
        Fri, 17 Jun 2022 02:48:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7FAB660179A;
        Fri, 17 Jun 2022 10:48:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655459303;
        bh=uN6wnbzAZuoDWwRcuXfVxiPLqXUDSzCb7JMLgqXhcJY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PiYfAcyPeP0HfwUiZkJpxWz8nAl4hgrf5aNPMEFifj35+464fd2lwcx/ebiiChtPM
         DpjmiH90rIx/6+VUzJDkpM/4d+WGK/9zI1HKHapcXJ5O0Lu7w2bT+QSNT94isb+UbY
         M8PUye0LtMKw22fs0VSawR1LKce7KVYuAnn7xVkji+UR8YzV26irDQf5WpWvGmB/GU
         iwezIe0MY1BokCxkUKX6N7UicST6Db6rzBmXWTjykRB9tS7eCat8DgW94Qon7sopIo
         wnNQcb1NzdIF4KM4LcPD6eclqVVZF+5iAIdQnRCF4lzdyK+EPtXdoBww+jQeoGA4NQ
         vualHWAqQimFQ==
Message-ID: <d5566b11-e3eb-28bf-73d1-b17e0802b0c0@collabora.com>
Date:   Fri, 17 Jun 2022 11:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v10 2/2] phy: mediatek: Add PCIe PHY driver
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wei-Shun Chang <weishunc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220617070246.20142-1-jianjun.wang@mediatek.com>
 <20220617070246.20142-3-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220617070246.20142-3-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/06/22 09:02, Jianjun Wang ha scritto:
> Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>

Reviewed-by: AngeloGioachino Del Regno <angelogioacchino.delregno@collabora.com>

