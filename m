Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42BE473E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhLNILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:11:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36434 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhLNILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:11:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B1FDB8172C;
        Tue, 14 Dec 2021 08:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D8C34601;
        Tue, 14 Dec 2021 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639469505;
        bh=5X1v+ZC31dDevWkuoDLSrjyETrgJ6WGs+ZsJZlLVjXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SguaaNt0ULlCypQ/OjPRRnBj1btpkBo8nJrSMPzd3X00e8VReiVEk6e0EPAH2Wijz
         Ahhk4JUPXJvKzYQpZSOoDjowZGhxhX4s+dAMGeAbtxG858UZ4r4z3euWQs5cSyz8t9
         h2spMMS6rLabL+EDKEiuwxPs3sts6eV6IKcN53EYOh/7IUejuuFK/cw/Z/m0QY0WvW
         hlltE0bCnUPerH1VWi5SU7Cx+bJTcCkZwCyoZmSNlJHEaD6QeuA4SJipzvJx7ufyE1
         Q63ecvKeEemVECYyDqG/LiXVdLvznSoXxQZJyBWVfbCAagmzOZUBNb/DNSisoZG07S
         a9RrCyFMnspNw==
Date:   Tue, 14 Dec 2021 16:11:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq-evk: link regulator to VPU domain
Message-ID: <20211214081139.GB14056@dragon>
References: <20211205210144.1072721-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205210144.1072721-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 03:01:43PM -0600, Adam Ford wrote:
> The SW1C regulator powers the VPU and the state isn't guaranteed
> to always be on.  Link the VPU power-domain to the regulator to
> ensure it is turned on before using the power domain.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
