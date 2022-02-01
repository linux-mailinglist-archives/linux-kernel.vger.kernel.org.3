Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63C04A5A04
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiBAK2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:28:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59076 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiBAK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:28:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52055B82AD7;
        Tue,  1 Feb 2022 10:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3E4C340EB;
        Tue,  1 Feb 2022 10:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643711312;
        bh=a5iH1+irwmlNbzz5dEW7GnkthauXg9AbM44bHH9PhlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDGqOWUyKiCBBY5btTHNthl/iG6n4pxs8InaLzg/lOXzoTHZS9PDo7Qv3HU46wKdR
         0r9vvNoknHnhvnhSL4190JunqchQqpO4dvDdgKUpDP1Hx4lylPdaW5cMdSnm60xTpX
         ERUaez3nnfEuaHPmETzEFiwwpaPHweypjNKenvvc=
Date:   Tue, 1 Feb 2022 11:28:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: typec: Support the WUSB3801 port controller
Message-ID: <YfkLTU95pqog7254@kroah.com>
References: <20220201032440.5196-1-samuel@sholland.org>
 <20220201032440.5196-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201032440.5196-4-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 09:24:40PM -0600, Samuel Holland wrote:
> +++ b/drivers/usb/typec/wusb3801.c
> @@ -0,0 +1,445 @@
> +// SPDX-License-Identifier: GPL-2.0+

I have to ask, are you sure you want this "GPLv2 and any future
version"?

thanks,

greg k-h
