Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F671599391
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbiHSD3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbiHSD2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:28:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA92BC6;
        Thu, 18 Aug 2022 20:28:37 -0700 (PDT)
X-UUID: 52e34e004c58493eb69fe592aa72ebac-20220819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=m7agB2hnFewpjax4kbphsD93u3QsGRdWR8JFRIQ77D8=;
        b=kqrMB8i9hhDwuG310TE7t18O/vC2W7nKvv9EuHW+XU+4/UcMH+OdJ88/Qj4GbtW/YpwreJH1SLaIshEp1fDgxiHoLboGp3/bHQMnNfMkWJ9aQN7kYA/FA1rb+7hb0U0eWRTWpmcRmstgcvXug/ZvRsuCfBt63/eVyagyDNmiGTM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:76241349-1cda-41de-bb1f-7d53cf221680,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:1f8c1a9d-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 52e34e004c58493eb69fe592aa72ebac-20220819
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 296181039; Fri, 19 Aug 2022 11:28:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 19 Aug 2022 11:28:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 19 Aug 2022 11:28:31 +0800
Message-ID: <726ec17f1b8d42f7ec9858a54ee952cb53f03188.camel@mediatek.com>
Subject: Re: [PATCH 3/3] dt-bindings: nvmem: mediatek: efuse: Add support
 for MT8188
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 19 Aug 2022 11:28:31 +0800
In-Reply-To: <8ab34dd4-ca5a-2824-ccbf-867996ac6536@linaro.org>
References: <20220715120114.4243-1-johnson.wang@mediatek.com>
         <20220715120114.4243-3-johnson.wang@mediatek.com>
         <8ab34dd4-ca5a-2824-ccbf-867996ac6536@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-17 at 13:21 +0100, Srinivas Kandagatla wrote:
> 
> On 15/07/2022 13:01, Johnson Wang wrote:
> > Add compatible for MT8188 SoC.
> > 
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > ---
> > This patch is based on "linux-next"[1].
> > [1]
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git__;!!CTRNKA9wMg0ARbw!yz8fBHH39-ntsRnAlXZfmS1k9PoKMtITUk-DhcvGQJOJSu9HP70OmFoCYMfvxnjWw4Ql$
> >  
> > ---
> 
> Applied thanks,
> 
> --srini
> >   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > index b5a1109f2ee1..75e0a516e59a 100644
> > --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > @@ -30,6 +30,7 @@ properties:
> >                 - mediatek,mt8173-efuse
> >                 - mediatek,mt8183-efuse
> >                 - mediatek,mt8186-efuse
> > +              - mediatek,mt8188-efuse
> >                 - mediatek,mt8192-efuse
> >                 - mediatek,mt8195-efuse
> >                 - mediatek,mt8516-efuse

Hi Srinivas,

Just a gentle ping on this.
It seems that this patch hasn't been applied into [1].

If you have any concern about this patch, please let me know.

Thanks.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git

BRs,
Johnson Wang

