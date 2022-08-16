Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8C5962C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiHPS6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiHPS6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:58:41 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889397CAB3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:58:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9618412211E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:58:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E826A1223A0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:58:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660676317; a=rsa-sha256;
        cv=none;
        b=QVoT0q3U+D80cA+ZL3Ft/29QY+1MRY39ykTnTfS4tU+ITLHswmtfO0vn8uUKS6rTcKl3wa
        oeZc0RHHEIpBoKpa5kNKAXxr6T5Xjyq2MWMMpQ/knQ3DqvKyMZxAjCfsdRQqCjhFnfm5Ow
        yxWt3TlyvT2Wqvwq/baXXYSDaFx+8ThTO39k6K0VTPaDa7r+eo/B2Ho1I1iGGRT9exVEcc
        p0ySr7eq6XA+DiXgIt3axt1OmXMEZaRgarUUQzKxjzEuTr4oymQ43r3/AueJUimYcqHfiA
        2Gzul37E/EMonfyLMdm776uVQj3FwsyGOm7OoC2mKKtbk5pE9OA60H1jyuttBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660676317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=oHxRzmpe3HV3JjXn0cCHlWmVJ7Ew4wM4Ge8o+MpljIY=;
        b=RP1V6uaZReMJLFdLo4gKjhanyesudme9jvo6ukU+RxbCIAP+X/3DSez4pauCoe99gnrxM9
        QJfOBQcUD16k5vsJwn3zD8XUAqrw40MQtSf4r2B2ZMObq1vYkelrT9++/S+K/p0hWPiyo6
        46+pj9JHeAOJewdTV71U5BgZagNxYsir4pACY8sEIc8Sv7B9qSl1FAYp3RR6Zhmgbl0qjO
        u0Xihki9KdmP+EAEeQ+8uXhxZdGd3Cor1c6jlDOCF8m60tdXXfaggcydth9DCrgDXak2e0
        KJNSL9JY839PG7zJ5MxpU1bFV0Og/sUBSKJpgvJkh6spLnyFv/nLa6aUiPu8iw==
ARC-Authentication-Results: i=1;
        rspamd-7697cc766f-gvcrf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Plucky: 42adb60803a0d2be_1660676318192_116601767
X-MC-Loop-Signature: 1660676318192:515070556
X-MC-Ingress-Time: 1660676318191
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.213 (trex/6.7.1);
        Tue, 16 Aug 2022 18:58:38 +0000
