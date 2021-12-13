Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F29472113
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhLMGc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhLMGcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE1C0698C4;
        Sun, 12 Dec 2021 22:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 70A29CE0DE4;
        Mon, 13 Dec 2021 06:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DE7C341C8;
        Mon, 13 Dec 2021 06:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639377126;
        bh=wIJOaRCUpxM5XJhKAVLGF6sfIt89cAXKaCYHscYHThc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfGvXd6AV+eWkskM1NYY/bhcDdqJw+hO4finO/Gp/+3zrofpLlImkSH5j7lVnl5mY
         ELAqLjhmtJlWpjMTm2UWM5Ci1JhKbQCC8VpILd42IlWdrNhcA4pWERmky1ak0WygXj
         exVgcZgai16ZzZ52RFtUlsLuEz7Gn9CndEbMFDU0=
Date:   Mon, 13 Dec 2021 07:31:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "andreas.noever" <andreas.noever@gmail.com>,
        "michael.jamet" <michael.jamet@intel.com>,
        "mika.westerberg" <mika.westerberg@linux.intel.com>,
        YehezkelShB <YehezkelShB@gmail.com>
Subject: Re: [PATCH] thunderbolt: check the return value of kmemdup()
Message-ID: <Ybbo3qBRpCR2Cl93@kroah.com>
References: <tencent_1AB342AE1B4723454E78A4D2FD3F33C81306@qq.com>
 <Ybbj470ocCf7bj68@kroah.com>
 <tencent_D34525AAFF71905A66815C118E0E8A96F007@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D34525AAFF71905A66815C118E0E8A96F007@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:27:28PM +0800, Xiaoke Wang wrote:
> On Mon, Dec 13, 2021 02:10 PM, Greg KH wrote:
> > kmemdup() return NULL when some internal memory errors happen, it is
> > better to check the return value of it. Otherwise, some memory errors
> > will not be catched in time and may further result in wrong memory> access.
> > 
> > Signed-off-by: xkernel <xkernel.wang@foxmail.com>
> >
> > Please use your "full" name, I doubt you sign documents as "xkernel". :)
> >
> > thanks,
> >
> > greg k-h
> 
> I am very sorry about that, my full name is "Xiaoke Wang".

Great, please fix up and resend (also fix the From: line in your email
client to show that.)

thanks,

greg k-h
