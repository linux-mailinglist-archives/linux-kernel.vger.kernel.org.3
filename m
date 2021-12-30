Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A599481BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhL3MS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:18:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhL3MSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:18:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA2BB61696;
        Thu, 30 Dec 2021 12:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7932BC36AEA;
        Thu, 30 Dec 2021 12:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640866733;
        bh=ZmhNNEovTSCg7JZmbQ+oNEu/8HfxroskblP4ABJoAi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C678eFJzgcBh8duCr707xJdUo1E70QEyS66Zrvk2RR5z8mCcDJVbzg9fkU5rnf9Kp
         gUeSHcSEXLBQnYif8qUdi5YK8tuY+YbF5bmTfDxe9i4fbRR9u/Lw5mnHD/7s4gKw8y
         CD7DOJJHstykreXXRTe18ab9HfB2StCj+HpxA5Bs=
Date:   Thu, 30 Dec 2021 13:18:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <Yc2jqlV8LDR56oxy@kroah.com>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
 <YcCmaJkeKy+R0mhF@kroah.com>
 <CAOX-t54j9=7eLMAx4n-ngiNdM=Ab=YcK-zdxRW88e41cPS=46Q@mail.gmail.com>
 <YcGOmzKSHOoycZNC@kroah.com>
 <CAOX-t55fBM7u3qZm7ubLANDnWNFhCiBXB29v00racWd-gy3OgA@mail.gmail.com>
 <YcWL4c0e02mzETMp@kroah.com>
 <CAOX-t557bRfBk0+ixH_zXkxpt54cf96vNc1Fq7yNejVLOrc--g@mail.gmail.com>
 <CAOX-t55bGWY99r0=SYcMgUBpSCHRznHk3KFrtScq9X_J+8boyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX-t55bGWY99r0=SYcMgUBpSCHRznHk3KFrtScq9X_J+8boyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 05:21:27PM +0800, hammer hsieh wrote:
> Hi, Greg KH:
> 
> I am still not really understand why you said the driver looks like 8250.
> SP7021 SoC have our own register define.
> That's why we submit a new serial driver.
> 
> Refer to:
> https://sunplus.atlassian.net/wiki/spaces/doc/pages/1873412290/13.+Universal+Asynchronous+Receiver+Transmitter+UART

Odd, ok, I thought this was an 8250-like uart, why did they go and
redesign all of the register values for something as well-known as a
UART?

Anyway, I think you are right, please fix up the other issues and resend
the driver and we will be glad to review it again.

thanks,

greg k-h
