Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6574BAAC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbiBQUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:21:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbiBQUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:21:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4BB1662EA;
        Thu, 17 Feb 2022 12:20:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8827B82486;
        Thu, 17 Feb 2022 20:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B4BC340E8;
        Thu, 17 Feb 2022 20:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129253;
        bh=HrP+7GNrdhbAXiZ8Uit4X+HY/MnbUJRngC8GMYY9pyE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Bo5FcVVvDIJNq4n943F2NoBLSM4Bzx+1wg1iuo6jCDd45BFqKHRSrfVAycJsZO2fQ
         uyV+KbTgd3JcMG7qnJgN6VKt64j6w5NghcWuiOpnhQlb0AMFuvTOtVOQz+PEuRvsDS
         73gGbaum2z822iJjEVXY7HBF0XqO969HKBKbupSbffj3TDUaMNSxyUU/BLPlir7Ud/
         TBgx3d53MBDJZWyX7eBrgRDRG3J1Smwp9QyMXZOmQgnMHF3yAcqiUxDOzw5aQkM11b
         k/2qSPoq7tYCGFBkVrCCdSYOhrTmekw1qZC5R6VlWt3ajMKWamryRBo038vX7SE+E7
         WuCpTMk12I0yA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-4-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-4-wenst@chromium.org>
Subject: Re: [PATCH v3 03/31] clk: mediatek: gate: Internalize clk implementation
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
Date:   Thu, 17 Feb 2022 12:20:51 -0800
User-Agent: alot/0.10
Message-Id: <20220217202053.61B4BC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:06)
> struct mtk_clk_gate and mtk_clk_register_gate() are not used outside of
> the gate clk library. Only the API that handles a list of clks is used
> by the individual platform clk drivers.
>=20
> Internalize the parts that aren't used outside of the implementation.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
