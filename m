Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989D8543CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiFHT2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiFHT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:27:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F51B7814
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rhbHZ5VaGmUyTCleUDguhQAkaOJovJzetkNMfx1Ybes=; b=IYkHOWHEH2izaqISQwtGzkZIrO
        OcfJr28cmAbWZ1TxYXHl/8vMSWQrQWiRqg/UTdvLWdPHfKlnTGxJS/YDgM2Ed/8o5PnrGSPw9Kewb
        u7ovIfbFi0iEaB5yCuuODNlXVHA9jnD/VstRu2w4Zv8QXEiSAsSB3LUyzSFrvUKeKaekFw28SwNuB
        J02PIHq6N2NzUOQzn8IPFF8USSTeHc+PJ48tBZ0fZy6IsKACSSkIVzSaDUzyPwZ0gwGo5MBi0FZ6+
        lu/lDq8NFrAwm57vGWnvKfvNjzHfsjbcdUrJ2qV1fnWwpzZ5V2j13KSko35Qas4AsRoh/MzW5fYUM
        dS2gu1JQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz1LF-00CuP8-QK; Wed, 08 Jun 2022 19:27:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B9E4300222;
        Wed,  8 Jun 2022 21:27:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60E7D201E482B; Wed,  8 Jun 2022 21:27:42 +0200 (CEST)
Date:   Wed, 8 Jun 2022 21:27:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?6b6N5biG6LuS?= <1030steven@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/pelt: Fix bracket typo
Message-ID: <YqD4LiEcxpHTrTVp@hirez.programming.kicks-ass.net>
References: <20220608150008.57629-1-1030steven@gmail.com>
 <3193fcc9-c672-19d9-a2e2-ad67809dd20b@infradead.org>
 <CAEZ6PjwamdjavX_AvsFmRasE7W1cnc10dpPqSzxhvzEKm4i5Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEZ6PjwamdjavX_AvsFmRasE7W1cnc10dpPqSzxhvzEKm4i5Aw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 01:24:45AM +0800, 龍帆軒 wrote:
> On Wed, Jun 8, 2022 at 11:33 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> >
> >
> > On 6/8/22 08:00, Steven Lung wrote:
> > > The second bracket describing the range is inverted, this patch
> > > will fix it.
> > >
> > > Signed-off-by: Steven Lung <1030steven@gmail.com>
> > > ---
> > >  kernel/sched/pelt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > > index 0f3107682..ed82cfba9 100644
> > > --- a/kernel/sched/pelt.c
> > > +++ b/kernel/sched/pelt.c
> > > @@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
> > >   * When syncing *_avg with *_sum, we must take into account the current
> > >   * position in the PELT segment otherwise the remaining part of the segment
> > >   * will be considered as idle time whereas it's not yet elapsed and this will
> > > - * generate unwanted oscillation in the range [1002..1024[.
> >
> > Is the above the same as                   range [1002..1024).
> > ?  I.e. 1002-1023 inclusive (or 1024 excluded)?

> In the patch that the author submitted[1] for this comment, he
> mentioned that the value 1024 can be obtained.
> So I think we should use brackets instead of parenthesis.

Yeah, IIRC the value is fundamentally [0,1] (*scale) there. Therefore
the patch as proposed makes sense to me.
