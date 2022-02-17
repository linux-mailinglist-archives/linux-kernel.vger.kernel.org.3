Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F354BAADD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343534AbiBQUZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:25:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343590AbiBQUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:25:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF7166E01;
        Thu, 17 Feb 2022 12:25:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38CD1B8249A;
        Thu, 17 Feb 2022 20:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7D1C340E8;
        Thu, 17 Feb 2022 20:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129529;
        bh=5GCoE9LSgyVtdfoY5AYvI9+Rwt6pV+Ejt4MpLecQ8sc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uh5X0a5GPM7I4pW1/PwV0z0L7XdhkW9X5C2O4Bqxj6I1AEHE+T/prN4evQEzaiDbP
         IYyoeLXjGbNZyaVhDK0vBgYY7/IluySi98IhgNpR5XYrL/Q+1+oBOfeyRvesaGKTnD
         BaaR/yNvRCSYRWpI4U+qCvs0Ycdbh+LOptgT7sHV3Z+SoXi+91kdndl7PdTrVDvH4v
         Vaw4hMyi3vHxjzPUmEH9KITmKD/vQ41lVzzLG9i5nwx8a9vRjMSGP7PbKVQyhAKzZq
         tcKtjQPEPxkKDOyGpztDyu4AyLuX/Kf4arepO5DQSWZttkOsZWTwJ3oUdEX/LlXMS5
         f8BbBpoE/cWug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-14-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-14-wenst@chromium.org>
Subject: Re: [PATCH v3 13/31] clk: mediatek: pll: Implement unregister API
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
Date:   Thu, 17 Feb 2022 12:25:28 -0800
User-Agent: alot/0.10
Message-Id: <20220217202529.AE7D1C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:16)
> The PLL clk type within the MediaTek clk driver library only has a
> register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
>=20
> Add a matching unregister function for the PLL type clk.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
