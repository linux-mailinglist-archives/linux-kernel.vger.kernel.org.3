Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2877C486E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiAGAUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbiAGAUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:20:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96157C061245;
        Thu,  6 Jan 2022 16:20:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 526F661C55;
        Fri,  7 Jan 2022 00:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5513C36AE0;
        Fri,  7 Jan 2022 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641514821;
        bh=LPZoZva39qia0NK5/RjsftEgY/50mELNLWNvxMkHfQk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Y5sm2IP3HHJr5yOfFnN68NqA8DQhtBu2hLRHjGPfpezLQK0uYuVquaeNBhB7aGKPX
         2pJ0DbJOsRdcMZm9hrZCEFixvs/p77yLsPwk69K22RQjQFL05JhaFzrChtzfkT8Jnw
         ql8F6XGr22N5krz5p1rMSokMqNpBkkNwsYWwj1GqLbbby4GYmaXToHgLeWQ3ksD6Br
         dKja9ugX+R3A/u8eYvhY/CyXaE4hS//uRJ2CaKTvTvP5fCKK/QBChkCwW3ePx1vjbl
         lXZOrI43740elH/dJbNomo8B1De4ooVePyH/hawgu/nekWMh3qwYav+ukz7gmc/Js7
         /tPLE8ZfPX7vQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220106182518.1435497-1-robh@kernel.org>
References: <20220106182518.1435497-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: imx5: Drop clock consumer node from example
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Thu, 06 Jan 2022 16:20:20 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107002021.A5513C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2022-01-06 10:25:09)
> The example nodes have different sized interrupt cells which is not valid
> given no interrupt-parent is specified. As provider examples don't need to
> show the consumer side in the first place, just drop the consumer node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