Received: from kmjvbox (unknown [98.42.138.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4M6gR04ZxdzdD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1660676316;
        bh=oHxRzmpe3HV3JjXn0cCHlWmVJ7Ew4wM4Ge8o+MpljIY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=qauQXnGswPmTLPCQ03jGV7Sv7SVbSQB21EsPfisYiIFB7LQyZIFS50Ek5lG1NZUBN
         ONOD06J8Gy0VxJLWMFzdBcQXDgVWHhyXvLDiDkP27gyrM5mG7GUEERGf1rV92s44rT
         2pyyjt0SGSetG0hW8mWf2gaUXp55S+E+I60bFq28=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0118
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 16 Aug 2022 11:54:18 -0700
Date:   Tue, 16 Aug 2022 11:54:18 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Reaver <me@davidreaver.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/1] tracing: fix a WARN from trace_event_dyn_put_ref
Message-ID: <20220816185418.GA2004@templeofstupid.com>
References: <cover.1660347763.git.kjlx@templeofstupid.com>
 <4e43a4eece5f382d1636397fb3c0208f2afe81fc.1660347763.git.kjlx@templeofstupid.com>
 <20220816122559.17869abc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816122559.17869abc@gandalf.local.home>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
Thanks for the feedback.

On Tue, Aug 16, 2022 at 12:25:59PM -0400, Steven Rostedt wrote:
> 
> [ Added the authors of this code to the Cc ]

Oops, that was an unintentional omission.

> On Fri, 12 Aug 2022 17:02:20 -0700
> Krister Johansen <kjlx@templeofstupid.com> wrote:
> 
> > The code in perf_trace_init takes a reference on a trace_event_call that is
> > looked up as part of the function call.  If perf_trace_event_int fails,
> > however, perf_trace_event_unreg can decrement that refcount from underneath
> > perf_trace_init.  This means that in some failure cases, perf_trace_init
> > can trigger the WARN in trace_dynevent.c which attempts to guard against
> > zero reference counts going negative.
> > 
> > The author can reproduce this problem readily by running perf record in a
> > loop against a series of uprobes with no other users.  Killing the record
> > process before it can finish its setup is enough to trigger this warn
> > within a few seconds.
> > 
> > This patch leaves the behavior in perf_trace_event_unreg unchanged, but
> > moves most of the code in that function to perf_trace_event_cleanup.  The
> > unreg function retains the ability to drop the refcount on the tp_event,
> > but cleanup does not.  This modification is based upon the observation that
> > all of the other callers of perf_trace_event_init don't bother with
> > manipulating a reference count on the tp_events that they create.  For
> > those callers, the trace_event_put_ref was already a no-op.

<...>

> > @@ -207,7 +213,7 @@ static int perf_trace_event_init(struct trace_event_call *tp_event,
> >  
> >  	ret = perf_trace_event_open(p_event);
> >  	if (ret) {
> > -		perf_trace_event_unreg(p_event);
> > +		perf_trace_event_cleanup(p_event);
> 
> The only problem I have with this patch is the loss of symmetry. Where
> perf_trace_event_reg() returns successful, so unreg() should be the
> function you call on failure.
> 
> Since perf_trace_event_reg() is only called from perf_trace_event_init()
> let's move the perf_trace_event_open() into the perf_trace_event_reg() and
> have the unreg still do the clean up on failure.
> 
> This way we keep the symmetry between *_reg() and *_unreg().
> 
> And then the init function will not have to do any clean up, and can just
> end with:
> 
> 	return perf_trace_event_reg(tp_event, p_event);


I went to implement this suggestion.  In the process, I found that I was
potentially creating more asymmetry.  There are a number of places in
the teardown path where the code does something like this:

  perf_trace_event_close(p_event);
  perf_trace_event_unreg(p_event);

In this situation, it seems like I should move the close into the unreg
as well.  However, if I do that, then unreg can't be called from reg
until open has been successful.

The original problem that I set out to solve was to prevent
perf_trace_event_unreg() from decrementing a refcount in
perf_trace_event_init(). If I pull unreg() into the failure path in
reg then I think I still need to keep that refcount decrement present
for the users that are calling unreg from outside of reg().

After looking at the failure handling in perf_trace_event_reg(),
it actually shares a lot of code with perf_trace_event_unreg().  Unifying
the two would be nice.  If unreg is called from reg, that also makes
it difficult for unreg to be used separately.

If the primary objection is around the naming, I have a couple of
possible ideas:

1. Rename perf_trace_event_cleanup to perf_trace_event_unreg_noref and
use it in perf_trace_event_init.  This keeps some of the reg/unreg
symmetry, but makes it clear that its the unreg that won't touch the
tp_event refcount.

2. Introduce a function that's complementary to perf_trace_event_init
and name it perf_trace_event_destroy.  Modify the logic to be something
like the following:

  perf_trace_event_init() {
    trace_event_try_get_ref(tp_event);
    perf_trace_event_perm();
    perf_trace_event_reg();
    perf_trace_event_open();
  
  }
  
  perf_trace_event_destroy() {
    perf_trace_event_close();
    perf_trace_event_unreg();
    trace_event_put_ref();
  }

And then modify the current callers of the close/unreg pair to use
destroy.

What do you think, would either of these be a solution that you would
find acceptable?

-K
