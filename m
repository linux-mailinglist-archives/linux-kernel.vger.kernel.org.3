Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8847047A26C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhLSVtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:49:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhLSVtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:49:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B202212B5;
        Sun, 19 Dec 2021 21:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639950585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zvDmaVjQ80d5brzVbw8eRo/ezcVk8K0qcbYiKum8ias=;
        b=eFdfOUkgoOtNT+BNZOHnIpkUKc5fBWIXYZTP3Hxm91Ij0xv7BcoUuY/BeCDs7ZQfDKGc61
        60FZ/6SoBBNDPA7I/uIbuZoVVsbTTKF5CJP2RWqkQ48a66pK3RfceIKnDFX76U7KL/AlLI
        goLpuVWpXmyGsfpytIgOk/p8wNvzmj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639950585;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zvDmaVjQ80d5brzVbw8eRo/ezcVk8K0qcbYiKum8ias=;
        b=iQwLBE28iUe8IyS074Jk7BGMM+uQDFLjIaQtQyDehMC5pg/c14RGvjCgPdV95N2AI/5aAH
        1hdYTt1EPVWuiJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 602221377F;
        Sun, 19 Dec 2021 21:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lJwIF/mov2GsPgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 19 Dec 2021 21:49:45 +0000
Date:   Sun, 19 Dec 2021 22:49:47 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <Yb+o+3nq5LswWUdU@zn.tnic>
References: <20211220081428.7184c271@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220081428.7184c271@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 08:14:28AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   aa1701e20a84 ("x86/pkey: Fix undefined behaviour with PKRU_WD_BIT")
> 
> is missing a Signed-off-by from its committer.

Thanks, I keep forgetting that but I've fixed my "git cherry-pick" alias
to add --signoff from now on.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
