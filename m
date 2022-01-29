Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36864A2C19
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiA2GPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiA2GPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:15:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A02C061714;
        Fri, 28 Jan 2022 22:15:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC1F3CE19FC;
        Sat, 29 Jan 2022 06:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B23C340E5;
        Sat, 29 Jan 2022 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643436933;
        bh=37FbC17DlgaNGObxnVfDz3/68vRL+XAhVunNTu6zNFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2HnvLnFmABJtkwlrLmd0aVDrTbOSWfOD61u7k56tVnTNsEeyd84JxKkuh5SUcA11
         xWAy0VdCGb9Hq+1zjt1s5wbMdKBDNtUWcMld3vgIP2/RDaN3/b4dhzH8SReSv2X5mT
         qatGDvL13aUO63ZMWP+ttRspmpKcmYoiROiKwATEIgSB169a+xojEYVvFV2O/VLKjJ
         ZgIZSu/LaaZsLrbV24OPkP3p0o+kPmwNiZhChOY2gyzszo4yh7srDX8MlmubbVrhMI
         pVDbeav9Xy6QDveXRbJqj+aCVoX+CJNYj0FlhFXF1c2DxFiNsjVz/yXzYqPfVfKNd+
         GhsJGqFypYrfQ==
Date:   Sat, 29 Jan 2022 14:15:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8qxp-ss-adma: Drop fsl,imx7ulp-lpuart
 comaptible
Message-ID: <20220129061525.GR4686@dragon>
References: <20220118135918.2126010-1-abel.vesa@nxp.com>
 <20220118135918.2126010-2-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118135918.2126010-2-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:59:18PM +0200, Abel Vesa wrote:
> The driver differs from clocks point of view, so the i.MX8QXP
> is not backwards compatible with i.MX7ULP.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks!
