Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC752E13D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbiETAhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbiETAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:37:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C112FECF;
        Thu, 19 May 2022 17:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F4E1B82953;
        Fri, 20 May 2022 00:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5182C385AA;
        Fri, 20 May 2022 00:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653007021;
        bh=gvgyiR4nm40hdy8JYiEAaMyY8X8o/o9DlmkPBGAkQUU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WudWJUfXP+mktm9kZee6vsDLSvX5C1a5PoJCzx2p/xCfk27AqCC9Ay/qZU/6sTHk3
         Cmyje746N9XWWFpxjVbRPERDRCAhDIu0TDTbHyhjI1g1FjealQZ/170sPl0JpHokwL
         x/S98/tyrueVqzyT5cseyROcdRZ7DSEWWypejkQazOBVQQowQfW0GliUMZwTvzxem3
         jQF6t3xm6z6iebvvreCki2OY+PzazDYHEqXadJtkMCIWSEBe9O5Pt9sOeS/cdqvXcb
         cgUtCHizBZr9TZR3wK92CjCV0/fstJEeeI/4mmrrFSfJFX4OcmCBkwMaa6X7BpJiDH
         tn1wdx7RepjNg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220519071610.423372-2-wenst@chromium.org>
References: <20220519071610.423372-1-wenst@chromium.org> <20220519071610.423372-2-wenst@chromium.org>
Subject: Re: [PATCH v3 1/5] clk: mediatek: Make mtk_clk_register_composite() static
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 19 May 2022 17:36:58 -0700
User-Agent: alot/0.10
Message-Id: <20220520003700.E5182C385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-05-19 00:16:06)
> mtk_clk_register_composite() is not used anywhere outside of the file it
> is defined.
>=20
> Make it static.
>=20
> Fixes: 9741b1a68035 ("clk: mediatek: Add initial common clock support for=
 Mediatek SoCs.")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
