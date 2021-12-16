Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABF4476705
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhLPApb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhLPAp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:45:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF83C061574;
        Wed, 15 Dec 2021 16:45:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 571A2B82232;
        Thu, 16 Dec 2021 00:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EC9C36AE1;
        Thu, 16 Dec 2021 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639615525;
        bh=gQ49QN5eW2zNMXR67xu7A0mzYYl6yMwe8gX3x7Vt5Ug=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R6H4YAmVQ2Ckv2S/F+zKanF7kPVajmYSq/NiImNb7FVQBqsLskLKBwNpgLGBfjpJf
         tG0cAzCd4bjNHUtSwEkhs0R37urNTJm59Q/AlX6zzHDc1EGEzcyqe+OZmpnvNedjsX
         INllMCRziSHfZ5HS/9+91GU3F1H9pxB1kC06q/lM4iVo55NrQSLOh/YB9NdnJ0imfD
         PnMjZbuoIU6XWbQl+fvzeI2+19qzsWAsMZcK0TN9N9mVgGHoQoDoL07SZO1fDF+Kwa
         UrkSBJDM+eDMFycp9bhX0M5LjtSAcR7kLe0hDxpMJTXfTmC0QJ78ZfUZilUUVbSsMy
         KOGDDK98D6wcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211215113803.620032-3-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org> <20211215113803.620032-3-vkoul@kernel.org>
Subject: Re: [PATCH 2/8] clk: qcom: gcc-msm8994: explicitly include clk-provider.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 15 Dec 2021 16:45:23 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216004525.09EC9C36AE1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-15 03:37:57)
> Per Stephen, clk providers need to include clk-provider.h, so include in
> this driver as well
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
