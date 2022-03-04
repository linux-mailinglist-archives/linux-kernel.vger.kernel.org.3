Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8E4CD207
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiCDKGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCDKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:06:45 -0500
X-Greylist: delayed 2718 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 02:05:58 PST
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B819F457;
        Fri,  4 Mar 2022 02:05:58 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7D451D4C; Fri,  4 Mar 2022 11:05:57 +0100 (CET)
Date:   Fri, 4 Mar 2022 11:05:56 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v5 00/34] MT8195 IOMMU SUPPORT
Message-ID: <YiHkhERbAY8oYRYw@8bytes.org>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <YhzBSsn/zUlGg5JE@8bytes.org>
 <7ba0ee87-c193-9834-d0b4-ff3e06ced82b@collabora.com>
 <5ed9278fa0b72b993512cff2316218ab88cafe50.camel@mediatek.com>
 <YiHZ4lq2QClkdyxS@8bytes.org>
 <123cb154ca0e87504c2b663ebdca2ccad967776f.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123cb154ca0e87504c2b663ebdca2ccad967776f.camel@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 05:57:19PM +0800, Yong Wu wrote:
> Thanks for this info. I will re-send this patchset after the next -rc1.
> 
> Could you help apply Dafna's patchset at this time? This patchset
> depends on it and it won't conflict with the others.

Alright, picked up Dafna's patch-set.

Regards,

	Joerg
