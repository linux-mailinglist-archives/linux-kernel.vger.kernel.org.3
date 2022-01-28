Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE849F456
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346790AbiA1H32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346789AbiA1H31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:29:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF12BC061714;
        Thu, 27 Jan 2022 23:29:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7750CB824D0;
        Fri, 28 Jan 2022 07:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692A3C340E0;
        Fri, 28 Jan 2022 07:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643354965;
        bh=eZ35IEF6zpm0kOMJqKFK+o80ETAHLjEXyNmLK8DT/wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCGFtbOLmgMLW28eG2AcesUEWAclfvVduXRRMrfiVwS8Q2dh3xlfJUoGXWu36GUww
         c4z6m6fMkdporDdvpdJqpdWpNDiwu4bCd/l7NwL2L6KY5nfc5T3fCTdSaQhhVl4DMl
         11puc3KUVAq9C2kjBa7oLDFeI9J4km6wIkcacbTxjkRShUlzXgpH60OKz65SFEhwya
         WZP4NPDkwlzx0OOnhS1VCcjjcFJjjXiFsfr4qMcas6fx37Ph2w3PyHj4Od3/MdEjlE
         h2nVZxksdX+chAx7BvGQiCOddRFXs56OnmOqAY1DtJDh7PiANhEdPcngnWqR7VpGNM
         m/s2zpKQbIiog==
Date:   Fri, 28 Jan 2022 15:29:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: imx8qm: Add SCU RTC node
Message-ID: <20220128072918.GF4686@dragon>
References: <20220103224900.1439756-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103224900.1439756-1-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 12:49:00AM +0200, Abel Vesa wrote:
> Add SCU RTC node to support SC RTC driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks!
