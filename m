Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984D748801B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiAHAxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiAHAxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:53:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED7C061574;
        Fri,  7 Jan 2022 16:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19D19B827C0;
        Sat,  8 Jan 2022 00:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A322DC36AE5;
        Sat,  8 Jan 2022 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641603188;
        bh=n1Bs7zFAAfDihSUExic/LMl/gY/kBvXNDJla2yrKgMo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rtnI+aM5IRB/oXGut6Nrw3GhjIY+cus8eAuh/cmLI3Da3eekb3izft6XCVRMbVCpt
         6EP+cb2GypYCik+yd1R2/Xg2u9FdlnAAoOpCmjOfCydXxzewL5lDrt7MKTFl6tqJvq
         BZyxwlGRc4R36QdcOZCfW8mGodVlXzQ382L76ZwLogRj3VU639TZdvntCaPlhX04dS
         w84AbycgxRigEsPRVD0meKuOpRUrsbQ1h0ZzzXPm1g0hzWZRDFZhhCFKpO4Sns1/MH
         eys6JurMdHBIHh3nM8Cp1Numb7Cy0efdABVFOlTy0p0SCPnwMn3zGdoxK6L+h0z7st
         kf7zMvIQaq3JQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211209163720.106185-5-nikita@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru> <20211209163720.106185-5-nikita@trvn.ru>
Subject: Re: [PATCH 4/4] clk: qcom: gcc-msm8916: Add rates to the GP clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
To:     Nikita Travkin <nikita@trvn.ru>, linus.walleij@linaro.org,
        mturquette@baylibre.com
Date:   Fri, 07 Jan 2022 16:53:07 -0800
User-Agent: alot/0.9.1
Message-Id: <20220108005308.A322DC36AE5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Travkin (2021-12-09 08:37:20)
> msm8916 has (at least) 6 "General Purpose" clocks that can be muxed to
> SoC pins. These clocks are:
>=20
> GP_CLK{0, 1} : GPIO_{31, 32} (Belongs to CAMSS according to Linux)
> GP_CLK_{1-3}{A, B} : GPIO_{49-51, 97, 12, 13} (Belongs to GCC itself)
> GP_MN : GPIO_110 (Doesn't seem to be described in gcc,
>     ignored in this patch)
>=20
> Those clocks may be used as e.g. PWM sources for external peripherals.
> Add more frequencies to the table for those clocks so it's possible
> for arbitrary peripherals to make use of them.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
