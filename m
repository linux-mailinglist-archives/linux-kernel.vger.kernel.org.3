Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70C1466EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbhLCBCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbhLCBCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:02:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D66C06174A;
        Thu,  2 Dec 2021 16:59:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9E1EB82025;
        Fri,  3 Dec 2021 00:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BEDC00446;
        Fri,  3 Dec 2021 00:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638493168;
        bh=gAszAJGGHye2RgWWyEPNSetu+idKR1JbBRTAAgjo8Bk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rHPfzz0Ngj45MaTUdSw87sLOh6NZ6A922ZLOMQtP/7C0N6o6b9hTcZ7HN15YqRpqI
         sGCwNZo/2LbqPg/rn4c1Ho7uyLeHrawQHHtcJ/+mk32kdhqN5EbynXNf/bWN12Mf6K
         NNuNX1V8T7Ip217EQ3WdcIpVv92FkH+G8cjYLOYHwcHs3Yy88/RV1ItRuWnvdCaLd6
         EQhuAIYeI6lFTGd34+k2QydiSv4s5uSzlhfsaSXk3lf+C8NIJcGiVgJwR3eE79xHiW
         GwTfRuzrcAcq1g2j8rzDAoI0Q0BLb4UxVudOBaGwIj/WiHLli9nuzoEJRvdJ6x7TDa
         /MbNv6nY2eXsA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211123162508.153711-1-bjorn.andersson@linaro.org>
References: <20211123162508.153711-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2] clk: qcom: clk-alpha-pll: Don't reconfigure running Trion
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, Vinod Koul <vkoul@kernel.org>
Date:   Thu, 02 Dec 2021 16:59:27 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203005928.52BEDC00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-11-23 08:25:08)
> In the event that the bootloader has configured the Trion PLL as source
> for the display clocks, e.g. for the continuous splashscreen, then there
> will also be RCGs that are clocked by this instance.
>=20
> Reconfiguring, and in particular disabling the output of, the PLL will
> cause issues for these downstream RCGs and has been shown to prevent
> them from being re-parented.
>=20
> Follow downstream and skip configuration if it's determined that the PLL
> is already running.
>=20
> Fixes: 59128c20a6a9 ("clk: qcom: clk-alpha-pll: Add support for controlli=
ng Lucid PLLs")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-fixes
