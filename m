Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3E4BAAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbiBQU11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:27:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343609AbiBQU1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:27:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A31A650F;
        Thu, 17 Feb 2022 12:27:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A33B161DCC;
        Thu, 17 Feb 2022 20:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03691C340E8;
        Thu, 17 Feb 2022 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129626;
        bh=qFslgy9Zc+iKVRWaMOWnNLrhzKHJklAO5QBOWjbz0ts=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tHgd/MrGAYyt2xk5BCf7El2DggYP+6xNARgED3xyZtDN/yyklK5HDdTu2VlCiOWoZ
         FEP9ldCgarGMOmRk/bxjuTpUgv1zL+xtkkrvTJgCXnb3xifNYIsRMTP1LWbc6PD/oM
         sq5mwgg/5+Dg6CFpRKtQI+rxwjJ71CnA4H8Gf4VGhAkuT7PxxUMvdDfeCn5muxT9vD
         Dv2e6K38uzHuxvYTXLv5iaENHkbhsW0kHnBMsdZo9Qmu0Z6etrikbC6HTPNk3IPBHI
         f/q8wCXs2G3S25hUDejsbNVhh4iAAqGyZmO3JzA9Sf25cg9vq53E4muMq3fkTiRUx3
         PekV0DfEZfyDw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-22-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-22-wenst@chromium.org>
Subject: Re: [PATCH v3 21/31] clk: mediatek: cpumux: Implement error handling in register API
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
Date:   Thu, 17 Feb 2022 12:27:04 -0800
User-Agent: alot/0.10
Message-Id: <20220217202706.03691C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:24)
> The cpumux clk type registration function does not stop or return errors
> if any clk failed to be registered, nor does it implement an error
> handling path. This may result in a partially working device if any
> step failed.
>=20
> Make the register function return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, is done in the new error path.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
