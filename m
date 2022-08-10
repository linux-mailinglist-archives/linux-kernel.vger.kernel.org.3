Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8958EC94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiHJM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiHJM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:58:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA760514;
        Wed, 10 Aug 2022 05:58:21 -0700 (PDT)
X-UUID: f4ae14d8924147fcb4d71833793779cf-20220810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=B9CRG8RodOdNa8sKrD7vJYhPkQF90ZulAoME56gZSvc=;
        b=fJN17/IfIthix9/kS2nJdk17JO/HkWSBjFIBQvOitteECZOcKkV3ZUf8RWNvNAZu5R/zX2B3TZ3dtS3kjcnRJ/CVrDxcbO3Gcko3tt8luILGL0zmOBiD0FWDi7Ai5SOfeDRsQF9hdktTYaFifWwEdIGu35+WWj9idGbj1DF7Flk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:88454cc2-1895-4197-bab6-cde0451a366a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:7301effc-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f4ae14d8924147fcb4d71833793779cf-20220810
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 512899187; Wed, 10 Aug 2022 20:58:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 10 Aug 2022 20:58:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Aug 2022 20:58:15 +0800
Message-ID: <6271732eb27824c5b841760243738ceb062f4c4a.camel@mediatek.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mediatek: watchdog: Fix compatible
 fallbacks and example
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 10 Aug 2022 20:58:15 +0800
In-Reply-To: <20220808170355.c2ih3xwqxlddsal7@notapiano>
References: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
         <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
         <CAGXv+5HXwVpaJPV-4Z6qw14xZzEkx_E7dVks6-GBa7bQyN8hCg@mail.gmail.com>
         <5dac39d1-3b42-40e9-5693-0c127e8c689a@gmail.com>
         <0fadcd9f50d49ecbb329e76a9ceb6ee689648955.camel@mediatek.com>
         <20220808170355.c2ih3xwqxlddsal7@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nícolas,

On Mon, 2022-08-08 at 13:03 -0400, Nícolas F. R. A. Prado wrote:
> Hi,
> 
> On Wed, Aug 03, 2022 at 05:23:57PM +0800, Allen-KH Cheng wrote:
> > Hi Chen-Yu and Mathias,
> > 
> > Sincere apologies for the delayed response.
> > 
> > On Tue, 2022-08-02 at 13:04 +0200, Matthias Brugger wrote:
> > > 
> > > On 01/08/2022 11:29, Chen-Yu Tsai wrote:
> > > > On Thu, Jul 21, 2022 at 10:50 AM Allen-KH Cheng
> > > > <allen-kh.cheng@mediatek.com> wrote:
> > > > > 
> > > > > The watchdog timer of mt8186. mt8195 and mt7986 have their DT
> > > > > data.
> > > > > We should not use 'mediatek,mt6589-wdt' as fallback.
> > > > > 
> > > > > For mediatek,wdt example of mt8183, We remove
> > > > > mediatek,mt6589-wdt 
> > > > > fallback.
> > > > 
> > > > I think this needs some more information.
> > > > 
> > > > Right now on the kernel side, mt6589-wdt provides just watchdog
> > > > support.
> > > > The SoC-specific compatibles that are touched by this patch
> > > > provide
> > > > reset
> > > > controls in addition to the standard watchdog, which remains
> > > > the
> > > > same.
> > > > 
> > > > If that is the case, then the fallback compatibles are correct.
> > > > A
> > > > fallback
> > > > says that the new hardware is compatible with some older
> > > > hardware,
> > > > and
> > > > can be run with the driver supporting that older hardware,
> > > > likely
> > > > with
> > > > reduced functionality.
> > > > 
> > > 
> > > My understanding is, that we add a fallback because although at
> > > the
> > > time we 
> > > entered the compatible, the functionality of the device is the
> > > same
> > > as the 
> > > fallback. Nonetheless we add a compatible specific for the device
> > > in
> > > case in the 
> > > future we realize that the device has some functionality that is
> > > not
> > > and can not 
> > > be covered by the fallback.
> > > 
> > > This is the case here. Actually adding the fallback in the first
> > > place was 
> > > wrong, because the driver since ever supports the extra function
> > > for
> > > the device, 
> > > the reset.
> > > 
> > > So this is a mere cleanup of the binding to reflect what was
> > > always
> > > present in 
> > > the driver.
> > > 
> > > Regards,
> > > Matthias
> > > 
> > 
> > mt6589-wdt dosen't contains a reset control for other modules, like
> > chen-yu mention "mt6589-wdt provides just watchdog support."
> > 
> > For instance, there is a reset control in mt8195-wdt and we have a
> > DT
> > data to define its reset number of TOPRGU. I thought it's better
> > not
> > use mt6589-wdt as fallback.
> > 
> > Please let me know if this works and if you have any suggestions or
> > comments.
> 
> The only practical usecase that I can think of that relies on keeping
> the
> fallback compatibles is using the current DT with an older kernel
> that didn't
> yet support the specific watchdog compatibles. In this case, dropping
> the
> fallback compatibles would make the watchdog not work at all in such
> a kernel.
> 
> I'm not sure how relevant/common of a usecase that would be, but
> maybe it's
> worth considering given that the advantage of removing the fallback
> compatible
> is purely aesthetic?
> 
> Thanks,
> Nícolas
> 

