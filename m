Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACDF4BAAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbiBQU0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:26:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbiBQUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:25:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3EB8F9A3;
        Thu, 17 Feb 2022 12:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AE65B821B1;
        Thu, 17 Feb 2022 20:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9511AC340E8;
        Thu, 17 Feb 2022 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129540;
        bh=4MMRT1XbREvNZztA+k8zvD/DvbOWWudkLm6qW0zGRF8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SH9RnZWwyQSxReGAgEHbln8lulKa3fTFjWTliXxOUuV5EK30Id8RUwPguZwW0SQ40
         RE4gUWFcg3ALMWL3fOgm6YZf5XzCcmPKBacTW3kZFARYcZrqImahLj3EPfmEl3ZA29
         q+ZxlTj+WXbVvOEsGIef5tnV0Nbj7w1j6Br363UR7ACYXuoCil5ijCjduD01BLq2pc
         lhWC/ZcnOt7GGz42NIJlwterUyQm4MVRRnBJS0+bcl0UQDFt5F1/tetb3hWqM3DzJK
         UInkNQ/a5u3NV/1ndmp6MHEI5o+XDmyTPrHjYE5kqU/6/JpiQ/6fhY5slqYBZcvHsU
         w3ASojK2g7z5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-15-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-15-wenst@chromium.org>
Subject: Re: [PATCH v3 14/31] clk: mediatek: pll: Clean up included headers
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
Date:   Thu, 17 Feb 2022 12:25:38 -0800
User-Agent: alot/0.10
Message-Id: <20220217202540.9511AC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:17)
> Some included headers aren't actually used anywhere, while other headers
> with the declaration of functions and structures aren't directly
> included.
>=20
> Get rid of the unused ones, and add the ones that should be included
> directly.
>=20
> Also, copy the MHZ macro from clk-mtk.h, and drop clk-mtk.h from the
> included headers.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
