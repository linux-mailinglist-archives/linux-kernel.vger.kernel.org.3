Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA164B335B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 06:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiBLF7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 00:59:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiBLF7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 00:59:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8C28E3E;
        Fri, 11 Feb 2022 21:59:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19D9BB82E5D;
        Sat, 12 Feb 2022 05:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005A0C340E7;
        Sat, 12 Feb 2022 05:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644645565;
        bh=zLYnKwrmxContgPMNSvT01cnK3yvmL4L5GqzxNmXjFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFJ2zzxnVvATjyri9ahDPNXdedhKIq0LT0Mh/m4DEbZQI2bhDBE59PMt6Ga+ng/oz
         qIcy3bBL7gl1VNKUBSF+HwCSWBElR+dmIAfQHGo25TzxeaF/j4Nyvw6RyK5OEaUveS
         nKVvGT9hvefQjW6oMcFz6UIz7v5Zh98JFf4dyCgDhK2psvdOEuTTS6cQJQNWWsUeiZ
         bDnCyDCfo4gBlXq6lC+Qlp541xpM2RmuZAhDBCWuhoCAymJ2P0NYW9VqjDbOID1JaI
         sA7CxU3f+hTwje1iqvMn/nEZW5v7xCESEByqK/MJV0k4mKb5qbodbE7PRM8BRLlgz4
         AP8+cjqv8vAkw==
Date:   Sat, 12 Feb 2022 13:59:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: Enable PCIe
Message-ID: <20220212055918.GA4909@dragon>
References: <20220205173102.970040-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205173102.970040-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 11:31:01AM -0600, Adam Ford wrote:
> The baseboard supports a PCIe slot with a 100MHz reference clock,
> but it's controlled by a different GPIO, so a gated clock is
> required.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
