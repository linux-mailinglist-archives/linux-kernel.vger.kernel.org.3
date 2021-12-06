Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878B54690A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhLFHIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:08:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35240 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhLFHIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:08:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11EF0B80FAE;
        Mon,  6 Dec 2021 07:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E298EC341C2;
        Mon,  6 Dec 2021 07:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638774286;
        bh=CsAT3BKK6v7c59EIZatHrdaRG9z4nq5/YZXAeBiLxMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHUjvzQQY3rfYDtAyN8U3++DMYdpI6njFb3CF6YCZn70KveEaEP2UjFN/FUhd0PpA
         Qc6q/msFUfDCBBjU/y11pfIAveG/MP6jv7JxXzgyfrUJeL58U9AOE4m3K8KOGIX6Vb
         EJuZvRJXE/AAfyCkZw9VwMXeHyitOkTsLaN70SzA=
Date:   Mon, 6 Dec 2021 08:04:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang =?utf-8?B?6buD5oe35Y6a?= <tony.huang@sunplus.com>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Ya22CT1pRO6NCYrC@kroah.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
 <Yanzu7/J75n/OCUY@kroah.com>
 <4bd765590e3e4a5da2cf79be921bac5b@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd765590e3e4a5da2cf79be921bac5b@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:50:03AM +0000, Tony Huang 黃懷厚 wrote:
> > Also, no need for a .h file for a driver that only has one .c file.
> > 
> 
> I need to keep sunglus_iop.h. Other files will use
> sp_iop_platform_driver_poweroff(void) in poweroff flow.

What other files?  That is not included here, nor should other drivers
be making that call, use the normal poweroff logic.

thanks,

greg k-h
