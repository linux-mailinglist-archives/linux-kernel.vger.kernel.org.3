Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B30468E67
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhLFBHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbhLFAxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:53:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4212DC061751;
        Sun,  5 Dec 2021 16:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C83C36116B;
        Mon,  6 Dec 2021 00:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A06AC00446;
        Mon,  6 Dec 2021 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638751815;
        bh=ZIrJ8Sj6l0vGlRpq0iuVAk7FNpEBRKPDC12cLJZxv0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwdTAs0FVZwpw72JBwblqtwyCyURRux5BMC1sCY1HoFnFpK6iVh1bZve2ktP7foJn
         UheDQkPFceFz2JJACm79mpRiic8Xf88lrIiSc9TR1XAiV2AIpzR0UsnWDd7Fgotc9a
         4KYOU7+qZOo5wpLzziFo4qMyungH6k+Ju1a70r3Ggd8l3cfqsAnOeN2FbW9DtHQgBB
         s4XveuAKAGWszLRYm9ew4vU5m2YR0bmANx9G/KhN0/IvqH/YGI3OH/Myde2ktmJSmJ
         kAziVpoz4RtDB3QjmFzRNVYoqMtZF9hKYRLkIDLnZWBQhTTMhv/BWtKEef1cpR4qF3
         v4XWdbQgTRRWg==
Date:   Mon, 6 Dec 2021 08:50:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add an entry for
 JOZ BV
Message-ID: <20211206005008.GH4216@dragon>
References: <20211122101917.1643563-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122101917.1643563-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:19:15AM +0100, Oleksij Rempel wrote:
> Add "joz" entry for JOZ BV: https://joz.nl/en/about-joz/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Rob Herring <robh@kernel.org>

Applied all, thanks!
