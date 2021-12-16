Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A44476714
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhLPAqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:46:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37240 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhLPAqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:46:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0346061B91;
        Thu, 16 Dec 2021 00:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53023C36AE1;
        Thu, 16 Dec 2021 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639615590;
        bh=GkrZ+K8Xl18WcEyidYF06Mzmf/EoVN6R4LEHh9GXphI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=maobrppPhMri3wasYz8nN13R7xdIX6wTbZHIssGf7b8sEZ0NfcSx/3rfbewCPNnRv
         OiVa8rjlo4AKAL3KbL2JaMXPBoH1TtrCdQSR2SHm6FMOT8dLwmVujtyZhVnYAFa3Id
         Jh7AXGzTSp5Fwz4kultuLiPmxrghUshnqeFD7qH4DuWBxTTS9+B+D5OkK2lzj3vua0
         TmZHYgDZ2EIYLexjcM1RmxHuFHD8Fn53+bME91ja5rlJM13d53hazzwSSnz6zyf+1K
         VFPowerGx9LYINWSh56wfPc4tz69wV5El3eU3HR1U3l2BhgVXANH5k+y3q/ePYVKe6
         g+HgnH7NZjOuA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211215113803.620032-8-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org> <20211215113803.620032-8-vkoul@kernel.org>
Subject: Re: [PATCH 7/8] clk: qcom: q6sstop-qcs404: explicitly include clk-provider.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 15 Dec 2021 16:46:29 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216004630.53023C36AE1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-15 03:38:02)
> Per Stephen, clk providers need to include clk-provider.h, so include in
> this driver as well
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
