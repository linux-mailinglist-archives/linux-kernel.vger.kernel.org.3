Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9415473ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhLNIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhLNIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:55:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEF9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:55:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A09761362
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17510C34601;
        Tue, 14 Dec 2021 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639472106;
        bh=c5bIKjhU7AKff/gZKhxbNUDAZ9nnvhaiyTZKD0N2dLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSAaA1w06C2Jf1Auu+C/Z5TKIUF2vNve6t5XVeE2nA7HJfuTkpa2o8yUJjOVyzGFo
         3pRSBgL437qQoY7bFNswuOyDDAypsXvnLF9NpidTERpQo1wE3sOMWs9YM+wVLPXh+K
         /5MPZ4/rqD6KiIIg9lVdU7OAHQymCnxIm+9LCX9KOrO/kQ0lVa5kW0gmv1ORPhc+Fd
         gtiR95y5ObnFhCR8tBxM5nGu72T59jl2ABeeLOR1sKDDBfExnub0m4UJsgYP/2MRHn
         RjWqT97FxsOspaEo+2VVYLzepiSnB4NmuU5BkrrV+Ym0idX4BanZnZ/Xn6FmHwe3TJ
         vtHO5kcmQhkIw==
Date:   Tue, 14 Dec 2021 14:25:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, linux@armlinux.org.uk
Subject: Re: [PATCH] phy: lan966x: Remove set_speed function
Message-ID: <Ybhb5uTlpOhpRf3o@matsya>
References: <20211211214717.1284306-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211214717.1284306-1-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-21, 22:47, Horatiu Vultur wrote:
> Remove the set_speed function and allow the driver to figure out the
> speed at which needs to configure the serdes based on the interface type.

Applied, thanks

-- 
~Vinod
