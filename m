Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7365F4F759D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiDGGJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiDGGJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:09:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB5D63BF;
        Wed,  6 Apr 2022 23:07:41 -0700 (PDT)
X-UUID: d01b459bb7f045b89b9dbb63589e500e-20220407
X-UUID: d01b459bb7f045b89b9dbb63589e500e-20220407
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 246660982; Thu, 07 Apr 2022 14:07:34 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Apr 2022 14:07:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 Apr
 2022 14:07:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 14:07:32 +0800
Message-ID: <2a271b758b83da3c93589a4390d859044d4550c5.camel@mediatek.com>
Subject: Re: [PATCH 3/3] dt-bindings: display: mediatek: Correct disp_aal
 binding for MT8192
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Yongqiang Niu =?UTF-8?Q?=28=E7=89=9B=E6=B0=B8=E5=BC=BA=29?= 
        <yongqiang.niu@mediatek.com>,
        Jason-JH Lin =?UTF-8?Q?=28=E6=9E=97=E7=9D=BF=E7=A5=A5=29?= 
        <Jason-JH.Lin@mediatek.com>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>,
        Allen-KH Cheng =?UTF-8?Q?=28=E7=A8=8B=E5=86=A0=E5=8B=B3=29?= 
        <Allen-KH.Cheng@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 7 Apr 2022 14:07:32 +0800
In-Reply-To: <e7face88-5069-c560-ad2b-a0a658fb8cef@linaro.org>
References: <20220406094654.29722-1-rex-bc.chen@mediatek.com>
         <20220406094654.29722-4-rex-bc.chen@mediatek.com>
         <e7face88-5069-c560-ad2b-a0a658fb8cef@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 22:46 +0800, Krzysztof Kozlowski wrote:
> On 06/04/2022 11:46, Rex-BC Chen wrote:
> > The driver data for MT8192 is the same with MT8183. Therefore, we
> > correct it.
> 
> Driver data is Linux implementation specific so does not really
> matter
> for bindings. Probably you want to say here that devices are fully
> compatible? If so, please rephrase it. Also remove the wording
> "correct
> it" in subject and here because there is no mistake here (at least
> you
> did not describe it) and otherwise AUTOSEL might pick it up...
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Thanks for your review.
Yes, it's not a error for dt-binding.
I will update the description in next version.

BRs,
Rex

