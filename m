Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCD4921B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiARI4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:56:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233210AbiARI4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:56:09 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EDBA1EC018C;
        Tue, 18 Jan 2022 09:56:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642496163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eAf1qbOkyIy1iU8T03DAQ6VYhyVjg5pw83Zn0LL7X/k=;
        b=o+ZTpYGj0sqS5+8hg20lRWbuYojBrLFmZDgT3+T2OYDnmdIPVhvSfGnwhN87IAZPyv/J8I
        umJDtvSmnDAdkjVFwLZ1rrQ6cmS0gO+w8htLK7r/N9Ny7hWpVbQBpW+UHY1Z6IrD/eHd/x
        5ENmLNlOKrqvrwShHLoYkwjW3r+lMi8=
Date:   Tue, 18 Jan 2022 09:56:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     cgel.zte@gmail.com
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers/acpi/apei/erst: remove unneeded rc variable
Message-ID: <YeaAofH7UrvaDOfa@zn.tnic>
References: <20220118075349.925694-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118075349.925694-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 07:53:49AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from erst_get_record_id_begin() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

"Well, this doesn't look like an e-mail address of a physical person
which is required for S-o-b tags."

https://lore.kernel.org/r/CAJZ5v0iipOm6DX3Fd8iNKF_LC6kJWCy=1LxFsh47z01UYDrRow@mail.gmail.com

Are you people actually reading email feedback or you're automatically
dumping this crap to recipients without even looking?

Because if so, we can automatically send all that crap to /dev/null and
the only thing that's going to be wasted is the energy used to send crap
mails back'n'forth...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
