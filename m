Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAAF4BAB00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbiBQU2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:28:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbiBQU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:28:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B4C3301;
        Thu, 17 Feb 2022 12:27:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 914CBB80927;
        Thu, 17 Feb 2022 20:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0135EC340EB;
        Thu, 17 Feb 2022 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129673;
        bh=UdXLYBPmUR2sCF/V3tFgzzwHqBVkxJ76Iql4QyoYo0g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=O0egWXk4aBlBURCD/Q8XvZ8T0l5udkH/0Zd2e/DxuynVyXP+d85ShJwuxtT5erV0j
         rztwdBOt8j2li8wztlwbCcsem/LiJMMyRHzMoBDqs4VEgq4j3b6kk6xZ18XxDPodDN
         nzd77CaGFhYJPF2BD9qSwBftXzuhtp+22Aiq+CgA7AF7YkO1gMsnLDBdwWzrBW9cP4
         zwwCNyh9vwFRUuf6TYy2cLUaTKjNPiEnY9m/NopP1TdOnn9q43EPlRV3EEl5aVm5Fa
         iqSirWLvCRamres1Y3PN5UlMqVwtXGwDJxoLj/LgfjoAQEtqm8nKli9jD4Mpxatnr7
         xjnLacEx9N/oQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-25-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-25-wenst@chromium.org>
Subject: Re: [PATCH v3 24/31] clk: mediatek: mux: Implement error handling in register API
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
Date:   Thu, 17 Feb 2022 12:27:51 -0800
User-Agent: alot/0.10
Message-Id: <20220217202753.0135EC340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:27)
> The mux clk type registration function does not stop or return errors
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
