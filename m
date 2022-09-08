Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC25B1B48
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiIHLWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiIHLWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:22:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A497DCEE;
        Thu,  8 Sep 2022 04:21:58 -0700 (PDT)
X-UUID: 275d55f4a7e44d4aa0f87045cdab10e6-20220908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8G3RXmk6EX/J/uFVEBqNvgPb8Qx9waaWfpLdoQyA9os=;
        b=fQzkJcAWMStV2PgW5K0hm4MnIJFjief+o/XVOZW47Bei/bwuUy4JBKAixn7dctKuXmiKUAf5CXpVaUQ9fwAX0JZYvU63sHUhbXGJMk9byaMS2XEgcvS4DEH2pw8oPP6L/X+TwfvlOOlJtaR+0HDaust8bpmbUhTQw5FTaukIvIw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:2353ecbb-4a22-47c2-9d11-249a0598772b,OB:10,
        LOB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.10,REQID:2353ecbb-4a22-47c2-9d11-249a0598772b,OB:10,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:45
X-CID-META: VersionHash:84eae18,CLOUDID:13ffcaf5-6e85-48d9-afd8-0504bbfe04cb,C
        OID:28ec86ee805f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 275d55f4a7e44d4aa0f87045cdab10e6-20220908
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 89100491; Thu, 08 Sep 2022 19:21:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 8 Sep 2022 19:21:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 8 Sep 2022 19:21:50 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <mathieu.poirier@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <bjorn.andersson@linaro.org>, <bleung@chromium.org>,
        <chrome-platform@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <dnojiri@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <gustavoars@kernel.org>,
        <keescook@chromium.org>, <krzk+dt@kernel.org>,
        <lee.jones@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <matthias.bgg@gmail.com>,
        <pmalani@chromium.org>, <robh+dt@kernel.org>,
        <sebastian.reichel@collabora.com>, <tinghan.shen@mediatek.com>,
        <weishunc@google.com>
Subject: Re: [PATCH v2 4/9] remoteproc: mediatek: Support probing for the 2nd core of dual-core SCP
Date:   Thu, 8 Sep 2022 19:17:57 +0800
Message-ID: <20220908111757.14633-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220829194247.GC2264818@p14s>
References: <20220829194247.GC2264818@p14s>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> > The mtk_scp.c driver only supports the single core SCP and the
> > 1st core of a dual-core SCP. This patch extends it for the 2nd core.
> > 
> > MT8195 SCP is a dual-core MCU. Both cores are housed in the same subsys.
> 
> s/subsys/subsystem
> 
> > They have the same viewpoint of registers and memory.
> > 
> > Core 1 of the SCP features its own set of core configuration registers,
> > interrupt controller, timers, and DMAs. The rest of the peripherals
> > in this subsystem are shared by core 0 and core 1.
> > 
> > As for memory, core 1 has its own cache memory. the SCP SRAM is shared
> 
> /the/The
> 
> > by core 0 and core 1.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  drivers/remoteproc/mtk_scp.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > index 3510c6d0bbc8..91b4aefde4ac 100644
> > --- a/drivers/remoteproc/mtk_scp.c
> > +++ b/drivers/remoteproc/mtk_scp.c
> > @@ -23,6 +23,10 @@
> >  #define MAX_CODE_SIZE 0x500000
> >  #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
> >  
> > +#define SCP_CORE_0 0
> > +#define SCP_CORE_1 1
> > +#define SCP_CORE_SINGLE 0xF
> > +
> >  /**
> >   * scp_get() - get a reference to SCP.
> >   *
> > @@ -836,6 +840,7 @@ static int scp_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	const char *fw_name = "scp.img";
> >  	int ret, i;
> > +	u32 core_id = SCP_CORE_SINGLE;
> >  
> >  	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> >  	if (ret < 0 && ret != -EINVAL)
> > @@ -851,8 +856,16 @@ static int scp_probe(struct platform_device *pdev)
> >  	scp->data = of_device_get_match_data(dev);
> >  	platform_set_drvdata(pdev, scp);
> >  
> > +	ret = of_property_read_u32_index(dev->of_node, "mediatek,scp-core", 1, &core_id);
> > +	if (ret == 0)
> > +		dev_info(dev, "Boot SCP dual core %u\n", core_id);
> 
> Why is the DT property "mediatek,scp-core" needed at all?  Since the compatible
> "mediatek,mt8195-scp-dual" has already been defined previously in this patchset,
> initialising the second core, if present, is a matter of looking at the
> compatile string. 

This idea of identify cores by the compatible looks workable.
I'll update this series at next version.
Thanks!

> 
> > +
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> > -	scp->sram_base = devm_ioremap_resource(dev, res);
> > +	if (core_id == SCP_CORE_1)
> > +		scp->sram_base = devm_ioremap(dev, res->start, resource_size(res));
> > +	else
> > +		scp->sram_base = devm_ioremap_resource(dev, res);
> > +
> 
> This looks very broken...  For this to work you would need to have two DT
> entries with the "mediatek,mt8195-scp-dual" compatible properly, one with
> "mediatek,scp-core = <&scp_dual1 0>;" and another one with "mediatek,scp-core = <&scp_dual0 1>;".
> 
> Which is also very broken...  Here you have a binding whose first argument is a
> reference to the core sibling while the second argument is a characteristic of
> the current core, which is highly confusing.
> 
> I suggest what when you see the compatible binding "mediatek,mt8195-scp", a
> single core is initialized.  If you see "mediatek,mt8195-scp-dual", both cores
> are initialized as part of the _same_ probe.
> 
> If the above analysis is not correct it means I misinterpreted your
> work and if so, a serious amount of comments is needed _and_ a very detailed
> example in "mtk,scp.yaml" that leaves no room for interpretation.
> 
> I will stop reviewing this patchset until you have clarified how this works.
> 
> Thanks,
> Mathieu

There's one problem of initializng the CORE1 using the same probe flow.
The register space of CORE0 and CORE1 are overlapped in the device node.
Both cores need to use the 'cfg' registers defined in scp yaml. 
The devm_ioremap_resource catches address overlapping and returns error when 
probing CORE1 driver.


Best regards,
TingHan

