Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFF1586F40
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiHARGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiHARFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:05:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA1D62C9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:05:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7AC220634;
        Mon,  1 Aug 2022 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659373538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6I/7Xudpo9uyQTJeE4rIipY7XkQX2Qoo0Kxq81TZjk=;
        b=Q9hq4u4UnzalSgsv1QfuPeqhSWN0l/figyd9zH5tO9JZ+QXM20iQTfYjPJCykM15yxC27c
        RNtXzkgJFQgQCavfZMjAtlu85rduwjKjUiXkFbvaHXTJyfSR/iE//fBB2kV5Zbda6Aip9Z
        l7eiUCfYouprGg7ZlGKgkJGSYaGt7I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659373538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6I/7Xudpo9uyQTJeE4rIipY7XkQX2Qoo0Kxq81TZjk=;
        b=cwwY0PyOeKUhZ6VG4Z7MmQJTbhRXlC+8Yh4ns59IPtBIDudFEtyUCXlOwRTQ3bMsjSPniy
        vL6yP4q5frBb51Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA7F313AAE;
        Mon,  1 Aug 2022 17:05:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lxRKNeIH6GIvHgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 17:05:38 +0000
Date:   Mon, 1 Aug 2022 19:05:34 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/cleanups for v6.0
Message-ID: <YugH3pmzmRm7eoa2@zn.tnic>
References: <YueXA90ePDFY7mKf@zn.tnic>
 <CAHk-=wiy+R8dW4RCV4-1ydh-JTy+4LCn4BbqNvBqxshDtp-XGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiy+R8dW4RCV4-1ydh-JTy+4LCn4BbqNvBqxshDtp-XGA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 09:34:26AM -0700, Linus Torvalds wrote:
> Hey, I like boring.

In that case, you'll like a couple more tip pull requests this time
around.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
