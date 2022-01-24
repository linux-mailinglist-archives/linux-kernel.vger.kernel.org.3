Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7546F49A72A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3423031AbiAYCct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355504AbiAXUWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:22:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4DC0417D0;
        Mon, 24 Jan 2022 11:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C95EB81239;
        Mon, 24 Jan 2022 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44297C340E5;
        Mon, 24 Jan 2022 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643053216;
        bh=5d1KiOyv52f+/wbMD2uRsiNtmxj6WuPrFFJ1Ny+tHaI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tv1dOZ6nWTTYKVQE3WBOun88z3a7NKEHWdsILR7FQSWt/fS9wEKsPaZDmi/9/dp3E
         emcPhSKCjrZ3WoAYJ+Kgu5Zw7/Rh0P0HzmDta0HNlJDbGxTQ4ZoGc3Ne+yJSxXrh4K
         wNVWWnTCnYhoLqAP9Afw3lB3wduPyr5R64qurcdMgUMeHQzUeBTYoFNNrbZembJFFC
         wtsD++vu/0rX/RDvkTJi8T+PC3p0KB9otRV+WG+y4xgoQqRc+HkTv2qp4eSQcykmhb
         MdWJgMPtcyfNoIOpKiBBTVWD7qUkAa7kZHlqjrLD/bG+MF715pu+kTnTVV9nl/kB1W
         SVoX62lyjRf4Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220124174805.31021-1-tdas@codeaurora.org>
References: <20220124174805.31021-1-tdas@codeaurora.org>
Subject: Re: [PATCH v1] clk qcom: clk-alpha-pll: Update to use determine rate ops for PLL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Mon, 24 Jan 2022 11:40:14 -0800
User-Agent: alot/0.10
Message-Id: <20220124194016.44297C340E5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-01-24 09:48:05)
> On 32 bit devices, where the PLL requires to support the frequency
> beyond the range of the `long int` the round rate ops cannot support.
> Thus update the clk_ops to use determine rate instead.
>=20
> While at it also fix the code in RCG.

Please split this into two patches, and tag with Fixes
