Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4B75A8A77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiIABRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiIABRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0941107C52;
        Wed, 31 Aug 2022 18:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A01461CF0;
        Thu,  1 Sep 2022 01:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADB1C433C1;
        Thu,  1 Sep 2022 01:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661995033;
        bh=aAy4vnKZ4o7EIwTguBOSNqO3XFi1b+036gmfNtJIiAc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KhCiXu5JR9rr0qm33lETd8R5q4uyvB1rwktj6Oti980coJO2RrTKnD6Q5kNnFS4u+
         fDch1+mTWDru4IW96w8DGb+MjmtJZ/Cyg8h4SkyOKEO7NHcJ8LZ+oqrgnYYlOHHPkd
         E/4EW6FvHSmjd4pe0Juvlu0u7kNEvK4heTHpNY8Uoc2hXnv9MRiLpY4o6WHbya+wGE
         WxdYFpIqKhhhxMcWqFuEx67/x7Csl2rWQQC+7peq2Hk2608fopFQM7Dvk6ZG5TkRRo
         /es9ueV+LXLaCk+0Re5JjDDpz9JbwvXquvE+QEyxWeRs2gRXspLTw1wIg1fmvKiYjT
         +LJNVmi5cw7Lg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220720102817.237483-2-angelogioacchino.delregno@collabora.com>
References: <20220720102817.237483-1-angelogioacchino.delregno@collabora.com> <20220720102817.237483-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: mt8195: Add resets for USB/PCIe t-phy port 1
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
Date:   Wed, 31 Aug 2022 18:17:11 -0700
User-Agent: alot/0.10
Message-Id: <20220901011713.9ADB1C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-07-20 03:28:16)
> Add the reset index for USBSIF P1 (T-PHY port 1), used as either USB
> or PCI-Express PHY reset.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
