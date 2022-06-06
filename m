Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CECD53E7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiFFPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiFFPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:08:40 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5184DC687F;
        Mon,  6 Jun 2022 08:08:37 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 256F72xB004867;
        Mon, 6 Jun 2022 17:07:02 +0200
Date:   Mon, 6 Jun 2022 17:07:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@canonical.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] Documentation/security-bugs: overhaul
Message-ID: <20220606150702.GA4838@1wt.eu>
References: <20220531230309.9290-1-vegard.nossum@oracle.com>
 <20220601031254.GB26318@1wt.eu>
 <42200c3e-fb39-ddab-3d68-5dfb5eb89451@oracle.com>
 <20220603064924.GC29741@1wt.eu>
 <303283d9-5f1c-8bc7-6286-ce284de012a8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303283d9-5f1c-8bc7-6286-ce284de012a8@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vegard,

On Mon, Jun 06, 2022 at 04:21:40PM +0200, Vegard Nossum wrote:
> I think this points to a bigger problem, but not with CVEs being held up
> as trophies. There's already a huge monetary incentive to find bugs and
> sell them as 0-days so IMHO we _should_ be encouraging people to find
> bugs and either fix or report them, whether privately or publicly. If
> having CVEs helps with that, that ought to be a good thing...

Yes I'm fine with this approach, provided that we encourage the reporters
to figure by themselves where to report them. In my opinion, what only
refers to very old hardware, to anything that's not built by default,
that requires code change to prove the problem, or that is only
theoretical ought not be sent to a closed list. The purpose of closed
lists is to deal with emergencies, issues that could put users in trouble
if they were disclosed before a fix is merged.

> If you think a reported issue is not security-relevant, can you not
> simply ask/encourage the reporter to make a public post instead?

We regularly do, but it's important also not to send a cold shower to
the person who already prepared their work and report in a direction
that they thought was the most suitable one, just to learn the hard
way that what they found was not that important.

> If the security team is swamped with legitimate, security-relevant
> reports, then that sounds like an issue with manpower and/or
> organization. In my (admittedly limited) experience, Linus tends to be
> one of the first to reply, so maybe having a designated person or group
> to triage issues (maybe in a rota system) before engaging the rest of
> the team could take some of the pressure off?

Actually all of the members are expected to respond. I personally
consider it as a failure when Linus has to respond to a message that
stayed there for a while. And it does happen quite a bit, yes. I guess
that often none of us feels like we're knowledgeable on a particular
report.

> > As such I think that we could mention something along:
> > 
> >   Upon reporters' request in case a forthcoming presentation of the issue
> >   is planned, it may occasionally be accepted to temporarily keep out some
> >   of the detailed impacts of the issue, however the security team reserves
> >   the right to publicize these details if no other publication happens in
> >   a reasonable time frame or as soon as the fixes are found to cause a
> >   regression.
> > 
> > Because quite frankly, not being able to explain exactly why a patch is
> > done this way and not slightly differently is not acceptable.
> 
> This unfortunately directly contradicts the current policy as stated:
> 
> "All other information submitted to the security list and any followup
> discussions of the report are treated confidentially even after the
> embargo has been lifted, in perpetuity."

IMHO there's a big difference between disclosing confidential information
(which we never do) and explaining what makes a bug have a security
impact. The purpose of the commit message is to serve as arguments to
defend the commit's presence in the tree. Most of the info must be there,
except what's not needed to understand the bug (e.g. exploitation method).
Then the rest of the details ought to be disclosed fast enough for the
commit to be defended. Of course the context where the issue was discovered
has to remain confidential.

> So again, unless there's a clear consensus to change this, I wouldn't be
> comfortable making the change now.

Yeah I'm fine with this of course, but I wanted to take the opportunity
of your discussion to bring these concerns since they're also about the
instructions in the doc.

> If I could make a different suggestion (which is in the same spirit as
> the rewrite, actually), the security team could encourage the reporter
> to report to linux-distros once there is a patch or the patch is public
> -- that way, it's: 1) not on the security team to disclose anything, 2)
> distros get a heads up on the patch, and 3) everybody gets to know about
> the security impact of the bug when it is eventually posted to
> oss-security within 1-2 weeks.

Maybe that could work, let's keep thinking about this.

> Thanks for your comments/explanations, it certainly helps to have more
> perspective.

You're welcome. We're all in the same boat :-)

Willy
