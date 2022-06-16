Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2454D893
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348431AbiFPCos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFPCop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:44:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7217393FF;
        Wed, 15 Jun 2022 19:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 844B8B82268;
        Thu, 16 Jun 2022 02:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1337EC3411E;
        Thu, 16 Jun 2022 02:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655347482;
        bh=+tybOX2ZUq1lkkdmlC+t9c+9BDKLoV6q0HGEOURZYcw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZzFIFIqi1MdnlLbUz0m/h8wJ/XgZtDNARx+EJ10xb7IC3HXW7ovy1bUvGYEmCIvQk
         buhDcMgynemjSh/s3EkbL6E2OiHedz6cR6iaMGcdTsC1n7UHuYa3NnnIlN6r34Pfgy
         rpOZZx7bv4DgRQsXTgtzKa4QhZ0coTpYKwHkkGWpYT6FR/bHLEAudLQ+Hf/9wHyINR
         yNFNRrBe8M5dJ4q3uSPY8rZe841F5ZXnju8DuzM0RHy83Kqb7Yf+9rtYDvZoIHu3qa
         N4AlMW2N+QXY+alSqJm+/onS7eoX5aA2nyPfaS5y7BWTmQnpA5IhhFWNOMbTatXE6i
         k/adjTWR9u5Sw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220614091020.21472-1-angelogioacchino.delregno@collabora.com>
References: <20220614091020.21472-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] clk: mediatek: clk-mt8195-vdo0: Set rate on vdo0_dp_intf0_dp_intf's parent
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Wed, 15 Jun 2022 19:44:40 -0700
User-Agent: alot/0.10
Message-Id: <20220616024442.1337EC3411E@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-06-14 02:10:20)
> Add the CLK_SET_RATE_PARENT flag to the CLK_VDO0_DP_INTF0_DP_INTF
> clock: this is required to trigger clock source selection on
> CLK_TOP_EDP, while avoiding to manage the enablement of the former
> separately from the latter in the displayport driver.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Any Fixes tag?
