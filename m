Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7A8481E53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbhL3Qpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbhL3Qph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:45:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C112C061574;
        Thu, 30 Dec 2021 08:45:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EB3616FF;
        Thu, 30 Dec 2021 16:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA4DC36AE9;
        Thu, 30 Dec 2021 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640882736;
        bh=kdssX1byXxDeDWcE2+JpAQwaEjllqvPxeFbjcqxyKuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfVYl6pPHWLruTmlhVrgr4GdkrFUU8Felvxf5zxVCjLfhmZVqAhgQeOlJbl3kKuUL
         wiCseSwR5Btl1bKASzhEJ5fqZwEe7SOxg0Wg7sVvXA5m5LLCfkOqREOo5aB2FlPD0Q
         gZFsvDyxOTQaBpj4LnoUfM8WB/+1naA/yILoUg84=
Date:   Thu, 30 Dec 2021 17:44:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 00/23] counter: cleanups and device lifetime fixes
Message-ID: <Yc3h+fROLZwTFoOU@kroah.com>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 04:02:37PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Dec 30, 2021 at 02:19:25PM +0100, Greg Kroah-Hartman wrote:
> > Please rebase and resend the series against my char-misc-next branch.
> 
> this series is just v3 taken via b4 to collect the latest acks into
> account and then rebased to Greg's char-misc-next.

That worked, now queued up.

thanks,

greg k-h
