Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95478473F18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhLNJPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhLNJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:15:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8129C061574;
        Tue, 14 Dec 2021 01:15:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82259B81819;
        Tue, 14 Dec 2021 09:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6E5C34611;
        Tue, 14 Dec 2021 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639473318;
        bh=0ua7a0P5Qb99uXLH+QLXAxhupeEjIa/HPPxoFbbexMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9MvluaJOsnSUAfdqNXRqmWgCLffOEBXR0bzTnsG4La8COFZ/hw+mdzb7Fvm+F8xA
         90yJ9zV/cUMFs6MHSMlibd4weDKBsfXoQCKO7MFKRmcb/5Mrr1+BhYsEAc/y9fMPqf
         SWJrNnKxR1IQ5kTehMtHnu7K2ZFynClTHfHwKwacFZYQ9/vBDboR9BBnWhhJFgXKPo
         w5Y/m+72CENxLRSZN2jotImZ5R1KmeBKhJ/ZoGKV99YUYZkG8ivRlU3WsE8n08z5G1
         OfqsFpSzgGhmZNKAI8Hh7Vu9RZsqytCs9JZsOtwvYw4MTcob6Y53L7iZu3z9aJ5Rq9
         EMMe75aZ0NjyQ==
Date:   Tue, 14 Dec 2021 14:45:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip-inno-usb2: remove redundant assignment to
 variable delay
Message-ID: <YbhgorXaTSgUaFyF@matsya>
References: <20211211180054.525368-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211180054.525368-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-21, 18:00, Colin Ian King wrote:
> Variable delay is being assigned to zero and the code falls through to
> the next case in a switch statement that returns out of the function.
> The variable is never read in this scenario and so the assignment is
> redundant and can be removed.
> 
> Cleans up scan-build static analysis warning:
> drivers/phy/rockchip/phy-rockchip-inno-usb2.c:753:3: warning: Value
> stored to 'delay' is never read [deadcode.DeadStores]

Applied, thanks

-- 
~Vinod
