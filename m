Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD1D4FFFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbiDMU2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiDMU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:27:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BEF49CA8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:25:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so6284066ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uV3KvzgDCA/MFdg0UvIjDT9gmeSPR5bMWj/awW6+7BY=;
        b=j5ZthmzoP3s7KorF6lAJHItYV0eyjlfoSNGED9WLK2fpQU6EGfeMC+Ci7ByHEsMOdv
         hPkLyJBM1A1GSulOuqM/68laweCbT5/uFUsEvEz3hARESoYhCbbhvums05WuWiR/Vzpn
         Bcn2LSPX2uGhZAcCq26oC3nwq6Q5lv6Hw8MUh8k0cTajKJHH3IvR7DD/K1YhhBXj3v/Z
         FxyENPweoX5dsX09wvWttdcAt2f9Om4Ovr4lOhccuzxxKB3adK58y/aug8x+Bm7iMBHW
         LTe8gxk7ZFa2BJ+EDmiMF1OG/O6XrJA3n+aO1tyAbV1TaqXlJbLCMjXIpj71meibWdI9
         9/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uV3KvzgDCA/MFdg0UvIjDT9gmeSPR5bMWj/awW6+7BY=;
        b=utxpAyhktb5nmqOP8FQK9IGtnVUx/Z6I83n9/vRjVudAv7fT0MzNOp3y8NbN9dgJWQ
         RDPkPYnojsOV2rkrcGgg0wJUwEv1ZbxjZ1Mv1AWGGhu0b9yXR0OjCCUGvHIKgm+O8OIT
         OYOxNp6mJQY000YGwGYb0HMfELlFtqI77WudmaN7Ni4mmXItkBO/P03CS176bSKKJftd
         fX8ikDu7h3BgINITeR4tq0xitp7Wbk4pmumu4oQERikcQk8kScUKNI1irxQdhZQPqOqA
         2shpD4MzeXopN5nS2jGvh8OEBn6uTs6sHg0mf4b2DkVgevZ0gltQRnZizQfD9Dhd/Nmt
         zukQ==
X-Gm-Message-State: AOAM5303NunmxYZpwxuFv6JUCjYHasqRRS/n9SJ4VbmUZYy4VyPjU29w
        eTnCLWNvFxMjig2OQtZ6aHg=
X-Google-Smtp-Source: ABdhPJyBjOm1aBOG3txTjnnhhNj8e/guMWUGTpxorgtWscVt/9l2BYvOPLdYfU6nBTREuZn0HOn6EA==
X-Received: by 2002:a17:907:7242:b0:6e7:f185:18e2 with SMTP id ds2-20020a170907724200b006e7f18518e2mr38726394ejc.577.1649881533555;
        Wed, 13 Apr 2022 13:25:33 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b00418f9574a36sm1575622edu.73.2022.04.13.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:25:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
Subject: Re: [PATCH] staging: Remove the drivers for the Unisys s-Par
Date:   Wed, 13 Apr 2022 22:25:30 +0200
Message-ID: <3155429.AJdgDx1Vlc@leap>
In-Reply-To: <20220413193152.GA1242449@alison-desk>
References: <20220412215901.31046-1-fmdefrancesco@gmail.com> <7390243.EvYhyI6sBW@leap> <20220413193152.GA1242449@alison-desk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled? 13 aprile 2022 21:31:52 CEST Alison Schofield wrote:
> On Wed, Apr 13, 2022 at 11:57:20AM -0700, Fabio M. De Francesco wrote:
> > On mercoled? 13 aprile 2022 17:38:24 CEST Alison Schofield wrote:
> > > On Wed, Apr 13, 2022 at 09:35:53AM +0200, Fabio M. De Francesco 
wrote:
> > > > On mercoled? 13 aprile 2022 08:52:47 CEST Greg Kroah-Hartman wrote:
> > > > > On Tue, Apr 12, 2022 at 11:59:01PM +0200, Fabio M. De Francesco 
> > wrote:
> > > > > > The Unisys sub-tree contains three drivers for the "Unisys 
Secure 
> > > > Partition"
> > > > > > (s-Par(R)): visorhba, visorinput, visornic.
> > > > > > 
> > > > > > They have no maintainers, in fact the only one that is listed 
in 
> > > > MAINTAINERS
> > > > > > has an unreacheable email address. During 2021 and 2022 several 
> > patches 
> > > > have
> > > > > > been submitted to these drivers but nobody at Unisys cared of 
> > reviewing 
> > > > the
> > > > > > changes. Probably, also the "sparmaintainer" internal list of 
> > > > unisys.com is
> > > > > > not anymore read by interested Unisys' engineers.
> > > > > > 
> > > > > > Therefore, remove the ./unisys subdirectory of staging and 
delete 
> > the 
> > > > related
> > > > > > entries in the MAINTAINERS, Kconfig, Makefile files.
> > > > > > 
> > > > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > > ---
> > > > > >  MAINTAINERS                                   |    8 -
> > > > > 
> > > > > You forgot to at least cc: the people/list on the MAINTAINERS 
entry 
> > that
> > > > > you are removing here, to give them a hint that this is happening 
in
> > > > > case they want to speak up here (and to give us the ability to 
point 
> > to
> > > > > that years later when they complain they were never notified...)
> > > > 
> > > > Yes, this is a good idea. I'll submit a v2 and add two "Cc:" lines, 
one 
> > to 
> > > > David Kershner and the other to the "sparmaintainer" list at 
> > unisys.com.
> > > 
> > > There is another contact in the TODO file (last updated 2015 though 
;))
> > > Ken Cox <jkc@redhat.com>
> > 
> > Hi Alison, Greg,
> > 
> > Thank you very much for noticing that other contact :) 
> > 
> > In the last 12 months I have sent several patches for Unisys s-Par 
drivers 
> > but I never noticed that other contact simply because I only ever use 
> > scripts / get_maintainer.pl to find out who and to which lists to send 
my 
> > works.
> > 
> > @Greg: 
> > 
> > Do you think that we should care of a contact that is no more active 
since 
> > 2015 and resubmit a v3 with one more "Cc:" line? I have no problems to 
> > resubmit, I just want to be sure that this is the right thing to do.
> 
> I didn't see a v2, so confused about a v3. You could simply do a group
> reply and add the contact, that'll put a trail in lore. Not my call.
> Guessing Greg has a protocol for such removals. 

Hi Alison,

The patch v2 is at https://lore.kernel.org/outreachy/
20220413080111.13861-1-fmdefrancesco@gmail.com/T/#u

Greg required me to send that v2 because I forgot to Cc the David Kershner  
and the Unisys internal list. 

I don't yet know if Greg's protocol for such removals requires to Cc random 
people taken from a TODO file, people who didn't even care to add 
themselves to MAINTAINERS, but I'm pretty sure that, if it is so, the only 
option is to send a v3.

In order to make things as Greg requires, I'd better wait for him to 
respond to my previous email.

Again, thanks,

Fabio


