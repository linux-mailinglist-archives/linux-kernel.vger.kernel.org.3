Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795C456B447
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiGHINO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiGHINJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:13:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4387E034;
        Fri,  8 Jul 2022 01:13:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A9AD1FDCD;
        Fri,  8 Jul 2022 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657267987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O72/ULjlx1PPQxVgkKAhi3HE1nEYzbRyfStC39U6aww=;
        b=XvIyS2rnvR1sDwnGj6PqQ0qU1WcH6P5xyL1PttlBCTFSs1sS/RDyIRgY/dlv75tgVSeRXs
        5QIZ+S/riisSa8RNJFeVtxgcpGElifbkEhrIkaJSZ+OsaGMuDdmrTIcTu3eR4Ti+UBCtz8
        ruHn2kcGFY1NyZ4vDxIWhzMB46b7ruE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657267987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O72/ULjlx1PPQxVgkKAhi3HE1nEYzbRyfStC39U6aww=;
        b=hvoQFgVOf/qzagXOrxMRqCJabbNmSMKTxATQ4uzLWrs2xtna62JpY859zxethlufWQm8DF
        CJREkEXrSFjPdzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DAD813A80;
        Fri,  8 Jul 2022 08:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MGWPIhPnx2J5JwAAMHmgww
        (envelope-from <bp@suse.de>); Fri, 08 Jul 2022 08:13:07 +0000
Date:   Fri, 8 Jul 2022 10:13:03 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan McDowell <noodles@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the random tree with the tip tree
Message-ID: <YsfnDyOaKXA3iIj4@zn.tnic>
References: <20220708171030.135b12cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220708171030.135b12cd@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 05:10:30PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the random tree got conflicts in:
> 
>   arch/x86/include/uapi/asm/bootparam.h
>   arch/x86/kernel/kexec-bzimage64.c
>   arch/x86/kernel/setup.c
> 
> between commit:
> 
>   b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
> 
> from the tip tree and commit:
> 
>   c337d5c7ec9b ("x86/setup: Use rng seeds from setup_data")

Why is a x86 patch in the random tree?

And it doesn't even have a single x86 person ack?

https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=c337d5c7ec9bc1d11006fd628e99c65f08455803

This is not now the process works.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
