Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5447B018
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhLTPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbhLTPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:24:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA16C08EE2C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E17C26113B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D08C36AE7;
        Mon, 20 Dec 2021 15:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640012665;
        bh=VFNKgYieykLoFcky+hSZpBKn6wJR54wZW7OAAY3J0sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDsqZDClbb3klOzXjL+OV2tvhAZFejj1C/vtwFGzXee1Mq4noy3uVJNE7UHz4VnQY
         E4OyBMrtYEOGs2WmQRF45qfrhoYB5EMYN8Uxn762vA787qnnTLK/KYuZRuIOXwN2Ab
         kFpolvO/sSX2fSwDxx69rM/s/oYIxNOpZTUFoYKw=
Date:   Mon, 20 Dec 2021 16:04:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable CONFIG_RPMSG_TTY
Message-ID: <YcCbdkHcto8O7ymx@kroah.com>
References: <20211220144748.23695-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220144748.23695-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:47:48PM +0100, Arnaud Pouliquen wrote:
> Enable the RPMSG_TTY driver as module in multi_v7_defconfig.

That says what you are doing, but not why this is now a requirement and
you should do it :(

