Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5296465D52
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhLBEYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:24:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34402 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355334AbhLBEXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:23:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC33CB8221E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EB1C00446;
        Thu,  2 Dec 2021 04:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638418775;
        bh=SOAozQIF+luS66u+i8c/hscFZWQwcThBt1+hqRfufUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3LNTyZlfrKU0Vrqc/xSzov6qt690gCjpAvx1bT5JTUNmf9U13mXWPExDL2BZk+M8
         9wef3iWBfGonx//M7I/f7lZmAs1fyPd4bGONvGdFQuZt4j0ZGV5jQ9sgWN8ry9Xcp1
         d/gyljtJrsu58DW8+rGAtqpA/QzeiUdMs4EEqu/cKjCwrFNpMorlxbriWLv15KxMld
         K38U6GOB1/JfB9a2wJ0ejpAnIaz6d6h1IedR4lmEniUB7PuBhmKJodtrkaiT/vIXlQ
         ph9ymKGUv5Ey0HNho90Op4osqGYrK7M7eavzuJLYP4c5b1huduaHbaWgb0deY+Lo1V
         aXEdTtT0QGNYw==
Date:   Thu, 2 Dec 2021 09:49:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, linux@armlinux.org.uk,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: lan966x: Extend lan966x to support multiple phy
 interfaces.
Message-ID: <YahJU1B8YP/o4j0C@matsya>
References: <20211130101015.164916-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130101015.164916-1-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-21, 11:10, Horatiu Vultur wrote:
> Currently the driver is supporting only the interfaces QSGMII, SGMII,
> RGMII and GMII. This patch extend the supported interfaces with
> 1000BASE-X and 2500BASE-X.

Applied, thanks

-- 
~Vinod
