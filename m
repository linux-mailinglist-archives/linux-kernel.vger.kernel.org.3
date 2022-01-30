Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30A14A32BE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353519AbiA3AIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:08:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353509AbiA3AIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:08:21 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCCFA1EC0501;
        Sun, 30 Jan 2022 01:08:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643501295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yfhFxfxF8NarSX8GHfOcK6wOuYA4m73EaIxZ6XycAIA=;
        b=gTFuF04FbxNGeU3WluPjOgb/UNacljz4S4fCeMcP/EKIhMF5ssl0FZpaZzivrCKXZcRLy1
        tTTR0ZmrPlnFzmSI7VosAv7/9iO/NQfhISayfyTeUAEjPGg8u5j7TU7qBUEDx+fVTsykVh
        LCaWqJA3yJZUodFqMeAIdub3FgvFTW0=
Date:   Sun, 30 Jan 2022 01:08:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the edac tree
Message-ID: <YfXW6+1hTVVTodeI@zn.tnic>
References: <20220130103712.391407a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220130103712.391407a7@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:37:12AM +1100, Stephen Rothwell wrote:
> Fixes tag
> 
>   Fixes: 0d4429301c4 ("EDAC: Add APM X-Gene SoC EDAC driver")
    Fixes: 0d4429301c4a ("EDAC: Add APM X-Gene SoC EDAC driver")


Somebody ate the trailing 'a'. Fixed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
