Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401094F5ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380528AbiDFJdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579852AbiDFJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:20:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED31B2C46;
        Tue,  5 Apr 2022 19:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BFAFB81FB5;
        Wed,  6 Apr 2022 02:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478D5C385A0;
        Wed,  6 Apr 2022 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649211284;
        bh=7oxtU6dReocTjrAPtmbWJeUxLA98brvJonekBTXb0r8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pglIEobHodK+J/xTI/lixv4yCnW3MqVBTFnJgba4A4VhII6Y06FqiyubCK0sOnIOH
         McKjnnN9eT9TDs2PFrrqJVuGdMjZiMwkYwU4rSX6pRy2N0VasXk4BkhB+408IWIzRR
         EFsu/3EMzxbXtwIkxGPyhYqBwEQNKk0OEP/EhG3Qkedsn7V/q8kjMeaKjGdHEQE+6w
         49qrJ9N3TR6OKitMwIP7aYT/FHaDpHp4ogIy6kc1MPd2aqPhzDPb1h7bIfkgTOTYeK
         +9hdF4FwdtTZUdAIOs6v+pWuCGWYpE6RkLeMaULPbcalB6lEFAvwQRVIy9MfhLv08V
         SDagjTCxDyt+g==
Date:   Wed, 6 Apr 2022 10:14:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 2/8] ARM: dts: imx6qdl-vicut1/vicutgo: Rename
 backlight to backlight_lcd
Message-ID: <20220406021437.GH129381@dragon>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
 <20220221095312.3692669-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221095312.3692669-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:06AM +0100, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> We have two backlight sources on this boards. Use more specific name for
> the LCD backlight to see the difference.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
