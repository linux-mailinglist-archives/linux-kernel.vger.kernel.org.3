Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77AE4BAB13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiBQU3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:29:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbiBQU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:29:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FD166E29;
        Thu, 17 Feb 2022 12:29:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C724161D7D;
        Thu, 17 Feb 2022 20:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DA7C340E8;
        Thu, 17 Feb 2022 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129766;
        bh=iht8meNpuv/PfH8oatg+B++8jTrozjQQAmlHU8+wdsU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hUQD2zTgrvbPDLj+wpbaYy6vmD1mhER0/0c00sAwoJhYCG/RGXxFHpXFi8Nl66TFu
         YdCmo9I4/jOtwdz2FyoStZbNszA0oinwUH7NAfO8Gvea/drFu4khxXDW9uvXPsQMwC
         wZNKrBkSLMebfUjZEBk0VGDFw1VzqBawuQYNx3BNsVJLVNucSx8nmi/qWhhTPQn9us
         GIaKxMfWV5qVlByy8oGuzKBx8zti4nSt3byYiZbFR0lG6ZJooIn3abznPFK+1lL2mE
         pdPPIAUEWw2oRtSiishaTb4nzbcFECrdolHKZUJPmScdavNs+5DKLVvBcZ2NKWegbf
         +FaQ4SRLzzUFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-29-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-29-wenst@chromium.org>
Subject: Re: [PATCH v3 28/31] clk: mediatek: mt8195: Hook up mtk_clk_simple_remove()
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
Date:   Thu, 17 Feb 2022 12:29:24 -0800
User-Agent: alot/0.10
Message-Id: <20220217202926.21DA7C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:31)
> Various small clock controllers only have clock gates, and utilize
> mtk_clk_simple_probe() as their driver probe function.
>=20
> Now that we have a matching remove function, hook it up for the relevant
> drivers. This was done with the following command:
>=20
> sed -i -e '/mtk_clk_simple_probe/a \
>         .remove =3D mtk_clk_simple_remove,' drivers/clk/mediatek/clk-mt81=
95-*.c
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
