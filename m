Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD04BAADC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiBQUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:25:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbiBQUZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:25:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151A8F9A3;
        Thu, 17 Feb 2022 12:25:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A9E3B824A1;
        Thu, 17 Feb 2022 20:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D10C340E8;
        Thu, 17 Feb 2022 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129518;
        bh=Aw1U3dx7zIY5dvXD5S4ZApyDcFqLvtaEFFmV/5dNE+s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RAy4yADJhUr6IQo+AX9biv04hkFtucU//d3h6RuFbbyUQjTp9yqao4AsyTeh+q/HP
         dYDYz9pqLN4SQcsc+ThayBrrDlth4MYaFzkA8Mg/1enHFHB46Bm25CkLELdDqR2MUI
         NQg+EkT0ZMGDdiSUxblpmw2DxDnlM+tiFyGbMvKtRe4Z2eCBAvcJMBuqzB1zHun9G0
         LjL+LpnCpJzEpQOBMNmGaH+BGIHc1qwi6vhwAMK0EcXE15d+B7nrV60da20Iy2W0tG
         uohafv4aZSNr57WFgNsHxERPXTEbza5jRQ52uC6JnH6YurkgdW6VC9aDI+X4IU3e7Z
         t0nzp9YlSaS9A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-13-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-13-wenst@chromium.org>
Subject: Re: [PATCH v3 12/31] clk: mediatek: pll: Split definitions into separate header file
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
Date:   Thu, 17 Feb 2022 12:25:17 -0800
User-Agent: alot/0.10
Message-Id: <20220217202518.A8D10C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:15)
> When the PLL type clk was implemented in the MediaTek clk driver
> library, the data structure definitions and function declaration
> were put in the common header file.
>=20
> Since it is its own type of clk, and not all platform clk drivers
> utilize it, having the definitions in the common header results
> in wasted cycles during compilation.
>=20
> Split out the related definitions and declarations into its own
> header file, and include that only in the platform clk drivers that
> need it.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
