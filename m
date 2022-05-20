Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7D52E144
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbiETAhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbiETAhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACF131281;
        Thu, 19 May 2022 17:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E15B661011;
        Fri, 20 May 2022 00:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42193C385B8;
        Fri, 20 May 2022 00:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653007068;
        bh=A1S6mg9OBT6AKltZiiqdbCazkwAG61jCviwhpWl8/IQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ueLxfJiMsabO3DZ1zq2+xp/0ZP75rmH59UF+XVeRNfAYoWFaiIXmfLLsGlSX16SA7
         g+mK75hgrGJOty7Y4t9FmGx+zjcCZ8fQCo+y3wxiMW/nNfi/Yxdyfb7l6evmz54FML
         ZaUcJtpHEH1kYlGRBQ/LKOcWV1I+c3fc94QV2LnA34TZiOLtVimDcgO7VYx7k0l5VC
         BV2Zat1lkm+I+bvjo6pwRbUcBZoqm04Mjm10NQ4puIcyrZ2MMfNFl4hZP3+A7CBqs6
         PlcsyeM3GRpoXZLCIqFmxpIZmbxTler+cGGZsTIs2EDgRL2fJvNwT5yjDa7T3JDxwV
         HuSM8FsjT7V1A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220519071610.423372-6-wenst@chromium.org>
References: <20220519071610.423372-1-wenst@chromium.org> <20220519071610.423372-6-wenst@chromium.org>
Subject: Re: [PATCH v3 5/5] clk: mediatek: mt8173: Switch to clk_hw provider APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 19 May 2022 17:37:46 -0700
User-Agent: alot/0.10
Message-Id: <20220520003748.42193C385B8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-05-19 00:16:10)
> As part of the effort to improve the MediaTek clk drivers, the next step
> is to switch from the old 'struct clk' clk prodivder APIs to the new
> 'struct clk_hw' ones.
>=20
> The MT8173 clk driver has one clk that is registered directly with the
> clk provider APIs, instead of going through the MediaTek clk library.
>=20
> Switch this instance to use the clk_hw provider API.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
