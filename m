Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C80E516554
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349664AbiEAQnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349589AbiEAQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:43:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9F2FFEE
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 09:40:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 980CD1F385;
        Sun,  1 May 2022 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651423203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKGbRsinZKCYeLI+oG1j5JDW3QLOhJqB2Wu2s/wLY1Q=;
        b=MGEfRKnFDHnJknaXyw5dsjEJ6WLCSHHdwbDlmYXt/WTGIysJgALh4KN4vH7Y8VqNcNJ5Br
        VKAjyDB0hT9tWfUFC2KOHjQQD14PapfB6Q3znOIrFA4SDgfOX+lZxVjvqjP3Rl0A8bx0Ky
        8lIVyGJA9t73ARKPzyuDyvyTTwxVilY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651423203;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKGbRsinZKCYeLI+oG1j5JDW3QLOhJqB2Wu2s/wLY1Q=;
        b=xaC4b5oRyl1vEtw1umsqPVlmAeSuJdKWll5ESKa/+4Ny/lP3NiwKYL0OkC5kL/fVK0CqM2
        AfwfoSpm097R77AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C9EF13AE0;
        Sun,  1 May 2022 16:40:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6BRNIuO3bmLcfQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 01 May 2022 16:40:03 +0000
Date:   Sun, 1 May 2022 18:40:00 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Ozgur Karatas <ozgurk@ieee.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] irq/urgent for 5.18
Message-ID: <Ym634CkF2JKoFu6T@zn.tnic>
References: <Ym5vDU6KFdzYaTAo@zn.tnic>
 <CAADfD8ypPRzja3RU8QGwBNc=MiN1H3OLHjHVgnJ6h1fFPO2dhw@mail.gmail.com>
 <Ym528eZ5kb2geWwx@zn.tnic>
 <CAADfD8yk0-soyYt+qQ8t=unAoQ4ytL3b2Xv=h66ojYheYMa=Nw@mail.gmail.com>
 <Ym6BgmOY4zxlbiIx@zn.tnic>
 <CAADfD8zJEkx-P1jGtDu1Nb9vyQYDeVZryMSL+H7qZDT4ifbm-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADfD8zJEkx-P1jGtDu1Nb9vyQYDeVZryMSL+H7qZDT4ifbm-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 08:25:44PM +0400, Ozgur Karatas wrote:
> ops, now i realize that i thought wrong. thank you for your kind time,

No problems, keep at it. :-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
