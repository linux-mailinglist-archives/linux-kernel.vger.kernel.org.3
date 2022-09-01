Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA675A8A79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiIABR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiIABR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:17:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A113287E;
        Wed, 31 Aug 2022 18:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77581B823CC;
        Thu,  1 Sep 2022 01:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FFBC433C1;
        Thu,  1 Sep 2022 01:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661995044;
        bh=NsH2hqW4YPpI8hSkaK5p+Ch+1t7odfDqKLN91tPnkJs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AhQiNkXZ9tQemIV7ziUfsIVAGdIlbnF7cNJ1TwUgoJi4SXJ9SkqNgrElYdf9/bP1X
         BCjoeHZT5hWNAxAhohMLIVfSqKvOjrxduv4bW266/eo7LYPuIxM4CmySqhxiA8lqQG
         IRObvh5dT3lpbPNOwfhFsSkH4F6roqxPxkA+toG0lsCEl1Gh6ZYfIyT3L8siidOqgc
         qxsGXSikfVXzlndD1dIr0GFQvqldfOW6dylsiaQJ2I5lzKA9hh9E+ztAuATswMTBRI
         ycJCUY6iMWndlkUqARVbQ4jaJLAJI844t2W2lsAELumEHwoymIXiXFAjGQUcjZxpcV
         BAAGElHq0BRmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220720102817.237483-3-angelogioacchino.delregno@collabora.com>
References: <20220720102817.237483-1-angelogioacchino.delregno@collabora.com> <20220720102817.237483-3-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195: Add reset idx for USB/PCIe T-PHY
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Wed, 31 Aug 2022 18:17:22 -0700
User-Agent: alot/0.10
Message-Id: <20220901011724.25FFBC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-07-20 03:28:17)
> Add the reset idx for the t-phy port 1, used as either USB or
> PCI-Express (secondary controller) PHY, depending on board-specific
> configuration/layout.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
