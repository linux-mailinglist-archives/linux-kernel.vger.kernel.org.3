Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474274BAABE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbiBQUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:21:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiBQUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:20:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0BBAB80;
        Thu, 17 Feb 2022 12:20:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3F7661DAD;
        Thu, 17 Feb 2022 20:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D68C340E8;
        Thu, 17 Feb 2022 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129243;
        bh=sx8mrhtZybxoA/xwGIindVNL5oiE54Uyr9+FkKocTuA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dBsuc10E9HHQ0xqa/0XRq9MtCU3Pk9Re+kV/JRIiSXh1y3Png2mNS/DXGUmCx02YG
         ULVwBZaBf5XhRbjnTVoRlrV6P3Z8IaKnthq4OkrI9/S54Lv8Ky1tIPN1i8DiWYU9pT
         2C/nsy8ML3cxCaDm1xrJbuCmKDAJ/ZtjUxEEhIc0q9f8uJzjPi+uuldVIYxJ21qjMx
         v06fnNvn98nUSEqh2XYwjsB11pS22npKW302AyA1+H/f1Dbv2oqJS+chwKI7AZGXAy
         ldB8yxRpX5ktnRnZFrxnqVtvWoiCBTdm7zNjGyGJM9hE2uzbgVed0BacVnavlTfuy3
         5fLHG12kegJgg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-3-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-3-wenst@chromium.org>
Subject: Re: [PATCH v3 02/31] clk: mediatek: gate: Consolidate gate type clk related code
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
Date:   Thu, 17 Feb 2022 12:20:41 -0800
User-Agent: alot/0.10
Message-Id: <20220217202042.F1D68C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:05)
> Right now some bits of the gate type clk code are in clk-gate.[ch], but
> other bits are in clk-mtk.[ch]. This is different from the cpumux and
> mux type clks, for which all of the code are found in the same files.
>=20
> Move the functions that register multiple clks from a given list,
> mtk_clk_register_gates_with_dev() and mtk_clk_register_gates(), to
> clk-gate.[ch] to consolidate all the code for the gate type clks.
>=20
> This commit only moves code with minor whitespace fixups to correct
> the code style. Further improvements, such as internalizing various
> functions and structures will be done in later commits.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
