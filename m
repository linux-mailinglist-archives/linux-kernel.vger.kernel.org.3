Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195C45A0EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiHYLGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiHYLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:06:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD6ACA2E;
        Thu, 25 Aug 2022 04:06:25 -0700 (PDT)
X-UUID: 27c4fb813392466e8f016f7ea3aad5e2-20220825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=01Nmx2oJ4z1kTa8TMnh7NdI8MATbh8efPG1hyIJFvwI=;
        b=FoPTuMNvW+7fYYjm31X5eymsW1xHriQY9KSU2TR6tKaH8xEGyslosSuPortgsfFJgaFjQ8GHOdbrrICfark5j9Mo2Gwdd8b9msiDsmK3Y3OyZeXAFmuY2rCbd2cXK/mUu7aZMzn+qX4aPL5lPto1cBjjzxAnDo1XF1JmDPl4cXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:f33e9ec0-009e-485c-a606-7605ded6ae85,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Releas
        e_Ham,ACTION:release,TS:73
X-CID-INFO: VERSION:1.1.10,REQID:f33e9ec0-009e-485c-a606-7605ded6ae85,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:73
X-CID-META: VersionHash:84eae18,CLOUDID:58c998cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:271962e93667,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 27c4fb813392466e8f016f7ea3aad5e2-20220825
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 946427092; Thu, 25 Aug 2022 19:06:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 25 Aug 2022 19:06:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 25 Aug 2022 19:06:18 +0800
Message-ID: <781356a88b502661ec23b3869679d80cf682017d.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: change compatible
 for MT8195
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     Jason-JH Lin =?UTF-8?Q?=28=E6=9E=97=E7=9D=BF=E7=A5=A5=29?= 
        <Jason-JH.Lin@mediatek.com>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>,
        "CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?=" 
        <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 25 Aug 2022 19:06:18 +0800
In-Reply-To: <f7ec45b8-ccd7-4776-0524-269e3188883d@gmail.com>
References: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
         <3ff08ae9-a4b6-2b74-23cb-69ea1d7e1033@linaro.org>
         <d5a00dc88bed1680caa8af895a1140324b9d079e.camel@mediatek.com>
         <f7ec45b8-ccd7-4776-0524-269e3188883d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-25 at 18:55 +0800, Matthias Brugger wrote:
> 
> On 25/08/2022 08:59, Bo-Chen Chen wrote:
> > On Thu, 2022-08-25 at 14:11 +0800, Krzysztof Kozlowski wrote:
> > > On 25/08/2022 08:56, Bo-Chen Chen wrote:
> > > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > > > 
> > > > For previous MediaTek SoCs, such as MT8173, there are 2 display
> > > > HW
> > > > pipelines binding to 1 mmsys with the same power domain, the
> > > > same
> > > > clock driver and the same mediatek-drm driver.
> > > > 
> > > > For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines
> > > > binding
> > > > to
> > > > 2 different power domains, different clock drivers and
> > > > different
> > > > mediatek-drm drivers.
> 
> drop clock driver example here.
> 

Hello Matthias,

Thanks for your review.
I am not sure what do you mean.
Could you explain more detailedly?

> > > 
> > > I don't see binding to different clock drivers and anyway that's
> > > not
> > > really an argument here. Please focus in description on hardware
> > > properties, IOW, are devices compatible or different. What is the
> > > incompatible difference between VDOSYS0 and 1?
> > > 
> > > Best regards,
> > > Krzysztof
> > 
> > Hello Krzysztof,
> > 
> > Thanks for yor review.
> > 
> >  From the functions perspective:
> > 
> > Hardware pipeline of VDOSYS0 has these components: COLOR, CCORR,
> > AAL,
> > GAMMA, DITHER.
> > They are related to PQ (Picture Quality) functions and they makes
> > VDOSYS0 supports PQ function while they are not including in
> > VDOSYS1.
> > 
> > Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> > component).
> > It makes VDOSYS1 supports the HDR function while it's not including
> > in
> > VDOSYS0.
> > 
> 
> Please include a description of this in the commit message.
> 

Yes, I have sent v2 and add these to commit meesage.

https://lore.kernel.org/all/20220825091448.14008-1-rex-bc.chen@mediatek.com/

BRs,
Bo-chen

> > About mediatek ETHDR, you can refer to this series:
> > 
> > 
https://lore.kernel.org/all/20220819061456.8042-2-nancy.lin@mediatek.com/
> > 
> > To summary:
> > Only VDOSYS0 can support PQ adjustment.
> > Only VDOSYS1 can support HDR adjustment.
> > 
> > Is this description ok for you?
> > If it is ok, I will put them into commit message in next version.
> > 
> > BRs,
> > Bo-Chen
> > 

