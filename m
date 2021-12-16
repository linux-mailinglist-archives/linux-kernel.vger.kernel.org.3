Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF77476702
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhLPApO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhLPApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:45:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4FC061574;
        Wed, 15 Dec 2021 16:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDFDEB82239;
        Thu, 16 Dec 2021 00:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EE0C36AE0;
        Thu, 16 Dec 2021 00:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639615510;
        bh=exo63l7MiltxzokLyI5iWNvq7jXzJk8Xy3xuGmNBkfo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VIrFzZmSLUcuCDgMl1MCifRgUm8xtPXoD5KKwCCPHjVD70wdFNqc0Nd03kxOthLyL
         CjlZeTezP8Wf1mP8AZk0e33JsfekZocNdLXbXNdOpov63O1L12pBTmFA4J9bNXYi5N
         Xc1aEYHJQdYvlD2vsEpDj5yjb2AGAVC/vskQSf3A2iztcgL9v0OjF1yRpmJ1fP6CUQ
         tciqqNCZTt3tqG7keX4hXwUUwFyPAuiYZMASesr2Y6/r750YiIInrUnw9QY7l1QO2Z
         PoB83VqR7rLuqpk7FDwu9VDBa5ecmnpAPAx6WRFpmNvZUJ1Jpq8M7JioGvdch6Aj99
         rCaRt2aBogs8g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211215113803.620032-2-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org> <20211215113803.620032-2-vkoul@kernel.org>
Subject: Re: [PATCH 1/8] clk: qcom: gcc-sm8350: explicitly include clk-provider.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 15 Dec 2021 16:45:09 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216004510.A6EE0C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-15 03:37:56)
> Per Stephen, clk providers need to include clk-provider.h, so include in
> this driver as well
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
