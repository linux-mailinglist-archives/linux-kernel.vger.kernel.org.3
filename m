Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9456481663
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhL2TgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhL2TgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:36:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7899C061574;
        Wed, 29 Dec 2021 11:36:13 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2152A1EC04EC;
        Wed, 29 Dec 2021 20:36:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640806568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zjGGgf4vZZGBZVnZreISFoCZqG7IYDBjGCqaWzTVoMk=;
        b=GhgVNrNqF4r5fxtQbTMOSG5ybd6nCwCXz3ahY5zMQC18G1WGI0IoxD8ZS2Pi28SoVUrO0W
        FBZN/PZ9+ONMHjcs+5GhiGYKXucq8lMtVHZFcCuiUBDZkBYD1yxglEOd2JCGw7m1Uft1XF
        xOljKyIknJ7Ydnlv5xanBSiMBlPS9Dw=
Date:   Wed, 29 Dec 2021 20:36:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: use the proper name CONFIG_FW_LOADER
Message-ID: <Ycy4q2OhwTdLl+2S@zn.tnic>
References: <20211229111553.5846-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211229111553.5846-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 12:15:53PM +0100, Lukas Bulwahn wrote:
> Commit c8dcf655ec81 ("x86/build: Tuck away built-in firmware under
> FW_LOADER") intends to add the expression regex only when FW_LOADER is
> built-in, not a module or disabled.
> 
> The config is called CONFIG_FW_LOADER when it is built-in; and
> CONFIG_FW_LOADER_MODULE when it is a module.

$ git grep FW_LOADER_MODULE
include/linux/firmware.h:37:#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))

So either I'm not grepping right or that FW_LOADER_MODULE thing belongs
to the past...

Greg, Luis, what's up?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
