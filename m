Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71AD485D33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiAFAdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiAFAcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:32:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA2C061245;
        Wed,  5 Jan 2022 16:32:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3E24619D3;
        Thu,  6 Jan 2022 00:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D3FC36AEB;
        Thu,  6 Jan 2022 00:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429172;
        bh=V0E1Vi6eoT/8T2lzM0MtFPIKX6KXXRYMF2uQa+0xsgM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OPeqf6GuNcMFHlzZJ9H027b7YGbIj4wuuVhQcfe0xyGCXwsVyrkodRMBe2MZFkPGf
         17aGsRIyKwYtEQBACiJavfTW3UdraoVVXTWUfB6jT5eikmzyjJ6mN3sENrmAsE84/P
         NFO8qV1mYv11UaJ/rWUgwUyGSP+WmeuJQoBoGNVDb/FQxqJhFhPRfPa+fpFC0qUEzt
         WXmgSS6CHQO+j0Zo0mlrYiC/wnMzTYL+TaRSQ3Wx9WQvTVzdpKdfc61reCFhCKn/Yp
         RFHxMx/uDaIN7Hp+S9UL8mb9b3X2TSIiBS8kDYu6K4u+1oblqLFSlQr2sQKzqdxE5o
         Z2VJAAZOjOLfg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211221003750.212780-1-colin.i.king@gmail.com>
References: <20211221003750.212780-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] clk: socfpga: remove redundant assignment on division
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin Ian King <colin.i.king@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Wed, 05 Jan 2022 16:32:50 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106003252.29D3FC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin Ian King (2021-12-20 16:37:50)
> The variable parent_rate is being divided by div and the result
> is re-assigned to parent_rate before being returned. The assignment
> is redundant, replace /=3D operator with just / operator.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied to clk-next
