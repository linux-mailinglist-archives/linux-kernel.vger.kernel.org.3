Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BA4A2C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbiA2G7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:59:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47122 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241669AbiA2G73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:59:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E1160BBC;
        Sat, 29 Jan 2022 06:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFB8C340E5;
        Sat, 29 Jan 2022 06:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643439568;
        bh=ZPTxWZwBUS/Xa5K43LPLu5fC9jzUrxlpXwWUqtiXjwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdjTfrB3VnsmoEBWkH+Zq6DlG758IBpRXOOl8s4tlKbNS/8vTNDU+iYqj/d1XH+SR
         sWm8D8l8jQ76dIwJ7KtkXfZ1On7Fy62JOQ6DekL/knd1qcRFgvNDgjwPiRpQyVY09a
         J8TPotZX1cKbbyX3Pa1HHLpW1uJL6bwwhesY642iEoaM4siuDHEksR4CPRtc9gnJkS
         fFhnYLrCXCKV58YmXxkvkYxjYMB5rOKkl4O1lOBvx0tCZbS+YonC94jh1xRYuEgK5G
         SLGZXP9aBSfpkcUOhwpmBcjSuV+0Jv9C7VUSQ0rtCyHJslRiyIVfr52GG56ittEF4q
         lO56X8ajDF/Yg==
Date:   Sat, 29 Jan 2022 14:59:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: imx8m{m,n}_venice*: add gpio-line-names
Message-ID: <20220129065922.GX4686@dragon>
References: <20220128010603.17620-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128010603.17620-1-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:06:03PM -0800, Tim Harvey wrote:
> Add gpio-line-names for the various GPIO's used on Gateworks Venice
> boards. Note that these GPIO's are typically 'configured' in Boot
> Firmware via gpio-hog therefore we only configure line names to keep the
> boot firmware configuration from changing on kernel init.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
