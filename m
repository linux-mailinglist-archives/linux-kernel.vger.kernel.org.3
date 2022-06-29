Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DED55FA90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiF2I22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiF2I2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:28:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A378C62C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:28:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2647A66018F4;
        Wed, 29 Jun 2022 09:28:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656491287;
        bh=GH2xhOUcGT/R9ajjAeKkq4p/KZEbUFVa0+S35618jKk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U/OmEbF7QyBSwx/kXpjFoy2wtAZBeaJ4c2au+cijnLontCV72yuWA5wqePOVmKgGF
         UskLPCJMm4ZqpSKcKU7yUPD8XxHeuVlavouqaz9h5Y8FVdRM+qvF8x261HBXfd+tMX
         geM22IRqA122lCsqtelQyoapKmdNBj32JFAfSkrvwIWA5VCtR5w2nGKZtLkOOawuRs
         ItxOZM124S3mLGRcg15ToWiosvXXsYlxflD0CiOT1BpnymuTk67SYaGhcBjJM2pfPx
         MOBraxrTv65M2qSOZRHXLRNhEnjYYrnvXEN+u2NeICNveweSyDug+ev2N7ymqO9YgO
         blnHIIeCPxrhA==
Message-ID: <dbb7bbad-a088-a4d9-3089-166babf99fc2@collabora.com>
Date:   Wed, 29 Jun 2022 10:28:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drivers/soc/mediatek: mark svs_resume and svs_suspend as
 maybe unused
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-mediatek@lists.infradead.org
References: <20220628121326.2097912-1-jcmvbkbc@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220628121326.2097912-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/06/22 14:13, Max Filippov ha scritto:
> This fixes the following build errors on platforms without hibernation
> support in linux-next:
> 
> drivers/soc/mediatek/mtk-svs.c:1515:12: error: ‘svs_resume’ defined but not used [-Werror=unused-function]
> drivers/soc/mediatek/mtk-svs.c:1481:12: error: ‘svs_suspend’ defined but not used [-Werror=unused-function]
> 
> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Hello Max,

This is not the right solution... and besides, there's something else in the works;
check here:

https://patchwork.kernel.org/project/linux-mediatek/patch/20220623030931.2816013-1-jinxiaoyun2@huawei.com/

Regards,
Angelo
