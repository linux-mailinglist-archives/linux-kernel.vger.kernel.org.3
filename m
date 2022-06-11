Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A645474B1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiFKM6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 08:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiFKM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C055236;
        Sat, 11 Jun 2022 05:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA3060EF2;
        Sat, 11 Jun 2022 12:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5ECC3411C;
        Sat, 11 Jun 2022 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654952307;
        bh=i8gkB3aP+oJNKqiLP5odmunqccfUTZCZWuLHGtWjCww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOuH766UF0coPQsxcOPyMK7XmpUbw1C2zKBNjthKAcigu5d11YFtQ3V44TBtVikqB
         LLhEJbvkMFAzFLidXkV6NOyM6P6yGSAvvzC9KIZJXkCvi/CFpuSFjcndCBMPr0v3u5
         6Xg37YoeXhS+LJs/QnrVleZtjC0U2P4mVmu8WhczEYjJog3g1MGH2GWsiGmymRiTSO
         RMFbO55456///8boX+1spX1EJugjXstmZd7Qgx+grfxkrO6Kc2KwpANxWgijFBAULX
         572lMqTlZ5CXGDn4D3Hxsg36iASXPRMUoo9YEB3rrEhEyu9KSAK0+MyUzqxEzEFkz5
         wgti/3E8yZ4ig==
Date:   Sat, 11 Jun 2022 20:58:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Simon Holesch <simon.holesch@bshg.com>
Subject: Re: [PATCH V2] arm: dts: imx6ulz-bsh-smm-m2: Support proper board
 power off
Message-ID: <20220611125821.GJ254723@dragon>
References: <20220517135342.2458267-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517135342.2458267-1-michael@amarulasolutions.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 03:53:42PM +0200, Michael Trimarchi wrote:
> From: Simon Holesch <simon.holesch@bshg.com>
> 
> Supports initiating poweroff on SNVS_PMIC_ON_REQ signal.
> 
> Signed-off-by: Simon Holesch <simon.holesch@bshg.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied, thanks!
