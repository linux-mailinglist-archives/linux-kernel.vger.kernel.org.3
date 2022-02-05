Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088784AA606
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378998AbiBECsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:48:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48094 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiBECs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:48:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3218060C11;
        Sat,  5 Feb 2022 02:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76942C004E1;
        Sat,  5 Feb 2022 02:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644029308;
        bh=xd4Zyu6GLGga48XMPzzZETsVpPvBHmt/7qiLH5XsLjs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Vwz3RrYhbnaLJIzz9xaR2kdRLtigmA2VwWtCINvPYtJyYMHHcEEqqbfSAyQLtnEOk
         +Lfqjz3fckDzbFmiw7qsHUH/VHXSM/GqMvqrYetigdumOXs3sKX80pVRmcIGRAF/iM
         qILVVglOpExul4jVjCq3TNBGISaNAHC6xqXZ4oEWTAe07l6b7KYk0I1IuN0RxRGAW/
         a9WBURihskHFUs6krsI2dYr6nOdX+YajJASKGuUEhXzzo2KVr28KNgAW3LXbBUOfo5
         cuq6nLZ3btSSq2ioHCqPs7Q5Ctkplbv6VScBe/hHyh6LX+I8wk9PMheiFrq5ZZzNEG
         J3Gcx1p9r0WRw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA8EJpqWUm5C5nc3fZzjF4XfAEZo8m=PY0Rj6WeDgSJEey=D_A@mail.gmail.com>
References: <20220202182053.22925-1-tdas@codeaurora.org> <20220202182053.22925-2-tdas@codeaurora.org> <CAA8EJpqWUm5C5nc3fZzjF4XfAEZo8m=PY0Rj6WeDgSJEey=D_A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] clk: qcom: sc7280: Update clk_init_data to const for clock controllers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Fri, 04 Feb 2022 18:48:26 -0800
User-Agent: alot/0.10
Message-Id: <20220205024828.76942C004E1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-02-02 14:34:11)
> On Wed, 2 Feb 2022 at 21:23, Taniya Das <tdas@codeaurora.org> wrote:
> >
> > Update clk_init_data to const and also use index instead of fw_name for
> > graphics, lpasscc and video clock controller.
>=20
> What is the benefit from using indices here? In my opinion the code
> becomes more fragile with such a change.

The benefit is smaller code size. Please run scripts/bloat-o-meter
