Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE847AA57
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhLTN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:26:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43510 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhLTN0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:26:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2848EB80EA4;
        Mon, 20 Dec 2021 13:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4112C36AE8;
        Mon, 20 Dec 2021 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640006794;
        bh=4VYTojJtxt2UikXelqFd6Tayw4q2QDNFfZkN3VoUI+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGFur7hAkWQfVQ5g73amaOOrzd936DgYzbIkwY6H5NIZerhYQfNyAAUpLhzUUp7Nm
         vZadRTY9FL0T62grP0tPtlXohfsmu+aqzGdssBVXBJ/AomgnhztJtClkv6rnyD2F7m
         wWsYaPZV2zjkPbVENYh6bhpSS+ZGKfmxfpyRShms8ArBchIw6O7rwo2u2qpcY3U+mg
         sPCEGFZrt7QqtMxDatbfGeZSRW6g1M6qusQxgYyCCyRrfMSjkwUnAaH+bloZES85l5
         iKj0lDgIy1WHzupp3iZkzOmo2tHwlBwWCQkyi5/B25dwEDAzmH2/1PbTNpSOq7c+5w
         mq763j6tH2Z3g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzIgN-0006Nx-Rf; Mon, 20 Dec 2021 14:26:27 +0100
Date:   Mon, 20 Dec 2021 14:26:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marc Ferland <ferlandm@amotus.ca>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gnss: add USB support
Message-ID: <YcCEg0SGIEY7ljDV@hovoldconsulting.com>
References: <20211220111901.23206-1-johan@kernel.org>
 <YcBz74iw4nJFpV1f@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcBz74iw4nJFpV1f@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 01:15:43PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 20, 2021 at 12:18:59PM +0100, Johan Hovold wrote:
> > This series adds a generic driver for GNSS receivers with a USB
> > interface and a first device id for the Sierra Wireless XM1210 receiver.

> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing.

Johan
