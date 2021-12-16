Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B555476717
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhLPAqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:46:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37302 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhLPAqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:46:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22BA461B65;
        Thu, 16 Dec 2021 00:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72073C36AE1;
        Thu, 16 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639615596;
        bh=aQbNxTLz8zWun89xLUG5rF040y9I7IvTC7Mjmmm7VUM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LRghrv9UHJlu8eq7q4tklwq8sgbuXHgnyvPHFpdfm5usanlZrT2MKwQ8nn8dnqFJm
         GtMnRbKjJeNVp5N2FPIHTrO7x3yBVZAP3UGnFTgHqKQfHuouShFUfY0lcg5JGdEx8g
         /HEl1qKrftYyIZjzaETX7J8VkszlPeESLK82or1n2ltaCqBFuWnSUS/5Jzf5LJ6J0b
         0A8OoJSOTjnojtcYDnFedSC0VHFJlcSrDwGPCCBkPljwa4oUwngCQmxmOSsI1kkqIA
         CQ3iE82U6jDmUxpwkoxkhuLsQEyUXjqYU1PHZruu4w34U5/Tg7pWoWdQ++eU740Mwt
         +mqW51P/wWBFQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211215113803.620032-9-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org> <20211215113803.620032-9-vkoul@kernel.org>
Subject: Re: [PATCH 8/8] clk: qcom: turingcc-qcs404: explicitly include clk-provider.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 15 Dec 2021 16:46:35 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216004636.72073C36AE1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-15 03:38:03)
> Per Stephen, clk providers need to include clk-provider.h, so include in
> this driver as well
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
