Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922664BAAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbiBQUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:21:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbiBQUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:21:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC6165C2C;
        Thu, 17 Feb 2022 12:21:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5540B821B1;
        Thu, 17 Feb 2022 20:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEE0C340EB;
        Thu, 17 Feb 2022 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129276;
        bh=aiOobr5lBz8A7yIKfHbKbUXZbVSHRX4MX9DlxRPLcGo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LlvM0hb5v4xqj0rKiwafwhzy7MevFh0RHetWovm1b5pGRNpt7p23KxrmvDnpwD55y
         Hmlm+ATkQzFRkvRHaUvQ51AW0hwiv+eR63EWxW5sUB0g8v+Z7WI2G8O+ZxtbK18hyf
         SaxQ6GDmEOvRpCq1znpoXcNHlyhBOT8VVZ89FNL9rJ04hmqlDGyJFZwgMFM70GrAiD
         +A39Encl/0IJ3F8ByK+HBxBZ+flevx8Hl1PgB9pqXqByxGFGI7G5CEvTbUmbOeilOU
         r/GiIhUBeq0zr1h1tzG6Ts44MsOTU9NlKjsPi3M2ehfQWTrmqtGiRv8opeesb5X++U
         4U1pVoXB+E+2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-6-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-6-wenst@chromium.org>
Subject: Re: [PATCH v3 05/31] clk: mediatek: gate: Clean up included headers
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
Date:   Thu, 17 Feb 2022 12:21:14 -0800
User-Agent: alot/0.10
Message-Id: <20220217202116.5EEE0C340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:08)
> Some included headers aren't actually used anywhere, while other headers
> with the declaration of functions and structures aren't directly
> included.
>=20
> Get rid of the unused ones, and add the ones that should be included
> directly.
>=20
> On the header side, replace headers that are included purely for data
> structure definitions with forward declarations. This decreases the
> amount of preprocessing and compilation effort required for each
> inclusion.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
