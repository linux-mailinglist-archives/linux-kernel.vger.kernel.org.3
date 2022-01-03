Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126E8483413
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiACPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:19:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41078 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiACPTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:19:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7D64B80EFE;
        Mon,  3 Jan 2022 15:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE290C36AED;
        Mon,  3 Jan 2022 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641223190;
        bh=vDf6qmhzEBKFLfj+F6lRDdM/GpyjlMr/3XWDDnCvtOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6fERXFYb4zI57qjE5urZFuqS6K4mxKRfxeUfrk/tA5M33XJQdQlsc4+PCOi7AbBL
         iS+cDRUq2IGCx7Tr0L647zOOwRvaww7vIPcyWFXrQYJvK618Klh/5CKS75kh4kx5Xm
         XXZkifZdf7aFVbCIuXLzSeQ/kRTmkcFrmJgJ5ffQ=
Date:   Mon, 3 Jan 2022 16:19:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: Re: [PATCH V3 1/6] tty: serial: meson: Drop the legacy compatible
 strings and clock code
Message-ID: <YdMUEzStFf99EeQ5@kroah.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-2-yu.tu@amlogic.com>
 <CAFBinCCwjS36ss_4sU+o9m8gEprFsVZbqcxgpQxczTNohZqFdA@mail.gmail.com>
 <a296e666-368b-4cd5-427e-30fc66a15b49@amlogic.com>
 <CAFBinCA2V=sx95Q=+4nLDXFK1Os11XVWtK8KauxixVwYXLUz1Q@mail.gmail.com>
 <3865f01c-83f7-a69d-6835-c26f662629b7@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3865f01c-83f7-a69d-6835-c26f662629b7@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Jan 03, 2022 at 03:59:33PM +0100, Neil Armstrong wrote:
> Hi Greg,
> 
> Martin just saw this patch was applied, but the serie wasn't reviewed enough and it will break
> earlycon support on the ARMv7 Amlogic SoCs fore 5.17.

Ok, what should I revert?

> Anyway, I'll push the corresponding DT fixes for 5.17-rc1.

How did we get out of sync here?

> Would it be possible we also receive the notification when those patches are applied ?
> Maybe a MAINTAINERS entry is missing so we can receive them ?

That would be good, so that people can review the patches.  Otherwise I
have to just guess :)

> It would help me track those TTY and USB patches more easily.

I recommend MAINTAINERS entries for drivers that are not listed and that
you care about seeing the changes for.

thanks,

greg k-h
