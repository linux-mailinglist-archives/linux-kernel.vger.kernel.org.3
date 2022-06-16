Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0869054D797
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357246AbiFPB4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357584AbiFPB4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:56:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E80590BD;
        Wed, 15 Jun 2022 18:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CBF6B8216C;
        Thu, 16 Jun 2022 01:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA74BC3411E;
        Thu, 16 Jun 2022 01:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344563;
        bh=lXVq+gEWnI1UliJJ8cBU8oCRyLrcMuv/4bp+BYrgWDI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hpe9fAsZEarEMYmYXhBOQTGz9DwY/naeoXAe90YGb799P6k+jVVEumWMtjh2BXBLG
         nvoy4rVhcKPH87IRDuCeq9SZZZDorNFzP1PITHwRxdEcPS29UStnshtMMNi1k1QjAZ
         PRNT1Kp4Ie2r4jzIjeyznQ4e6N4MIe0GQ3z63Ha8Z4Gehw08bKyWrhylP3j8H+RmfR
         VY8P0MVP1n7zwvyM0pR7tmB6WLaBAE2EdqRTs5X3kUdzFMl9RA2qD1mPVN4Yl7KJEQ
         REBfP/urP/rpqV7tWxH2fi6FA/I++w5r+LVoj1SyVG7whz3L6ADiBkjqUhj690tHIV
         7m+HfBSUAPxCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-20-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-20-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 19/19] clk: mediatek: reset: Add infra_ao reset support for MT8186
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
Date:   Wed, 15 Jun 2022 18:55:59 -0700
User-Agent: alot/0.10
Message-Id: <20220616015602.EA74BC3411E@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:46)
> The infra_ao reset is needed for MT8186.
> - Add mtk_clk_rst_desc for MT8186.
> - Add register reset controller function for MT8186 infra_ao.
> - Add infra_ao_idx_map for MT8186.
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
