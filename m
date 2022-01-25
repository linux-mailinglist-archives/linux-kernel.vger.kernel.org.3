Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537A749A84E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1317664AbiAYDCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415398AbiAYBqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:46:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D363C01D7C4;
        Mon, 24 Jan 2022 17:26:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 951406091F;
        Tue, 25 Jan 2022 01:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF017C340E4;
        Tue, 25 Jan 2022 01:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643074006;
        bh=DKZpPmTZIetqIDVYlUryUPp3fLyRnrqt6nngfQ3lB4Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IqDkS1IjYRpBOf/mkV0kT/Yus3trXD82kifFYwhBxcIyr88lFNDaJ70F3M0p7cN/8
         CMTBlUaSfjPy3N1FU/LmcYcQFS+S9yZfYvgqQhgOY/O/2tkeJwg9BDel74/W+ISHNo
         YN0wpf4mNq4A+aFu8exQeNPp9GfNrVJjLUDJsLCRypEX5vRvMrRlPo6bug8ocSPTGm
         e68zhBrKSo5LmHoNJ5eMuPOkFukY1nNjY9oDLGS3mOKP1FrXkGqUg5yrhTJvlt/D8B
         RbsX8jRL+PFJFbcSGxQhM+rq87UmcnP9cCzVJQ1anGVOAQ9j1iMPtt+Uxfi4BtoHqG
         9VhyFtFfzHI5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220120175902.2165958-1-sboyd@kernel.org>
References: <20220120175902.2165958-1-sboyd@kernel.org>
Subject: Re: [PATCH v3] clk: gate: Add some kunit test suites
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 24 Jan 2022 17:26:44 -0800
User-Agent: alot/0.10
Message-Id: <20220125012645.EF017C340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-01-20 09:59:02)
> Test various parts of the clk gate implementation with the kunit testing
> framework.
>=20
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Cc: <kunit-dev@googlegroups.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
