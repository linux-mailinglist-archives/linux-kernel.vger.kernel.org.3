Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF047E3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348398AbhLWMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243742AbhLWMq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:46:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C1C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:46:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C711B81FE3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 12:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D0AC36AE9;
        Thu, 23 Dec 2021 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640263586;
        bh=NLkJd4huS6QSaYfeSeIMWzAylR/uQWfKDP6VJw3AnIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEuHmv5RxbM4z7Rr+g+rlWWT/ydYOvTS9Iiv50wg65QX02zQIGt0zIaWHNgQ5O9qh
         eLLeZMEh7C3UjH1B6WmG8gbFkKGqdfU7apHDcTiqpGUjFmfB0dBku8XqDh2HgM0Utv
         LBoew/6uD2wH7ooPh/VWdif84HeRyk4DxTzfL7S8e7wK0WyXpyEfJelBz3njoGpDfL
         rj/Wq3sk+Etx0+3AiczS2K02ZrPSlkyN11YXQCB53v/wNLT+HR/Plv80gk2FYvZEDO
         Nm4N+U8nh5OBFxDttRSYsuvexO+QeLiLzNhx4y2abOvvPtvUCUU2KieSgz9WRUsfxB
         GDv2s4dvVFHSw==
Date:   Thu, 23 Dec 2021 18:16:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: uniphier-usb3ss: fix unintended writing zeros to
 PHY register
Message-ID: <YcRvnh8EJUm3itVl@matsya>
References: <1640150369-4134-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640150369-4134-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-21, 14:19, Kunihiko Hayashi wrote:
> From: Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>
> 
> Similar to commit 4a90bbb478db ("phy: uniphier-pcie: Fix updating phy
> parameters"), in function uniphier_u3ssphy_set_param(), unintentionally
> write zeros to other fields when writing PHY registers.

Applied, thanks

-- 
~Vinod
