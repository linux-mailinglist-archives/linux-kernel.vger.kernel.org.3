Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056995A8A70
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiIABQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiIABQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:16:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D7ADFB7A;
        Wed, 31 Aug 2022 18:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11F64B823CD;
        Thu,  1 Sep 2022 01:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E4DC433C1;
        Thu,  1 Sep 2022 01:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661994972;
        bh=Bp9MG1Ufb7Tzj1XyXFNI9+qa4E+OkXzO9lRH/DnXEkM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Eww2IZWYJK0KQ89Rl0O4KNo0FuXOCDYQNFCTGaxaQiQ1wYDytuOBRMb51k/jbBOsI
         +nNx8n9sO2bz6btRBxbQQA10qxOSDfv+olBWPVRtO8gK+wdH+rcM5AuyJvKnkNBgXY
         n9FPXJxHgSdol014iSwZs1r9x83O0HNZlQ1dUsLV1fjyXrKUCbeuHSRON/tN2Kd7Py
         NEhd6tpNL/YwCazqi66bl05FH4cgPZX4deDYNGVX5bBZx962dRwsgspsWMW13+S4B4
         qZeFntY1S9N2qy3AMjVsBAFVp71qg+RGo39+WUXJzAUoC3H/DCcNzRPL4LAEvHwfGR
         rFiT6Yt2gV2cg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220719093316.37253-1-angelogioacchino.delregno@collabora.com>
References: <20220719093316.37253-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] clk: mediatek: mt8195-infra_ao: Set pwrmcu clocks as critical
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        wenst@chromium.org, chun-jie.chen@mediatek.com,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Wed, 31 Aug 2022 18:16:10 -0700
User-Agent: alot/0.10
Message-Id: <20220901011612.C4E4DC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-07-19 02:33:16)
> The pwrmcu is responsible for power management and idle states in SSPM:
> on older SoCs this was managed in Linux drivers like sspm/mcupm/eemgpu
> but, at least on MT8195, this functionality was transferred to the ATF
> firmware.
> For this reason, turning off the pwrmcu related clocks from the kernel
> will lead to unability to resume the platform after suspend and other
> currently unknown PM related side-effects.
>=20
> Set the PWRMCU and PWRMCU_BUS_H clocks as critical to prevent the
> kernel from turning them off, fixing the aforementioned issue.
>=20
> Fixes: e2edf59dec0b ("clk: mediatek: Add MT8195 infrastructure clock supp=
ort")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
