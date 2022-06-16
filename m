Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E892154D78C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348001AbiFPBzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbiFPBzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE85C17E0E;
        Wed, 15 Jun 2022 18:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC8561D1D;
        Thu, 16 Jun 2022 01:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764F5C3411A;
        Thu, 16 Jun 2022 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344509;
        bh=s6HStFs4/6AgD9BgAuBbABMWYGIbMoeJt428xBib/yY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pjLiWRo4h7HB+5bzzc2YSC8Iw6AayXcNAYPaEQ7mYf0ob+I0mKI/pnmwVPK1lXQIl
         sXdE5bEfCdOBkwGFEaWLl+oTitkaSrp2dpF5IKR0HUtYVVEzoxYwrtuEsRqt41Jgyc
         RTaYnv/gIKi1AkO2fOfOXcJxdw8s2Xt54byEIatWkgBHNXe7NupaZKAJqiuT77Ktye
         4nG05Ne00Ps/0+HWCGsYtASlNmcZoTpFqTGMvK188DrpLbrfmk5PSe7v+4a1AGlS9m
         1pC7EHUGZOlERmHnbLd1viGO1P8kPbj1nebbzmRv8T4DbFUgxOxGuVeUzHKEEuAiew
         nJ5/xYtLg3uKA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-15-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-15-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 14/19] clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Wed, 15 Jun 2022 18:55:06 -0700
User-Agent: alot/0.10
Message-Id: <20220616015509.764F5C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:41)
> The infra_ao reset is needed for MT8192 and MT8195.
> - Add mtk_clk_rst_desc for MT8192 and MT8195
> - Add register reset controller function for MT8192 infra_ao.
> - Move definition of infra reset from cl-mt8183.c to reset.h
>   because it's the same definition with MT8192 and MT8195.
> - Add new definition of infra reset_4 for MT8192 and MT8195.
> - Add infra_ao_idx_map for MT8192 and MT8195.
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> [N=C3=ADcolas: Test for MT8192]
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
