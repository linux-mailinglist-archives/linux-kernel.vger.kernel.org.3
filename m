Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27E58512C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiG2Nzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiG2Nzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:55:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDF166AF0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:55:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA47E2100F;
        Fri, 29 Jul 2022 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659102934;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMxPr0Lef2neweoLGsYk7K3Rnge938US2kNI8g1jvs8=;
        b=MER5t0Tu+UFMApl6c0ph1SFAM6AnFJ1rmJP7zkKQXqUc9/p9pNz1O7/IZwjOp9Y4PJ3Ot2
        kqld92mpg0yHmBRcKAU7lNBxD5P+vZBxfzP8zMm8hcQnijZUvHxP/QPt89O04mX4FV4bBw
        1Zbfr1YyieqTiVwt6QZEuXhId/HrVRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659102934;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMxPr0Lef2neweoLGsYk7K3Rnge938US2kNI8g1jvs8=;
        b=a5reKtOqwU1PwgT/9+gjgQh+PKbMYjPjVbs7Yfo8ubfdjzilYux/0WU33yYEHtg5shLBo0
        J5raeUgg4nNwGHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94DA513A8E;
        Fri, 29 Jul 2022 13:55:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DPjBItbm42KWWAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 29 Jul 2022 13:55:34 +0000
Date:   Fri, 29 Jul 2022 15:55:32 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YuPm1HioKV7W1G7u@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220729125141.12786-1-pvorel@suse.cz>
 <YuPYWLD7xxcNmuCx@pevik>
 <YuPlUOT1nFyT9Fm7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuPlUOT1nFyT9Fm7@kroah.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> On Fri, Jul 29, 2022 at 02:53:44PM +0200, Petr Vorel wrote:
> > Hi all,

> > > Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

> > > This helps people who debug kernel with initramfs with minimal
> > > environment (i.e. without coreutils or even busybox) or allow to open
> > > sysfs file instead of run 'uname -m' in high level languages.

> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---

> > Changes v1->v2:
> > * Add file into /proc/sys/kernel/ (previously it was in
> >   /sys/devices/system/cpu/). There are 

> Looks like this line ended too soon?
OK, Friday. I'm sorry to be too abstracted today.
I was about to explain the reason - that there are other related files
osrelease, ostype.

> > * Update Documentation/ABI/ (Greg)

> This looks good to me, I'll queue it up after the next -rc1 is out
> unless someone objects.
Thanks!

Kind regards,
Petr

> greg k-h
