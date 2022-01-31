Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837194A4806
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378672AbiAaNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:25:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54294 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiAaNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:25:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89830B82AFC;
        Mon, 31 Jan 2022 13:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD075C340E8;
        Mon, 31 Jan 2022 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643635524;
        bh=6cJEJGctXWg2ouM0AW7ItCpTitZ5jZpRhQHIutezKfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeLbkLH6CgxPzavN+y1x/PZsXep/NIzZf854UHtRB1Ns7ysCS6yWOzNKa8USejqFj
         w0zslfJAWtCcljNBqEEQWDm/3h6NMcUsTCR0Lp9MnlAiXGZUidc8BEBbZlsW0yTNjS
         /dY8k7xAgv6T73620+KnNWo1795gVJfNHZ5B3eKY=
Date:   Mon, 31 Jan 2022 14:25:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yunhao Tian <t123yh.xyz@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: audio: fix indent
Message-ID: <YffjQcKiI4gVVeW3@kroah.com>
References: <20220129023753.1494755-1-t123yh.xyz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129023753.1494755-1-t123yh.xyz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 10:37:53AM +0800, Yunhao Tian wrote:
> This fixes indents of f_uac2.c and u_audio.c introduced by
> previous commits.
> 
> Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
> ---
>  drivers/usb/gadget/function/f_uac2.c  | 16 +++++++-------
>  drivers/usb/gadget/function/u_audio.c | 30 +++++++++++++--------------
>  2 files changed, 23 insertions(+), 23 deletions(-)

Does not apply to my usb-next branch at all.  Please rebase and resend.

thanks,

greg k-h
