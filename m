Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627A25508C0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 07:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiFSFaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 01:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFSFaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 01:30:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A203273B;
        Sat, 18 Jun 2022 22:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AAD57CE0A3C;
        Sun, 19 Jun 2022 05:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA7BC34114;
        Sun, 19 Jun 2022 05:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655616598;
        bh=u85QCkMqTAZlfYMUqpuwqvH1SbaUwXaSYiU4TrvwZRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISrbO0ZxjnOvCwgoNmEFzfhaVjmy2/WukJFBKTb38pdYcuTWokqNqKA2rH+mB2WP6
         HgSueSURUTew+rcYVWjF8Y7nERisl1+tmkOkd2ewrE4XsmEGuha8x9b/yHarnmQwBD
         hkrrWWNBfK28nMKSOEPPWzAWQII+ubvfZe4ibfXpE26iZCNpRThhvn96xatjJT57Md
         frUc3VS33rex9x/8CHFF4s1OTLpilWZpep/KDIa9Ivz/DdfaE3w77ZZBqFb63BbllG
         d12rH3LU4NEbVYlQsi8SyJ7VsEn4874xTZbr5kzC4tVhbbEClBFLMtq3T5Oxwh5Q/7
         G922AqV8IQuRA==
Date:   Sun, 19 Jun 2022 13:29:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: freescale: imx8qxp: Fix thermal zone name
 for cpu0
Message-ID: <20220619052952.GD254723@dragon>
References: <20220607105255.1811769-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607105255.1811769-1-abel.vesa@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:52:55PM +0300, Abel Vesa wrote:
> The proper name is cpu0-thermal, not cpu-thermal0, so change it to that.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks!
