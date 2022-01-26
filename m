Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7FD49C5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiAZJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiAZJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:07:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A2C06161C;
        Wed, 26 Jan 2022 01:07:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C55BCB81C22;
        Wed, 26 Jan 2022 09:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D264AC340E7;
        Wed, 26 Jan 2022 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643188066;
        bh=DNatj+Dsq6W5MUfSar+GgYazfcAWtvPdt4mne1lgnZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeZedHSNzDVukcesmbQwaw6vPulikfGGAQqpjRQ1cMSIzsv2PyozQslTz1vlMrJ0r
         ghOk89mIpVSYKMM30dAP3g4sORFOQw3r3GqE6io8ZMVorFAcLqAOTKfLoKU5TpoqYC
         cSlTFoZV+hnc5NiphH0OXTqLHXzbXwBjG0jUqeVXyMX16oWWfaRcl1ZwrbcHXlynwq
         b3UfZ+qpm7xwT2/AnKtmVXxuzxcYvzOwFp5CUf2J+BCSkVU9n+d02KxTIutUamvNhF
         EzSOpClVKhvNdtBf1Ehk22DsrGrWccsqH7NHVMi2CHbFz7fIEnAM3Ap+NUhXRbG6fE
         mJdd3LOcGD47Q==
Date:   Wed, 26 Jan 2022 17:07:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: imx8m{m,n}_venice*: add gpio-line-names
Message-ID: <20220126090739.GH4686@dragon>
References: <20211215001812.9006-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215001812.9006-1-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 04:18:12PM -0800, Tim Harvey wrote:
> Add gpio-line-names for the various GPIO's used on Gateworks Venice
> boards. Note that these GPIO's are typically 'configured' in Boot
> Firmware via gpio-hog therefore we only configure line names to keep the
> boot firmware configuration from changing on kernel init.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

It doesn't apply to my imx/dt64 branch.  Could you rebase?

Shawn
