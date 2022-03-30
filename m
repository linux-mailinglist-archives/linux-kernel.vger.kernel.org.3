Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BA84EB88D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242157AbiC3C5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiC3C5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:57:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8EB6C;
        Tue, 29 Mar 2022 19:56:03 -0700 (PDT)
X-UUID: efa09f0674934a8abba41ee778363274-20220330
X-UUID: efa09f0674934a8abba41ee778363274-20220330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 525386966; Wed, 30 Mar 2022 10:55:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Mar 2022 10:55:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 10:55:56 +0800
Message-ID: <ed60e1a69b4b61008b2bc76cfed93f46ac5efa2b.camel@mediatek.com>
Subject: Re: [PATCH v12 1/3] dt-bindings: mmc: mtk-sd: fix yamllint error
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>
Date:   Wed, 30 Mar 2022 10:55:56 +0800
In-Reply-To: <97f2b11d-15c7-d28e-f7b5-e65f2f333580@collabora.com>
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
         <20220329114540.17140-2-tinghan.shen@mediatek.com>
         <97f2b11d-15c7-d28e-f7b5-e65f2f333580@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Tue, 2022-03-29 at 14:47 +0200, AngeloGioacchino Del Regno wrote:
> Il 29/03/22 13:45, Tinghan Shen ha scritto:
> > Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> >    54:81     error    line too long (95 > 80 characters)  (line-length)
> > 
> 
> I can't reproduce this error that you're getting... this commit is not
> necessary, as the .yamllint file in the kernel allows a maximum line-length
> of 110 characters.
> 
> rules:
>    line-length:
>      # 80 chars should be enough, but don't fail if a line is longer
>      max: 110
> 
> 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/.yamllint?h=next-20220329__;!!CTRNKA9wMg0ARbw!1L9icT80FdI9EYV81qRGpzbEvV1NFP_pwk8YABV0eIiRf2ppttnPlRfu5aXEUsxODiE$
>  
> 
> Please drop this commit.

Thank you for your feedback.

I figured out why I have this error...
It's because I do the yamllint outside of the bindings folder and not specify the yamllint config
file.

I'll drop this at next version.

Best regards,
Tinghan
> 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)

