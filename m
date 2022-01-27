Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468C249DE36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiA0Jhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:37:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37006 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiA0Jht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:37:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DFBDB80C9F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D2DC340E4;
        Thu, 27 Jan 2022 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643276267;
        bh=W1zbMWs4f3PzTaEU2FjlPr9KdGXRGkxlTC9ie8d2lPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yr10iEa8cv4ElDOnXj2wmINHGYLpDqW1iQWeE1eWCb9uNw7EsmYluWaaL5N/Mt2NM
         U16RZ8aU1hW7sOojMPdVuKLLCfrpto1nzGUz0lFgvZZIVmh81MfL/nTn5zbykDaWk4
         WkGLJXAcNIbgWAFFUhmFqcx8b+WCPKoLL89KHsXY=
Date:   Thu, 27 Jan 2022 10:37:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ralph Siemsen <ralph.siemsen@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: at25 eeprom driver: NULL pointer dereference (bisected to
 af40d16042d6 ("Merge v5.15-rc5 into char-misc-next"))
Message-ID: <YfJn48rLw9/U38BP@kroah.com>
References: <3887fe1b-58ac-902d-a4ef-1f8825d55aa6@csgroup.eu>
 <20220126193816.GA3763305@maple.netwinder.org>
 <17598be4-c5f5-c9ae-ee24-652fc06f36ce@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17598be4-c5f5-c9ae-ee24-652fc06f36ce@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:32:06AM +0000, Christophe Leroy wrote:
> 
> 
> Le 26/01/2022 à 20:38, Ralph Siemsen a écrit :
> > Hi Christophe,
> > 
> > On Wed, Jan 26, 2022 at 07:18:42PM +0000, Christophe Leroy wrote:
> >> Getting below Oops on boot.
> >>
> >> v5.16 is OK, v5.17-rc1 has the problem
> >>
> >> Bisected to af40d16042d6 ("Merge v5.15-rc5 into char-misc-next"), bisect
> >> log after the oops dump.
> >>
> >> I'm a bit puzzled to end up on a merge commit, that commit doesn't show
> >> any diff with 'git show' but has a huge list of changes with 'git show
> >> --stat'. I must be missing something.
> > 
> > There is a mistake in the merge commit. The fix is here:
> > https://lore.kernel.org/all/20220118182003.3385019-1-keescook@chromium.org/
> > 
> 
> It fixes the problem, thanks.
> 
> FWIW, you can add to that patch:
> 
> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks, but it's already in my tree and will go to Linus in a few days.

greg k-h
