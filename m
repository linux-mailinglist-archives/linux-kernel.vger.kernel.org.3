Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E052481C09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbhL3M1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbhL3M1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:27:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CBAC061574;
        Thu, 30 Dec 2021 04:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F3B76168D;
        Thu, 30 Dec 2021 12:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1D8C36AEA;
        Thu, 30 Dec 2021 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640867268;
        bh=VJ282ssHcoqNUg3SeZeEklixHEqnQib91Mu2AwIeAE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0nqmz/a2HzM9e3A3QG2PlphqUhNNmc5AL0O0DEnBL5sQF+Zm/bKkS8m/USVjIrC7
         Tz+Dvm9qA5VFSpW62bE9pN141JENaVqGDY4JOnBxMBFbpxvMcnBFrYEVJAWuMt4SM6
         sgrx4LGTsHGPlWH3stjiRs2BZYnmHRaR7uYdPIxg=
Date:   Thu, 30 Dec 2021 13:27:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate
 calculation is described using the common clock code. Also added S4 chip
 uart Compatible.
Message-ID: <Yc2lwhYKQ03pGho3@kroah.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-5-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230102110.3861-5-yu.tu@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:21:08PM +0800, Yu Tu wrote:
> Using the common Clock code to describe the UART baud rate clock makes
> it easier for the UART driver to be compatible with the baud rate
> requirements of the UART IP on different meson chips
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---

Your subject line is very odd, please fix up.

thanks,

greg k-h
