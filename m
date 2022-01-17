Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE027490714
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiAQLVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:21:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39806 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236242AbiAQLVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:21:21 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FFEB1EC0104;
        Mon, 17 Jan 2022 12:21:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642418476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeV65Fz664fmTImlJb8/LzFUK3RXVfK/m1eYkH8q78I=;
        b=eAHKJdpFEB/3ycHvb0aAkErK98zCr/x1yV17FTlzbQhCfMtNGEBVCK11LrpgsAUvnRV4ee
        N8Nw6G7wyYge2QrmR9RNx0UkLtd90GU8mC9JJgsF/R6GNQXM296pqSavVc8wuZq5b/v4xE
        feMw3okU+g5JuUUBSRJ/v72Im59DkWQ=
Date:   Mon, 17 Jan 2022 12:21:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: RIP: 0010:radeon_vm_fini+0x15/0x220 [radeon]
Message-ID: <YeVRMvAViydZnMGl@zn.tnic>
References: <YeLyToEyBFnQqQGB@zn.tnic>
 <1049939c-422f-787a-7481-21a2598eeedd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1049939c-422f-787a-7481-21a2598eeedd@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 08:16:09AM +0100, Christian König wrote:
> Interesting to see that even that old stuff is still used.

Well, "used" is a stretch.

This is my way of testing on K8 as pretty much all the big K8 boxes to
which I had access to, got decommissioned so this baby is the only K8
real hw I have now. :-)

Lemme test your patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
