Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8874BAACC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiBQUWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:22:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245755AbiBQUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:21:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F111C0C;
        Thu, 17 Feb 2022 12:21:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63747B82486;
        Thu, 17 Feb 2022 20:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A2CC340E8;
        Thu, 17 Feb 2022 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129297;
        bh=rjFKmucc+DAtHD3oHlBzYPq2Ot0rubSN96z3IT6lx90=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z6TkMDzm8T95QmTmyb6g8wYp8IdqR4ThI6qvPUDQGpkNHq81Cx3z0SMqPFORJ8i2+
         FS8LBJ1MbtMZFEsshmUzDaXLEx1IhnsVRHTIy5CPbKZaCfiIAC+AvxZNLL9qjtIzL6
         5PHbETnppVeaLPtExpbhlG66VJPnLFYufVFtCJ2GK0Bp46rhVXjoEUDpvgXZkvonxs
         BF9PLfS0ntgKFKaQ54dfR3cCTv69opGs2nSEITxV0kq7aiASiTtQKNaWp1kWD8eYMg
         NTrfGRWa3AZdwwfV+kowwlTcaIHLRjHYHuQ+3cOrl94MMNuYLZxV24TEgjFx129JM8
         2KnTmgLWe42zA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-8-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-8-wenst@chromium.org>
Subject: Re: [PATCH v3 07/31] clk: mediatek: cpumux: Internalize struct mtk_clk_cpumux
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
Date:   Thu, 17 Feb 2022 12:21:35 -0800
User-Agent: alot/0.10
Message-Id: <20220217202137.19A2CC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:10)
> struct mtk_clk_cpumux is an implementation detail of the cpumux clk
> type, and is not used outside of the implementation.
>=20
> Internalize the definition to minimize leakage of details and shrink
> the header file.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
