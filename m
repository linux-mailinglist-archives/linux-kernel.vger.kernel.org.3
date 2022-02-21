Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978244BD41F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbiBUDOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:14:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiBUDN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:13:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4F37BD1;
        Sun, 20 Feb 2022 19:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 199FD61073;
        Mon, 21 Feb 2022 03:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13FBC340E8;
        Mon, 21 Feb 2022 03:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645413216;
        bh=dMIhkpYCVHP3+nawjfIlJW9qUQ4oyOkisr8xmmB4UBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdVdkeG47nvAWC8FnsVd0OjnQIZ/xglG3BCOeqcgL+FOM6BqnYsWO6BPaDCI5ncSQ
         0GpCE+ESi57AcdYbxREc1fKmQuEGiosyrb5KFY8Ye0z1ofKvqksUSfl7GOCzTwUmjA
         gIYRGYnk5cOHwonfIQzhPx7uMtimsi7Pguw7D19KJornRxjhUK5Ah5qljtv/HPGW7+
         Dct/TlZ84Irl8E9/fYoTi6T4drKKKc1xYdrlyVVJCsOdFaXMKV01bVAFzjcD+K3JcI
         /kv12pYoyVHgg4NtPRWzMN4E9qYIrpsFYPmAkHooHjawbQ7XLEBbLuOGJcHfHRRcDP
         7Oedta8RsFVpA==
Date:   Mon, 21 Feb 2022 11:13:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8qm: added more serial alias to dts
Message-ID: <20220221031330.GE2249@dragon>
References: <20220209155055.19856-1-oliver.graute@kococonnector.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209155055.19856-1-oliver.graute@kococonnector.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:50:55PM +0100, Oliver Graute wrote:
> Add more serial alias to imx8qm.dtsi file
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>

Applied, thanks!
