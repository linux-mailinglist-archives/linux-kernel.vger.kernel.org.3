Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE12E47670B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhLPAp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhLPApz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:45:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99938C061574;
        Wed, 15 Dec 2021 16:45:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37BAB61B9D;
        Thu, 16 Dec 2021 00:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86640C36AE0;
        Thu, 16 Dec 2021 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639615554;
        bh=5yEb63Mh6tHHmzQvX6bh6G8gOpHP3iBfTA8KbhY+HC0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l0Awlo6Z+SNFSdo6clQ6pqh3KrmWgnkJvvAypGvHr25vWVC7OAcfIR3uaK9dFl9YU
         AKPx8w6b1MYfc3xjIZm8nOPMajnE32r18L5d1uh1DbOBO7JxTC+aIO6qZ7G1f8NaDd
         6H6HDhwLHbSPHVLRF0Sfv/ZQFXQsewWSB7Z8hZgmChm1UqTu3B1k3TNyAWRQ88cBx7
         jxwxCvfJ27fJo/umbSVjPoc1LN+mkOT+r294ENXl0aXaptdP3VaGUSCCX2eLD9Nm+n
         0jN1p4qrxmK0x3MWdF4jH3V2N4Z2/86SZkR2LG2FJj3muDjhPSOMN+IzUkT06XA0zN
         fcMc35xkgOtww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211215113803.620032-5-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org> <20211215113803.620032-5-vkoul@kernel.org>
Subject: Re: [PATCH 4/8] clk: qcom: lpasscc-sc7280: explicitly include clk-provider.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 15 Dec 2021 16:45:53 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216004554.86640C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-15 03:37:59)
> Per Stephen, clk providers need to include clk-provider.h, so include in
> this driver as well
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
