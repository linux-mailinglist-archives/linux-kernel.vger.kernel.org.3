Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E484349A896
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319588AbiAYDJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3423965AbiAYCiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:38:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9950C06175F;
        Mon, 24 Jan 2022 16:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96F52B810A8;
        Tue, 25 Jan 2022 00:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435C7C340E4;
        Tue, 25 Jan 2022 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643071899;
        bh=yzRDLvQ1vjIVlRYsbDhIDsSJXen/Z3G3DRZtgTvGlUA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JBLM8yTO0Ukv00hwrmiBtCeo55IkbagEIY1shJs+gUP+D0TkYhsGdAbFSfo/7aa+U
         E7+4i0BsfWEW9oXOwke5XmMyoaj0a/rjcJELP4t8/5Ut3DMm6XjY4Ol+E+ttqs/j0s
         hj0t1NWRmB3mQ/kdn4znEU9FNAar9xsn0oTWOI9FNi72ruvFYroiUxJ3UpjzPDau/K
         nnnT/W05KluRK998MEGlYJ8LbviIsN89ir+EZKbWL1iAu3hmCbhTBumI7jBuIVNTat
         VkR0YNc3OhRWIWpS+Wdy/uTPQ3ST6kKKUm7FN7IIQ3XMI824apDCu5dMy5HGepKgyw
         2uN21gr91HV5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211203141125.2447520-1-dev_public@wujek.eu>
References: <20211203141125.2447520-1-dev_public@wujek.eu>
Subject: Re: [PATCH] clk: si5341: fix reported clk_rate when output divider is 2
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Wujek <dev_public@wujek.eu>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Adam Wujek <dev_public@wujek.eu>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 24 Jan 2022 16:51:37 -0800
User-Agent: alot/0.10
Message-Id: <20220125005139.435C7C340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Wujek (2021-12-03 06:12:07)
> SI5341_OUT_CFG_RDIV_FORCE2 shall be checked first to distinguish whether
> a divider for a given output is set to 2 (SI5341_OUT_CFG_RDIV_FORCE2
> is set) or the output is disabled (SI5341_OUT_CFG_RDIV_FORCE2 not set,
> SI5341_OUT_R_REG is set 0).
> Before the change, divider set to 2 (SI5341_OUT_R_REG set to 0) was
> interpreted as output is disabled.
>=20
> Signed-off-by: Adam Wujek <dev_public@wujek.eu>
> ---

Applied to clk-next
