Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC134BAB12
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiBQUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:30:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343691AbiBQUaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:30:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4886C3C21;
        Thu, 17 Feb 2022 12:30:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1E78CE302C;
        Thu, 17 Feb 2022 20:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D419C340EC;
        Thu, 17 Feb 2022 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129800;
        bh=SSsBZlXzBFeoEU5lw4r/D18/9Ff6qo5+77w6dEp8nyA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=d7Dt9lvXsqeoUyL1ISqNJDAqcUutI+/E/7+ZTu+75S2mfvQ4Ti31+UELUzGSSESeG
         6tqIYbssvR7mXH5yAoo1u8VYIvjXoYBIjqoyH0iRHf/tnuaChbRWdUwyu+LWknPdZt
         MbzS6bPy25wxSa2/y3tuKRigDPeEFNDhCiesNVaRWZ28p2KIYPJ60XoVko8HWwHF/K
         y6iZN5I507RgHIFzU1iV6gIhH6ajfpJ2b/o9pxDGrW1OnJ1D8zJrJgxWFo5b2W29nm
         b9nEc50yHfFqw6HASUn/E+bSfMFHapyCua9m8YjN7fODNi6XEqx66Pr/U42XTejAoH
         c/NaHmvrUGt1Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-32-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-32-wenst@chromium.org>
Subject: Re: [PATCH v3 31/31] clk: mediatek: Warn if clk IDs are duplicated
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
Date:   Thu, 17 Feb 2022 12:29:58 -0800
User-Agent: alot/0.10
Message-Id: <20220217203000.3D419C340EC@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:34)
> The Mediatek clk driver library handles duplicate clock IDs in two
> different ways: either ignoring the duplicate entry, or overwriting
> the old clk. Either way may cause unexpected behavior, and the latter
> also causes an orphan clk that cannot be cleaned up.
>=20
> Align the behavior so that later duplicate entries are ignored, and
> a warning printed. The warning will also aid in making the issue
> noticeable.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
