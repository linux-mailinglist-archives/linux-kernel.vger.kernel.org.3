Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531BA4A2C22
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242201AbiA2GaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:30:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46346 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiA2GaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:30:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64DD260B82;
        Sat, 29 Jan 2022 06:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C18C340E5;
        Sat, 29 Jan 2022 06:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643437806;
        bh=n5bRWi0m5mJ6YjL6XrHyZXTFrOPN0+5O+FbZQVdAgPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZI12qGVt31IQWCnO7uDi1TjfJAq2qD+zjCb3tPNHbBRymbf32zuHSnyX4JEVvEY/
         SFR+fDlDGetyMW0CD6rTNVVXVmOG2bqyGgjXnByUMP7sQzmS723mLW12VrRkqke4IY
         IwBNfhpf6TZz3v3QAFn1/Qn8g4eG3fRuzIYiIXo7yAzNCcFFqnf1eF4xEkkBXhEbko
         uRtVrFvmBc3Gxs1pmZa/3y8HFxKg7RgX1cM1oQOfMYXn3YmCi2eQ0kZIBcCJRONn02
         V8EGHr+9wXWrpFmNq4nKbaRyKeO7WB9Sjufhbrv0S88NkL44Ao6RT9pogakKhBD7K7
         Hlct81a10Ol4A==
Date:   Sat, 29 Jan 2022 14:30:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] arm64: dts: imx8mq: fix mipi_csi port numbering
Message-ID: <20220129062959.GU4686@dragon>
References: <20220121093326.2388251-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121093326.2388251-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:33:24AM +0100, Martin Kepplinger wrote:
> hi Shawn and all interested,
> 
> This is a fix for an embarrassing bug that slipped into commit
> bcadd5f66c2a ("arm64: dts: imx8mq: add mipi csi phy and csi bridge descriptions")
> and commit fed7603597fa ("arm64: dts: imx8mq-librem5: describe the selfie cam").
> 
> When preparing the imx8mq.dtsi description I only tested with port@1
> being connected to the csi bridge, but what I sent said port@0.
> 
> I have this on my list for a while and want to sort this out now. I'm
> sorry for the inconvenience. Until now imx8mq-librem5 is the only user
> (maybe because of this :).
> 
> thank you,
> 
>                               martin
> 
> 
> Martin Kepplinger (2):
>   arm64: dts: imx8mq: fix mipi_csi bidirectional port numbers
>   arm64: dts: imx8mq-librem5: fix mipi_csi1 port number to sensor

Applied both, thanks!
