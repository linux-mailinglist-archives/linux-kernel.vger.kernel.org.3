Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF904BB968
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiBRMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:52:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiBRMwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:52:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960955E76E;
        Fri, 18 Feb 2022 04:52:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 281841F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188744;
        bh=XVKS75XpYQxb5/TVvYHVixSh4Vl0aBXRGf/YFk8Ta7w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SIGILJp6htL6o7lcCxedptEr2v14pHNt09Vrw6JNFphmrJAukrVO189Vh24oMXrPI
         9vWL65qlnN0jlhLfVMM4uHAb3DBCt0Z2vZbg7Li8fDKINWurPLaq7nqi1Fen2h2puJ
         5hfWkLAuXRZvi37rGQ9UjY6jpHS8g1EpBPPcjBruJ8Kl+j2/3abxB7oDSZp8TpGaZO
         StC+31dsaX8r+TWfIAL8CkSMdDsvqWJEJTY07p3+ca3fzCqaCf3j/q/CLuP7UOs8Mz
         +jn4/xLVPwn+lkbm9goa29rrHMv6hsGTeYP6ucU8D9gET5qmbIcow1CCx2a+vGV2mV
         oTp8lxApvRhtQ==
Message-ID: <71d7c940-63d5-bf65-527d-b27a8e0e5edc@collabora.com>
Date:   Fri, 18 Feb 2022 13:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 19/34] iommu/mediatek: Add a PM_CLK_AO flag for infra
 iommu
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-20-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-20-yong.wu@mediatek.com>
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

Il 17/02/22 12:34, Yong Wu ha scritto:
> The power/clock of infra iommu is always on, and it doesn't have the
> device link with the master devices, then the infra iommu device's pm
> statua is not active, thus we add A PM_CLK_AO flag for infra iommu.
> 
> The tlb operation is a bit not clear in this file, Comment them in the
> code here.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

