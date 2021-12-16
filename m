Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4699476711
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhLPAqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhLPAqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:46:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813ACC06173E;
        Wed, 15 Dec 2021 16:46:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B6D7B82235;
        Thu, 16 Dec 2021 00:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0231FC36AE1;
        Thu, 16 Dec 2021 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639615581;
        bh=MsAoYfW4dAAUIIsiIQDr6uv8tMK1+aqR0CUNio7k8qA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UpXNqiwDG0w+18u2w6gALvbDfOO5JPb4zsqZxSNmMMmGRnU0KorZdclHSDYnJKa4h
         zmL6KMoFey9MDlsivMcc/xzYeMJM1lFcqaWK8Qexf5stD2TFwbymnjeG0iwqzuGbIR
         6z85QA5ihxbMkb2xRoT2KS4BKGpzSVuUzgLeaglVLyywBA3m0GwDjXwDOHfqbatKiv
         lH9xdvCHi+NyfAHE+Ha7cqQHhjt2BVsD4bCasZ+35a+cP2eAfpPV7B6ozW3lNwwwGX
         /BzhieCzarISXUoSFWBhIhIy8WAHVmRh341wIxCrNTjaUk4E/gjzITXt0/NBOaaZV9
         0EY2wOFyOdCgQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211215113803.620032-7-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org> <20211215113803.620032-7-vkoul@kernel.org>
Subject: Re: [PATCH 6/8] clk: qcom: mmcc-apq8084: explicitly include clk-provider.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 15 Dec 2021 16:46:19 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216004621.0231FC36AE1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-15 03:38:01)
> Per Stephen, clk providers need to include clk-provider.h, so include in
> this driver as well
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
