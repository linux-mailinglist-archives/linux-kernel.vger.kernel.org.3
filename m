Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C717447670E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhLPAqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:46:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37052 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhLPAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:46:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD0A161B91;
        Thu, 16 Dec 2021 00:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4FCC36AE1;
        Thu, 16 Dec 2021 00:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639615571;
        bh=hnTeaCtTrduwGeBm9uvk8hzACemY2acnKiB3GhIw3yM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EVos9CDAWjLWEJHMLSA/BT2LekH/nSgbvilgMnlj/rIH8S7LLqlcYXVLXdMjPyFt2
         yo0vWNoy/ZzeHJ62fqM5+9d8fGRyuuNJBReLbmWHyBscXSoInTEDqOz9zjdXR+4Qja
         +W4duQk2Ybh7ECNMEQ/4mpSqrIaj6qwn6Y9ZhQ8RsDDRzTjENUm/t1+MrNcyvgYmmn
         fa5aMvzO11i0FqFqaTj9Wm5kXoByttlSUCIuMr9OtahFEKdr0uGsa0N3fqLCFgDCx3
         klRGF/0v+EH1bwa6QqGrlBrDqFD3R4JdWorE3H4kZ3ru2aL6DvWr0/481yobu8JeRq
         uCcJsrD85KFnQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211215113803.620032-6-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org> <20211215113803.620032-6-vkoul@kernel.org>
Subject: Re: [PATCH 5/8] clk: qcom: lpasscc-sdm845: explicitly include clk-provider.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 15 Dec 2021 16:46:09 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216004611.1C4FCC36AE1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-15 03:38:00)
> Per Stephen, clk providers need to include clk-provider.h, so include in
> this driver as well
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
