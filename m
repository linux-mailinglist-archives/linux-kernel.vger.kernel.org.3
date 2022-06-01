Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4043E539CA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbiFAFdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349634AbiFAFdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:33:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C936259313;
        Tue, 31 May 2022 22:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48569CE19F7;
        Wed,  1 Jun 2022 05:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DB0C385A5;
        Wed,  1 Jun 2022 05:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654061574;
        bh=iQER32CU/sUTRxMxTf/FVOO/vpKLn4BYxmNWOMU1Q5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=py1GvzmMMyjfRNmngOj/y8UvpccVWhIIU9HkNDRPc+VIpmfUT5xzceY16Ml6a7YF8
         JZpnQQC9kuU7m1I0xBjJK4+y2sjajb4kmqbZnZWACbXOvqMG2+ClNL6hOYaY/IgsQr
         ZHnVKFYVypiskCsbyu8HcWz7G5bKq4uz1XcLLD4a4gHvRWsGOfDyA8BBRd7T+fips4
         k2/fMrgoYK02fldXgqKnRL45L6ESGmYzNZNy+aQOj8V/LlviXvkKL8fkk8ICsnENsO
         +PjLJ5Cc0sbGWQq1xnuVlCJPYgmKiyf3RHwHKcKEnifcbRKy0FlAMHIx3mCiO+8RBY
         9EtQrISZve5rQ==
Date:   Wed, 1 Jun 2022 11:02:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wei-Shun Chang <weishunc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
Subject: Re: [PATCH v9 0/2] phy: mediatek: Add PCIe PHY driver
Message-ID: <Ypb6AS6oj2en/Roi@matsya>
References: <20220520064920.27313-1-jianjun.wang@mediatek.com>
 <96f7cc90171bb6e088ce0ed88e10ad14f06a98bb.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f7cc90171bb6e088ce0ed88e10ad14f06a98bb.camel@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-22, 10:21, Jianjun Wang wrote:
> Hello Maintainers,
> 
> Gentle ping for this patch series, if there is anything I can do to get
> these patches merged, please let me know.

Patience my friend patience. This was received very late in cycle and I
will review after merge window closes..


> 
> Thanks.
> 
> On Fri, 2022-05-20 at 14:49 +0800, Jianjun Wang wrote:
> > These series patches add support for PCIe PHY driver on MediaTek
> > chipsets.
> > 
> > Changes in v9:
> > 1. Check if the return value is -ENOMEM when reading efuse data
> > fails.
> > 
> > Changes in v8:
> > 1. Use "device_property_present()" to increase human readability;
> > 2. Use "GPL" as recommended in commit bf7fbeeae6db ("module: Cure
> >    the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity").
> > 
> > Changes in v7:
> > 1. Add bitfield.h header to fix the build error on non-arm64
> > platforms.
> > 
> > Changes in v6:
> > 1. Remove unnecessary header files;
> > 2. Use FILELD_PREP in bitfield.h to set value.
> > 
> > Changes in v5:
> > 1. Fix typo in kerneldoc: "eFues" => "eFuse".
> > 
> > Changes in v4:
> > 1. Fix no return when calling dev_err_probe.
> > 
> > Changes in v3:
> > 1. Add introductions for structure members;
> > 2. Add SoC dependent data;
> > 3. Dynamically allocate efuse data;
> > 4. Check return value if it's an -EPROBE_DEFER.
> > 
> > Changes in v2:
> > 1. Add specific compatible name;
> > 2. Read NVMEM data at probe time;
> > 3. Fix typos.
> > 
> > Jianjun Wang (2):
> >   dt-bindings: phy: mediatek: Add YAML schema for PCIe PHY
> >   phy: mediatek: Add PCIe PHY driver
> > 
> >  .../bindings/phy/mediatek,pcie-phy.yaml       |  75 +++++
> >  drivers/phy/mediatek/Kconfig                  |  11 +
> >  drivers/phy/mediatek/Makefile                 |   1 +
> >  drivers/phy/mediatek/phy-mtk-pcie.c           | 267
> > ++++++++++++++++++
> >  4 files changed, 354 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> >  create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> > 

-- 
~Vinod
