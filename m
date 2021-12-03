Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA846753F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351635AbhLCKn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbhLCKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:43:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F5C06173E;
        Fri,  3 Dec 2021 02:39:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A550C629FA;
        Fri,  3 Dec 2021 10:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E14C53FC7;
        Fri,  3 Dec 2021 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638527998;
        bh=xfnVuiPmR/ebk9nO736NA9ijLyAQXSePj6AH7oroEz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERP0LcHyngBoLMJVnr3cE59l8MCGi3nurdJliGNQCxLwkQW1hf+Bmtf6zv80ua+SO
         nsN8lJ4DAJmhi93wk6CdCg5EnNYOq1/+/0EUwN62AtTbT9L7Z3vo4RIPGaMfD1IuTa
         /hHE21O8XH++UGXJi1DgXkd+f6DLLyqr+6/padPU=
Date:   Fri, 3 Dec 2021 11:39:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Yanz+1nOCthAq/sN@kroah.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:48:45AM +0800, Tony Huang wrote:
> --- /dev/null
> +++ b/drivers/misc/iop/sunplus_iop.c
> @@ -0,0 +1,518 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Are you sure about "or later"?  I have to ask.

Also, no copyright information on the file?  Are you sure about that?

thanks,

greg k-h
