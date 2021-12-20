Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F047B092
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhLTPrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:47:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43010 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhLTPrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:47:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4253460F66;
        Mon, 20 Dec 2021 15:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10912C36AE7;
        Mon, 20 Dec 2021 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640015258;
        bh=/rCaxqAWmSPF6bgIb91XkfHAO0nEiJikOYhnYpfin1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/sU1Jfl5CTHoACqPcird5dybEhrBsBe/A81GhhuBYk2+mu+dCsWkWh5HQvJ4PYjr
         uv9p71rQl+0cL2cVi9rc9jtkfUSIqhjDBzYnuOZfzbUOMtVjxke18bQ1A4JfpuiVFI
         gn1LRVwpFFHYhpVC+AJAnCHuLhVIWJyikowBMFKk=
Date:   Mon, 20 Dec 2021 16:47:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <YcClmM4KGMHJVQVi@kroah.com>
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
> +/* Sunplus UART */
> +#define PORT_SUNPLUS	123

Why do you need a new number?  What userspace tool is going to use this?
Why can't you just say you are a normal 8250 device?

thanks,

greg k-h
