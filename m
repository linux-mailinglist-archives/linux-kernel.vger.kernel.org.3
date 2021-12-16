Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B53476A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhLPGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:48:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38716 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLPGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:48:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 448B8B8220A;
        Thu, 16 Dec 2021 06:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AD7C36AE4;
        Thu, 16 Dec 2021 06:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639637324;
        bh=m5vS1HxsTPT0xOHjuF/PpXUmvflQ2rhqdTD07eZ9ZMY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=THf9PKLwUtd/Yuv7bkKpf3yjfQE/UGTgfp6NXrD9xUJokhhNasudxxL0ktKGvcCsK
         ATS5t36Tp1ihLKAGOXZnTRdLjRFAOT+OAsNb/FVSI5GwhubXPJjQNAUbk1x8Xx/zQS
         y+mQ+jCkuJi6hMS1I2yx18UQLQ7We1bgmFnvZSUMFfNBsLhARPSbs+3JHBxVbSvbMR
         /+6RkBZRqUSAOsWqSGcVnHaL4DqGICGT+CZu+4fABNyfBN4xvqK2P5gsbx79eoz5Mv
         hUrC3dFJzE2Aj34hs084DQq9qqtISzRTgxtU1DLbmv3PYaQTw18D5BevcNIiLXmd7F
         WPpSBhNh/ZM7w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211126221239.1100960-1-colin.i.king@gmail.com>
References: <20211126221239.1100960-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] clk: stm32mp1: remove redundant assignment to pointer data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Date:   Wed, 15 Dec 2021 22:48:42 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216064844.02AD7C36AE4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin Ian King (2021-11-26 14:12:39)
> The pointer data is being initialized with a value and a few lines
> later on being re-assigned the same value, so this re-assignment is
> redundant. Clean up the code and remove it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied to clk-next
