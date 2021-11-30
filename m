Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD244632A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbhK3LqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:46:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35322 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbhK3LqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:46:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7C6EB81840;
        Tue, 30 Nov 2021 11:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F9CC53FC1;
        Tue, 30 Nov 2021 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638272576;
        bh=Rrp25mW+TaaRYcxIJ0GGqapkNzwTLiEGrd01+DD2wRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DlZaxwYuKaP0xOCgKVNx8SmY3HoUV/3GnPREXrU1JS4KKOIS2CBQD6Xz2gCpzFxbQ
         bp/phpSRnw48/2ep7W0xZ5JJWEIDd2u6wCw9DPPNgUnJiTVmn1A++xVrOwmXD1rb63
         YJnrQmyYVNf8FCmhPXye/Xre4p0FZEl1rOaDonXk=
Date:   Tue, 30 Nov 2021 12:42:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, benh@kernel.crashing.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Message-ID: <YaYOPgzv6hGyXLYg@kroah.com>
References: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
 <20211130113847.1405873-2-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130113847.1405873-2-neal_liu@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 07:38:44PM +0800, Neal Liu wrote:
> +Ben.
> ---
> 
> Support qualifier descriptor to pass USB30CV compliance test.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---

The way you wrote this means that everything below the first --- line
will be cut off if it were to be applied.

That is not what you want.

Please fix.

thanks,

greg k-h
