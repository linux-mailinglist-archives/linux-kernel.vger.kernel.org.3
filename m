Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D332C4F5FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiDFN3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiDFN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:28:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6B3165A8E;
        Tue,  5 Apr 2022 19:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8000BB80EEB;
        Wed,  6 Apr 2022 02:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416D7C385A0;
        Wed,  6 Apr 2022 02:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649211499;
        bh=3G8zBGA3k02iW2vlIOk2MDsWENaPWSPkarGi0setVns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUwdtI7jWnMPOeNTRXjeO8J+M6yKUb5QuUQiDdVXN09GKgoJCM62Na7NvzGBKRHjc
         Vw07aOQzE/tXGK3qd+D8toUq7flwOiwA3AOcxCqMiFtIeZk/BpY9ihC2OPE+2k3Pnc
         /m20o96RXMu4hWmukDTa3rYlYoknHxDHMRHha0f6AunOQ3xpMkODJISmccL3A6RQZR
         ZX12u3A0vIsAORQvo2Gmep+2+3HNYq01pmmt/mzB3sUJdtk74SkoSGfNB5pMyX0SnI
         NQwiv32LMoYOnznDzaKw6slv5csAOAaan14nwKJeORd+eoYNDqDxPyty77hRFZ8O06
         JZ03yrXvHcDyQ==
Date:   Wed, 6 Apr 2022 10:18:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 8/8] ARM: dts: imx6qdl-victgo: add CAN termination
 support
Message-ID: <20220406021812.GM129381@dragon>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
 <20220221095312.3692669-8-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221095312.3692669-8-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:12AM +0100, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> The gpio1 0 pin is controlling CAN termination, not USB H1 VBUS. So,
> remove wrong regulator and assign this gpio to new DT CAN termination
> property.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
