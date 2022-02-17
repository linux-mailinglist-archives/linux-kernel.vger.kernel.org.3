Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D784BAB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbiBQUaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:30:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343674AbiBQUaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:30:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5CEC335F;
        Thu, 17 Feb 2022 12:29:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0CC4CE2B9B;
        Thu, 17 Feb 2022 20:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59261C340E8;
        Thu, 17 Feb 2022 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129789;
        bh=XXqMZtSNGb7B64MKmIWBCf7B/pkwBDck0M+zvZtALmg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WOl8ePxv3hWUcb2vS3LVT477iQaDwhvsSrWjsOawxI+MhejodeVMDS9icSWSh/5v1
         SLSio65WaZhq414KvSZ7z2s6RKHmeqnJRJoKRq509ShKsUDAwJa28B7TL6THRBbEqk
         zwFhk34wAO36kyjjn07u4tsZWcZ6ot+MtVHDvdROdzGE5KQRb0/Zvx5JD1dUEf2E95
         6j526oI1c6Uf4+/LzNOmOdy5Yx4hipw/4Z4YBhd2sg5uE5DxWx5TYQ6ovmThwHR6i8
         B4elaX7Ih9jNN8y8ot/7zTyfZeUZ9/a3FFifCb3cZIOwET2w9pYffm+Z2OdZFHdrch
         UfYPWgnRzBIyw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-31-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-31-wenst@chromium.org>
Subject: Re: [PATCH v3 30/31] clk: mediatek: mt8195: Implement remove functions
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
Date:   Thu, 17 Feb 2022 12:29:47 -0800
User-Agent: alot/0.10
Message-Id: <20220217202949.59261C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:33)
> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so none of the drivers implemented remove
> functions.
>=20
> Now that the library does have APIs to unregister clks, use them
> to implement remove functions for the mt8195 clk drivers.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
