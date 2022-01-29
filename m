Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876174A2D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbiA2J5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242507AbiA2J5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:57:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2591FC061714;
        Sat, 29 Jan 2022 01:57:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6AB3B81053;
        Sat, 29 Jan 2022 09:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEB3C340E5;
        Sat, 29 Jan 2022 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643450265;
        bh=+/w0lj0M85M3FUPm3gEbcFJs4MkikbYYvFx9h0qpSMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLKoK/qPyYdNQhfjsOldKx9jzuXCFLRDibjjIzzuuo0mTf3aqydeyBJ7hTpbtx3t7
         J8wJX0V6vYqK65FgZ9MxQpREPkdf+HTr7ER8wKSC7ftdGy95qioFpp3W/DCltC6u1R
         bEiLjk0zkDlrqfMckNhkiBv4SFHKD6hBSorTrx8c=
Date:   Sat, 29 Jan 2022 10:57:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] tty: serial: possible deadlock in uart_remove_one_port()
 and uart_hangup()
Message-ID: <YfUPlYwoWpMjhvpR@kroah.com>
References: <ab5d9322-6bea-9845-c61b-fb68e3bb3a87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab5d9322-6bea-9845-c61b-fb68e3bb3a87@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 05:34:05PM +0800, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports a possible deadlock in the tty driver in
> Linux 5.10:

5.10 was released over a year ago and over 100 thousand changes ago.
Please redo your check on 5.16 at the oldest.

thanks,

greg k-h
