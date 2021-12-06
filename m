Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5168246ACEA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376309AbhLFWpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376662AbhLFWpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:45:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161D8C08E83B;
        Mon,  6 Dec 2021 14:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D16D9B815B0;
        Mon,  6 Dec 2021 22:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AE3C341C8;
        Mon,  6 Dec 2021 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638830488;
        bh=7ndDzkaxQj+HBmLXou/OybwE/3KJ2E4X0NXt5I9DeCY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eNKwE193PEqMhQWHXSnpJl96MjL/3+egz4N2V4qB5QVKT12MlveXZrJ/FrK8NE3Hy
         TFvPIvwDAm9E4p3OAr2WgaNopW4hr4TYmHRTm1nLKktErxt8B6Ed7EWNX3rWu6lRlQ
         1+f7uIs2fzUNzm1zhd1ZvPNpW6c+adiWAPylr5iEeN0txnUwsepstoZVYUrmGP1dnu
         RiXpq7ysyA2JdRPFkswI+yZ0GLt/7VvScCV2uKyL0CT9WuhAtWqJLUey3u+yt6zVqh
         I87b5SVhJogKDtmLcLwfg5NjOoO9zxFv2YbOLaX//YrX11GEgzBhfG5Ya64aDLOE1D
         p1BBVKYvvzDOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211130212015.25232-1-martin.botka@somainline.org>
References: <20211130212015.25232-1-martin.botka@somainline.org>
Subject: Re: [PATCH] clk: qcom: sm6125-gcc: Swap ops of ice and apps on sdcc1
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Date:   Mon, 06 Dec 2021 14:41:27 -0800
User-Agent: alot/0.9.1
Message-Id: <20211206224128.62AE3C341C8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Botka (2021-11-30 13:20:15)
> Without this change eMMC runs at overclocked freq.
> Swap the ops to not OC the eMMC.
>=20
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---

Applied to clk-fixes
