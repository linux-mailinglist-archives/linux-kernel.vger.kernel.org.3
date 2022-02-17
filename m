Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C34BAB03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbiBQU2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:28:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiBQU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:28:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58AC2E77;
        Thu, 17 Feb 2022 12:28:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE98761E0C;
        Thu, 17 Feb 2022 20:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A77C340E8;
        Thu, 17 Feb 2022 20:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129696;
        bh=YP6Tpg4F9lAg6AlLYRmupY/d97PX8JL8bzj+VrF5RCo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kYFlFRp2C1yDjZ4L6kFMYHY1kqIhrcSwxyoge3tS4O2vbSzzMS3PyJMmf2YUxXFRU
         uh35TcjTvhlsO0s1ih2H1E9GzFYv2i9oiYI2XoMUDNBmYkNpleWeXhFjL/E46wXU7s
         z2+xCrBSeSAWOaN37S5eUTBymgHXpM3tIuYNP63K2S6Yq5kT1PJzr6JPh9mJmm50Sa
         CLeunKxJpf71ZEt2AHJMWFVz7+siIKXD57a6XvG/zUrve/UqhgxkkQGKXP5ihFkdyC
         obMieA6Z/mfhwYC/JHU6RINTq1tkYde3yHBkBIuW86QTc5p248xefqJIbXv6xPtd6d
         IsTsdID0ntnrQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-27-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-27-wenst@chromium.org>
Subject: Re: [PATCH v3 26/31] clk: mediatek: mtk: Implement error handling in register APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 17 Feb 2022 12:28:14 -0800
User-Agent: alot/0.10
Message-Id: <20220217202816.50A77C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:29)
> The remaining clk registration functions do not stop or return errors
> if any clk failed to be registered, nor do they implement error
> handling paths. This may result in a partially working device if any
> step fails.
>=20
> Make the register functions return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, is done in the new error path.
>=20
> This also makes the |struct clk_data *| argument mandatory, as it is
> used to track the list of clks registered.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
