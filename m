Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92B54E080
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377017AbiFPMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377126AbiFPMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:03:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2494EDDC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:03:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 279BB660163F;
        Thu, 16 Jun 2022 13:03:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655381017;
        bh=W6TnXzN7tlg8HsJN6dq/ufsPn63iDCWZZX6PZhUj48w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g6MVcgFlrnrif1J+IZnTY4MAvlm4tJWVrplsCk/XVWz0npsRRUxGRI449dqyXP1/Y
         GuQRxmQ/YkX+Ze8/RocIoEMNOnlGwpSPRVgXdOcf7lx2vKIDm1pngOb7yylYKNEu+P
         zA/5+v9NgCzNH0Xomjb3zqp5ufv213dVxr5htDNqJ8KCtyeAVz7O0/0ssa+7P+7J5L
         hwFXD5SNaPzyD0TksPWENoeuEwaO1kpYq2ZE1EGSCZMyoxQ4AJg68f7sv5hvaQBqPw
         N2H2NpmZb4OJSnDHALEaurOLRww3y5LBbb2fM7XdrES5qYAtPeWjH30WNgrVR420HQ
         vNoVgEsbxacmg==
Message-ID: <37676cad-bbe8-0e4b-6632-ab57d29bdb20@collabora.com>
Date:   Thu, 16 Jun 2022 14:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/5] iommu/mediatek: Remove a unused "mapping" which is
 only for v1
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-6-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220616054203.11365-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/06/22 07:42, Yong Wu ha scritto:
> Just remove a unused variable that only is for mtk_iommu_v1.
> 
> Fixes: 9485a04a5bb9 ("iommu/mediatek: Separate mtk_iommu_data for v1 and v2")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

The title isn't immediately clear, looks like you're removing some mapping, not
a struct member...

Perhaps... iommu/mediatek: Remove unused "mapping" member from mtk_iommu_data ?

After clarifying the commit title:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo
