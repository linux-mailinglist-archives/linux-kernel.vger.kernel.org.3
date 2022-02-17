Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6754BAACE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiBQUWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:22:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbiBQUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797117AAD;
        Thu, 17 Feb 2022 12:21:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8AA361D80;
        Thu, 17 Feb 2022 20:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C02EC340E8;
        Thu, 17 Feb 2022 20:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129308;
        bh=lV41Ql6v90WlWkOZB0AEvluua+kEpsEci3M5c+iLfh0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ikFqhNp6DXtNKNuz1BMmUG0ZdJNE17hntPEENMq0k6j5mEVzAIYEv8qgdirasiIsk
         1yKMXK5DVY+SGCvwFjezhM9Be3WwZ6wEin99Uyf98xjET/MaH09pFJ49b1Rswpf4oz
         H8SXzTLr0h/Y5noIqC7b2jhAHZfInYlIAilwkFYRdX2Nh1cUGF6dhOw2LyWUh1gJZe
         ZVRWl2n2o+lGGkHttFcLIWygzS0dJ3X83Fd4WnZ1+hUPlL3J3hwGWMZdl2CzSxmJTz
         qSRwYNJvfcQB3XT8lswESB9v07iF5sjx43Zutkdv0nLZV7immqCFmyTBmSqCRC78j7
         1oF0fqxvozcgA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-9-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-9-wenst@chromium.org>
Subject: Re: [PATCH v3 08/31] clk: mediatek: cpumux: Clean up included headers
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
Date:   Thu, 17 Feb 2022 12:21:46 -0800
User-Agent: alot/0.10
Message-Id: <20220217202148.3C02EC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:11)
> Some headers with the declaration of functions and structures aren't
> directly included. Explicitly include them so that future changes to
> other headers would not result in an unexpected build break.
>=20
> On the header side, add forward declarations for any data structures
> whose pointers are used in function signatures. No headers are
> required.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
