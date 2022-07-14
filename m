Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F97575068
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiGNOKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiGNOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:10:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1E04A81F;
        Thu, 14 Jul 2022 07:10:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EEB316601A3B;
        Thu, 14 Jul 2022 15:10:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657807816;
        bh=qi/qOdOVZ40TVm5BT2/tqZLayvaYuJfwS71mNq4bK94=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JcdIcR6Og4Vg9G6/9NmALwvVAnVa9VVc7Z01u+3km5ggJNGstH/4pJ8D0LHNEuegB
         mFtYzl2+56pl9b3k+sEKlNHI4TgPx3a/W/pgtLr/9TuzNqeHpQpAToedt3p88LRtmS
         sMPyK9voeYry8ejPqJHihHXQkCUQjhzPSlSECNG9YwMup3Y32/hLw0g78EoAg195J6
         hm9M8+N3oTLBMqs7DLpK2uz1Rb1UvI7j3dkVsLJP3MtYvx+Z5P/2l0jHwBEufEjbnc
         dm+D9Vfd95ke/aDxE9WwYvcn1yX1XMxF/oy8c4tmhPItqSLBaergEPHz+0jRi/Mth7
         U4tJ2v1DqiT3w==
Message-ID: <a1e984eb-4d12-fe71-1538-ff2ca4df3add@collabora.com>
Date:   Thu, 14 Jul 2022 16:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 3/8] ASoC: mediatek: mt8186: add mt8186-mt6366 common
 driver
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220712150442.32504-1-jiaxin.yu@mediatek.com>
 <20220712150442.32504-4-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220712150442.32504-4-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/07/22 17:04, Jiaxin Yu ha scritto:
> Add mt8186-mt6366 common driver for mt8186 series machine.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

