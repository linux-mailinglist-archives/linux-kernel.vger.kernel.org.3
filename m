Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292DC5ABC2A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 03:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiICBuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 21:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICBuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:50:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FBE32072;
        Fri,  2 Sep 2022 18:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D3A6B82D0E;
        Sat,  3 Sep 2022 01:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271FCC433D6;
        Sat,  3 Sep 2022 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662169802;
        bh=8zH5gxI+OIaTvPBN8CtiW/C2Ma0B/x4cCp73Xma/fEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ns1UreuYUsfeuPQ0FmWblT6aa5nDkwiyEFPfYAsoYlq2UvJ7avgcxyIj42LVS7IKi
         tsivupa7Cge5HXGGxefYJL2q/zqk950Y1aZxpFhPYUTyjKxI2K6jcnwnxu7zhluaL3
         0I2VRL1W0fPy5SmoIiue2iL4g785xA5AbObWvx1RpEajEM7/aNR0d6Pd/CZvo0b3zK
         e0r7HWZ/eoSLJphKrXPlhne3WE62yUNDQTIoBxdigjConynaGrrYmkSMRRTWnAnZiy
         tOdJvtq45WUgl5lP+hJW0adqVWyzawCoQG9YNpe64fP+yAK9+3RjMEorpPEkGGV5VO
         h33+aPm2ikSkA==
Date:   Sat, 3 Sep 2022 09:49:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-verdin: add cpu-supply
Message-ID: <20220903014956.GB1728671@dragon>
References: <20220822075342.2611279-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822075342.2611279-1-max.oss.09@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:53:42AM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Add the cpu-supply property to all CPU nodes to enable the cpufreq
> driver.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Applied, thanks!