Thanks for your comments.

I agree the advantage of patch is aesthetic. Since I also want to send
another "watchdog: Convert binding to YAML" PATCH, it's better let all
wdt compatibles in the binding match the contents of mtk_wdt_dt_ids in
drivers/watchdog/mtk_wdt.c

static const struct of_device_id mtk_wdt_dt_ids[] = {
	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
	{ .compatible = "mediatek,mt6589-wdt" },
	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
	{ /* sentinel */ }
};

We have "mediatek,mt8186-wdt" "mediatek,mt8195-wdt" and
"mediatek,mt7986-wdt" now and they have their DT data for the reset
control.

It's weird and unuseful to add "mediatek,mt6589-wdt" as fallback. 


Please kindly let me know if I missed anything

BRs,
Allen

> > 
> > Thanks,
> > Allen
> > 
> > > > As an example, if mt8195-wdt is backward compatible with
> > > > mt6589-
> > > > wdt,
> > > > then it should run as mt6589-wdt, and would just be missing new
> > > > functionality, in this case the reset controls.
> > > > 
> > > > So either mt6589-wdt also contains a reset control that is not
> > > > the
> > > > same
> > > > as the other newer chips, or has some other functionality that
> > > > the
> > > > other
> > > > chips contain, and justifies the removal of the fallback, or
> > > > this
> > > > patch
> > > > is incorrect. Note that mt2701-wdt and mt762*-wdt are still
> > > > listed
> > > > as
> > > > compatible with mt6589-wdt. So I think a better explanation is
> > > > required.
> > > > 
> > > > 
> > > > Regards
> > > > ChenYu
> > > > 
> > > > 
> > > > > Fixes:a45b408a020b("dt-bindings: watchdog: Add compatible for
> > > > > MediaTek MT8186")
> > > > > Fixes:b326f2c85f3d("dt-bindings: watchdog: Add compatible for
> > > > > Mediatek MT8195")
> > > > > Fixes:41e73feb1024("dt-bindings: watchdog: Add compatible for
> > > > > Mediatek MT7986")
> > > > > Fixes:f43f97a0fc0e("dt-bindings: mediatek: mt8183: Add
> > > > > #reset-
> > > > > cells")
> > > > > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > > > > Reviewed-by: AngeloGioacchino Del Regno <
> > > > > angelogioacchino.delregno@collabora.com>
> > > > > ---
> > > > >   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 9
> > > > > ++++-----
> > > > >   1 file changed, 4 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/watchdog/mtk-
> > > > > wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-
> > > > > wdt.txt
> > > > > index 762c62e428ef..67ef991ec4cf 100644
> > > > > --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > > > > +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > > > > @@ -14,12 +14,12 @@ Required properties:
> > > > >          "mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for
> > > > > MT7622
> > > > >          "mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for
> > > > > MT7623
> > > > >          "mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for
> > > > > MT7629
> > > > > -       "mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for
> > > > > MT7986
> > > > > +       "mediatek,mt7986-wdt": for MT7986
> > > > >          "mediatek,mt8183-wdt": for MT8183
> > > > > -       "mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for
> > > > > MT8186
> > > > > +       "mediatek,mt8186-wdt": for MT8186
> > > > >          "mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for
> > > > > MT8516
> > > > >          "mediatek,mt8192-wdt": for MT8192
> > > > > -       "mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for
> > > > > MT8195
> > > > > +       "mediatek,mt8195-wdt": for MT8195
> > > > > 
> > > > >   - reg : Specifies base physical address and size of the
> > > > > registers.
> > > > > 
> > > > > @@ -32,8 +32,7 @@ Optional properties:
> > > > >   Example:
> > > > > 
> > > > >   watchdog: watchdog@10007000 {
> > > > > -       compatible = "mediatek,mt8183-wdt",
> > > > > -                    "mediatek,mt6589-wdt";
> > > > > +       compatible = "mediatek,mt8183-wdt";
> > > > >          mediatek,disable-extrst;
> > > > >          reg = <0 0x10007000 0 0x100>;
> > > > >          interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
> > > > > --
> > > > > 2.18.0
> > > > > 
> > > > > 
> > 
> > 

