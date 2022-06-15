Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F754CB57
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349478AbiFOO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbiFOO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:29:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC8638E;
        Wed, 15 Jun 2022 07:29:24 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 442EB66016E6;
        Wed, 15 Jun 2022 15:29:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655303363;
        bh=9JJFUJVNM69cglqdy5kB/JmT8zdWEEfScJJyM/93r8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lx7ftiZ7fFo/I2xUSkFSy31bmj/czjjhNvJqFApLYbk3djxq0pVVM/zNIBk0NPJY6
         DGWCD8lfTk3osxb035ANBZgZqStHAEl0ldQ55BgSFvPZ23JDWX7XJtrpOh7C3OluzP
         1cL35wpEMdYbeTUpYj4oxDO+k3i1VGa9nW4NJ19q9BeIH+PZAVxW6YDvXKPIl/HYhV
         zvkrosrMjzFG++BKlYsVuTntffwPh7oX+YqhLGXkqchvM4xcrWzem0ObchqxWh06DT
         DQXlFHw5g/NogtO7tf1uVDHJ1ffK5h780d4oPXeQBDs11MpPtXeB1l1eS319kzwW5Q
         kSsB0VI2O2zcA==
Date:   Wed, 15 Jun 2022 10:29:18 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/2] MT8192 pinctrl properties adjustments
Message-ID: <20220615142918.vw4f2hrrxb2r2x6h@notapiano>
References: <20220531221954.160036-1-nfraprado@collabora.com>
 <CACRpkdYe=qhUvyCw-xKRUihWiaezaEyQdHFhPt2aD6bmkWTpBw@mail.gmail.com>
 <20220615142349.qgxsnaln7mtbhgur@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615142349.qgxsnaln7mtbhgur@notapiano>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:23:55AM -0400, Nícolas F. R. A. Prado wrote:
> On Wed, Jun 15, 2022 at 03:31:00PM +0200, Linus Walleij wrote:
> > On Wed, Jun 1, 2022 at 12:19 AM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > 
> > > The two patches in this series substitute properties in the mt8192
> > > pinctrl dt-binding for ones which have a clearer meaning and are more
> > > standardized. At this point there's no DT using the mt8192 pinctrl
> > > binding, so if such changes are to be made, they need to happen now.
> > >
> > > v1: https://lore.kernel.org/linux-mediatek/20220525155714.1837360-1-nfraprado@collabora.com/
> > >
> > > Changes in v2:
> > > - Dropped Fixes tags
> > > - Added 'if' blocks to enforce mutual exclusion of properties
> > 
> > This does not apply on the current pinctrl devel branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
> > 
> > Could you please rebase onto my branch and resend as v3?
> 
> Hi Linus,
> 
> I checked out your branch locally and was able to apply the patch cleanly. Maybe
> you haven't pushed out all your local changes to that branch yet? Otherwise let
> me know and I'll send a rebased v3 to see if it helps in some way.

Actually, I just noticed that you applied 2/2 from v1, maybe that's the reason
this v2 series isn't applying?

> 
> Thanks,
> Nícolas
> 
> > 
> > Yours,
> > Linus Walleij
