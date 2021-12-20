Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2847B0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhLTPtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:49:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38870 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhLTPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:49:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E66AFB80DE8;
        Mon, 20 Dec 2021 15:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D94AC36AE7;
        Mon, 20 Dec 2021 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640015381;
        bh=YiPyKgRvSofShZtLAX+L3XWk+t+HQ9ASQI8Q9w6noFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeCqEM2NAQ48Zcc6w2Ua1D91iRvzA/2Ts6JQDFnP3e6Sm25/JmzVOMMvNPUBvGkt1
         4zil8BKsgsO8b8YXn+2nlqooSTGqdVs6QPVO8h2tRWXqMt/X3McibrR7ACo2tMNFIZ
         Jz50KbZ4+KlfIMqtf6glvwqHWnLkvnZhr34OVcP8=
Date:   Mon, 20 Dec 2021 16:49:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <YcCmE0PCXHcd6pjp@kroah.com>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:10:07PM +0800, Hammer Hsieh wrote:
> Add Sunplus SoC UART Driver

Why is this a new driver?  It looks like a 8250 variant UART, right?  So
why can't you just use that framework instead?  What is different about
this hardware that requires a new serial driver at all?

Please explain the hardware here in the changelog text to justify why
this is needed at all.

thanks,

greg k-h
