Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AA756603E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiGEAum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiGEAuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:50:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F0102;
        Mon,  4 Jul 2022 17:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9EA7617EA;
        Tue,  5 Jul 2022 00:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0B4C3411E;
        Tue,  5 Jul 2022 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656982236;
        bh=ICm1TCJKrTszOgEn1hHpXR9pNd9AusgVG5NTjNFfNLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1XCugCzbg00N6Au13ME/W3/ql1hyrtVQnFdgeU7rhz4tgHgBikAxfqvL42ygwV+k
         NA3UMEnyLyZJ81FIQUgrUT2qb6l0nuhYl+fuoi4jo6NIgfShrr5cZ4ziw852PxBl5Z
         ClK5GuA/HRWnvmsvDiif1oeWF61TsVLlfTM+6fHXMeUO4btc4EewbEPHgpiNlj6LUe
         PQT55+5E7ts0+iUaRC1oe+Sh4rY8M4yznUW9EWA0fDcVmdWy5OstrC3T47GKnFqAHQ
         500+d3Y41glSfqHJgGZoq9CQLEhl6RGboERMKA3YrwqDbyu8ZiRDNAclnf7N/hQRYq
         WHP7ZLsi74/lQ==
Date:   Tue, 5 Jul 2022 08:50:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kris Bahnsen <kris@embeddedTS.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count
Message-ID: <20220705005029.GQ819983@dragon>
References: <20220630210327.4645-1-kris@embeddedTS.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630210327.4645-1-kris@embeddedTS.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 02:03:27PM -0700, Kris Bahnsen wrote:
> Device-tree incorrectly used "ngpio" which caused the driver to
> fallback to 32 ngpios.
> 
> This platform has 62 GPIO registers.
> 
> Fixes: 9ff8e9fccef9 ("ARM: dts: TS-7970: add basic device tree")
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>

Applied, thanks!
