Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568A24BAADA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbiBQUZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:25:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbiBQUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:25:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD66390245;
        Thu, 17 Feb 2022 12:25:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A2D6B821B1;
        Thu, 17 Feb 2022 20:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38090C340EB;
        Thu, 17 Feb 2022 20:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129507;
        bh=NANMiRe1Q5XOTTcz0YIeCUPmQ981TsyztedonQAOvmQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DJm6iMkhGVhAcJ0ub02k5NGo8Pni6cKHVZTrkagbuTr+K0ogowi4IJDCb+fmOaas2
         PE60C5KXgjyqNwzvpwY88s/Xvgj9zWeEM/TPFG+eLeAKcVxgj8SDymReZZt29x5oiK
         JSrOCeqSuuCX73fWo2mxWoP1KBAFtLUhFfgtJhigAvsqUPpx6zH6VmVOonzvG6NKb0
         MhvFI4vfelSkfIwAecQ8PTD2fMXYaG3uI9GnY35SkbSuNzWTcAZ/1Kx1qFZFJIGrei
         FBSdlayBytAf47jVx/beKYiPhIygzA7rwbVfPkK74RCCk1U8sXJclKSbUHYDUeF3DX
         z3ejsxF4/b0xA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-12-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-12-wenst@chromium.org>
Subject: Re: [PATCH v3 11/31] clk: mediatek: mux: Clean up included headers
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
Date:   Thu, 17 Feb 2022 12:25:05 -0800
User-Agent: alot/0.10
Message-Id: <20220217202507.38090C340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:14)
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
