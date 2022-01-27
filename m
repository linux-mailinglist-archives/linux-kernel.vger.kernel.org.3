Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96549DA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiA0G1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiA0G1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:27:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7779C061714;
        Wed, 26 Jan 2022 22:27:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 26B39CE1F68;
        Thu, 27 Jan 2022 06:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0B0C340E4;
        Thu, 27 Jan 2022 06:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643264831;
        bh=QGqOz4ZDf4nVB8gL1AxXDvBSwWaWQERKk7xslRGJ8rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8g/ED00AlAbfrHbrjW1D6kuHCe75G7Xly3p68HemZwwRPYWHYrX8WEtcGLzgrKPP
         /5MFO93D8fkkai/b3aylIb0Yp2bmdtSSvKmqsutvH7I5T64NlqAPEf1a5/jgZyMam2
         sG2n+9lmxc9u+inuFV3dVPv68gEOuYy+q8UKN8ZxyPIDEF6M0yfTUScmDYkGKXsGij
         hhVm611wRHGhvRGKZ3z4MFUKV7DULybRKHCW8BTURRUMs9ULDYGQjHHhJfR82ad0/Q
         1N4/DevuBv7nCdqlLGIhg2Iufc/ve03MxR6VnugwlU+lkBQ6PxTZMvlQqxjovKbxgJ
         qHCd1R2tOD8jg==
Date:   Thu, 27 Jan 2022 11:57:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     kishon@ti.com, p.zabel@pengutronix.de, balbi@kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org, khilman@baylibre.com
Subject: Re: [PATCH v6 0/3] phy: amlogic: fix shared reset control use
Message-ID: <YfI7O5EvRI+m+QAj@matsya>
References: <20220111095255.176141-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111095255.176141-1-aouledameur@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-22, 10:52, Amjad Ouled-Ameur wrote:
> This patchset fixes a usb suspend warning seen on the libretech-cc by
> using reset_control_rearm() call of the reset framework API. 
> This call allows a reset consummer to release the reset line even when 
> just triggered so that it may be triggered again by other reset
> consummers.
> 
> reset_control_(de)assert() calls are called, in some meson usb drivers, 
> on a shared reset line when reset_control_reset has been used. This is not
> allowed by the reset framework.
> 
> Finally the meson usb drivers are updated to use this new call, which
> solves the suspend issue addressed by the previous reverted 
> commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared reset control
> use").

Applied, thanks

-- 
~Vinod
