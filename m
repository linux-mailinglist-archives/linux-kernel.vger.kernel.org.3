Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA949DEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbiA0KJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:09:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52268 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiA0KJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:09:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C6B61CB3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DC7C340E6;
        Thu, 27 Jan 2022 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643278139;
        bh=CjgfnKCUXCgE+sPBD6QLLmJdl+2z0gfy7GhTQpNGo9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJrWFI/tbmTazNW/QpYsc6WNg2YsPDMzb1QbyY2oJuvc/C++1f3hS1ZpIlDFkg8LE
         OiA4HCbAHT8B2Z9AGqJJ7dqFpV7aZT/yIoSaaCE/HCBnfkX2aodp5eEweinWphpqq6
         xXWhXJfXdLuES0tVp6ezzunjmTQIc9g6nhUccT6Q=
Date:   Thu, 27 Jan 2022 11:08:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksa =?utf-8?B?VnXEjWtvdmnEhw==?= <aleksav013@gmail.com>
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: dio: Fixed coding style issues
Message-ID: <YfJvOO+YKRDR35BJ@kroah.com>
References: <20220126195341.5154-1-aleksav013@gmail.com>
 <YfI7rZrYn4liKuPB@kroah.com>
 <20220127100414.o3hj63sirlavyb33@artix.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220127100414.o3hj63sirlavyb33@artix.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:04:14AM +0100, Aleksa Vučković wrote:
> Hey,
> 
> I made a really simple patch fixing coding style errors.
> Could you please review it, and tell me how to prevent errors like this:
> 
> > - Your patch did many different things all at once, making it
> > difficult to review.
> 
> from happening in the future.
> 
> Should i split changes into 2 patches? One for upper half and one for
> lower half of the file I changed?

One patch per type of logical change is recommended, the location in the
file does not matter.

> Many lines have multiple errors, so if I fix one error, I also need to
> fix the other one.

That's not a problem, and is not why your previous patches were
rejected.  Your previous patches were rejected as in your attempts to
fix coding style issues you added new ones.

> So I can not just have patch fixing one thing at the
> time. Should I try to fix error in this manner:
> [PATCH 1/3] fix lines that have ONLY spaces to tabs error
> [PATCH 2/3] fix lines that have ONLY braces error
> [PATCH 3/3] fix lines that have spaces to tabs error AND braces error
> or should I have a different approach?

Look at the examples on the staging mailing list for how to do this
well.  There are thousands of examples of "do only one type of change
per patch" out there.  To ignore the work others have done is odd.

> Sorry for bothering, this is my first time submitting patches.

Please start out by working in the drivers/staging/ part of the kernel
when learning how to do development, as that is explicitly what that
part of the kernel is for, and it keeps other maintainers from being
bothered by basic functionality and procedural issues like this.

thanks,

greg k-h
