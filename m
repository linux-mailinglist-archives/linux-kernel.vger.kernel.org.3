Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2F54257A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiFHFPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiFHFOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09102283B5B;
        Tue,  7 Jun 2022 19:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48F426168C;
        Wed,  8 Jun 2022 02:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F91C34114;
        Wed,  8 Jun 2022 02:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654654500;
        bh=c/e1sOuA6klxiqnvWzptb4rhAJvuaJyK44XprMYbx7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLzWQ5iZ3/vo9igWNi5FbPs6CCf6CMH4O53OXKPt90FmBxfc3uxQYmaRHd2Fxomdp
         9KOwzbZgrbPX/wLlMhB+FAIVbQINGcxxJk/pjbS3WdeXp+0eCFpg9XaW2onviNHx1d
         LGhYQ5el6S96YLSFKanX06ZDdP7WlTxic7804QA1lUqW4e6fMrnSfaREEMwPYLv4Mq
         cVxevY5fP1O3lrZIIRwaONobX59/7uUiDONaSyV72WNXmajfJpL96eH+mFNNATPDO/
         akkrbRCbEy7RtVXeM36xY4rBJQadGIHJ2+gl9KEJbT8jhR4hIL0oWIQGbRU/3a+MjA
         aKrOZKCvyVAJg==
Date:   Wed, 8 Jun 2022 10:14:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: correct 1g vs. 1gb in
 toradex,colibri-imx6ull-*
Message-ID: <20220608021452.GA254723@dragon>
References: <20220506145720.291735-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506145720.291735-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 04:57:20PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Correct 1G vs. 1GB typo.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
