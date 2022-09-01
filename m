Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB75A8A68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiIABOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiIABO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:14:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D59512EC7C;
        Wed, 31 Aug 2022 18:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2432B823CB;
        Thu,  1 Sep 2022 01:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604D8C433D6;
        Thu,  1 Sep 2022 01:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661994863;
        bh=x/sWxA960MFDvZQpRTbbU9NaZ+9atYHgasHRRigNO6o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FU8R06aMjE8ZaQ5t5dDRUJU3irbyO7tVijp19Fi9Dh0YZEpASYVgmIEv41LjE96WQ
         NfASBJGKP9tTbHDHW8KY0tu7cMwRw6t9kocepRZxeSSHRNVGgIjfBpiWg+TVci46rx
         VAyKcxyv14IEPKuxI5uKmdDEqHD3C6Sd2h11uww9mK6Ff5iCLiF5GyhsscS9jON8tn
         96/fEP90ov/lISwH7L4j0gA6lFNZg6bk1GnunXTVnMmzDp6J3is3jIKy/6l37WE+Za
         q+sQF3r8MkVlpKoM3lToF2dr3b4lAg//jTHFaHRfv9nucTRD5nmQU5ym8wF9d3qG2/
         EmBrVKA0B5xrg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220629105205.173471-3-angelogioacchino.delregno@collabora.com>
References: <20220629105205.173471-1-angelogioacchino.delregno@collabora.com> <20220629105205.173471-3-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195: Add reset idx for PCIe0 and PCIe1
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        rex-bc.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Wed, 31 Aug 2022 18:14:21 -0700
User-Agent: alot/0.10
Message-Id: <20220901011423.604D8C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-06-29 03:52:05)
> Add the reset idx for PCIe P0, P1, located in infra_ao RST2 registers.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
