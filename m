Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32924BAAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbiBQU15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:27:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241834AbiBQU1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:27:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18159C2E77;
        Thu, 17 Feb 2022 12:27:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A900A61D6F;
        Thu, 17 Feb 2022 20:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048DDC340E8;
        Thu, 17 Feb 2022 20:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129660;
        bh=ilOYBZRzF5qZKxjckhhQqQteFDzfc4LnB9TUkegTnI0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NynGR/00wKw0k2eFA7b+jXiOys3z4RXbxJzy5i624cXq0jt3ho6bk+Jb6uSZlCGyn
         FH18ltJSNPHAPLH/2cGRgw3Yzi3wdkK2ZJt0bOMtrTwETVa34DXTXCHhcvDBLXiOL5
         +6oQ9Ug6y655pIfts9cLDEOMDX+GpJE0E252aJtiag+NU2lU/4YJf9GA6VwmTAN0Qr
         CZMWCOApGSkWQpRfjNaD0SS/ICQGfwTmpZDagJ7CFsjaTGtVW6LzRZYrRjCl78hg7+
         pUP9ci8dlRnD+JvuuycbP/FRLWGQmsPQMWbUDR3w4jtAGdtIZ8ylV1aTVV4v7r9kz9
         ps7D9zGLVP5Ew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-24-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-24-wenst@chromium.org>
Subject: Re: [PATCH v3 23/31] clk: mediatek: mux: Reverse check for existing clk to reduce nesting level
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
Date:   Thu, 17 Feb 2022 12:27:38 -0800
User-Agent: alot/0.10
Message-Id: <20220217202740.048DDC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:26)
> The clk registration code here currently does:
>=20
>     if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
>             ... do clk registration ...
>     }
>=20
> This extra level of nesting wastes screen real estate.
>=20
> Reduce the nesting level by reversing the conditional shown above.
> Other than that, functionality is not changed.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
