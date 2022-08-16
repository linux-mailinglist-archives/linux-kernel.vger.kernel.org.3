Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA6E596407
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiHPUxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiHPUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:53:01 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5082F8A1C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:53:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6EB972281E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:52:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 17E0C2228A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:52:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660683179; a=rsa-sha256;
        cv=none;
        b=CZUOIOhqwd+JRiUT1fvrvftKZYFxAuIKzl7KhWIgxqXSVz/GWJvrsg890NwgsnEgJxQ40x
        lm4ccgSeD3jhjhA/Vxr/rpb2aN0Z9MhPMkqvX1votpQCJzWgtTio3paRjH3vna9Z8Dre2k
        aYXCRh1/MibNEn/HXgOso4jccsGMHjhAYREGk2jv/1Ee3bkg+qJKQrtKMxRhcbZEPqtiCd
        ebXyI/i79IfZraihSRoPwPSHAS8+fnkLLGsQWO2QRC8btOf7yXfnszX89NS2DgMKOd4/hc
        7pYTwGepIn29tLbNirZb4x4N7usWfvGmAJUSm8QuIwIPAaHlI9CM6Z8pHKPWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660683179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ArGYP1NggPCb8Uo+jTV64iG9x+WcB+Ng0C17pccaPQI=;
        b=hJIqloH/225lKqWkq+LuOK5LxGDEPDQ07w7fObBDS9T5E9qTF4piB2ezntmcBpazM4yZst
        Exrj1CyBAl2JUCA/3Yidni892F9m1sBvTEGHgoBMRwLUlt3lZQgyxz+pcYhGH4OIkU8Lc4
        P6SaCbVqqU63AhvURg+9IL4C6gpQXSFEi8XTJ99qFvF6V1GCpgMW3Otl8lEbCyiC2ZQmO+
        HOO3p7R3RxncGosR+crCoIJ+3Rvvl4wtbg338WWllUr9M+/7E8mcf/DppwkSEP40+9RC4x
        D8hViM4SCOxP8skpW/ULA/1x7rt4n/9RtKP1Gue0WgbY6k18SXLujGDno2ug8Q==
ARC-Authentication-Results: i=1;
        rspamd-7697cc766f-5lpgz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Coil: 23c0df9a59af2efe_1660683179323_3317257040
X-MC-Loop-Signature: 1660683179323:2040146718
X-MC-Ingress-Time: 1660683179323
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.158 (trex/6.7.1);
        Tue, 16 Aug 2022 20:52:59 +0000
Received: from kmjvbox (unknown [98.42.138.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4M6jyy420QzLt
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1660683178;
        bh=ArGYP1NggPCb8Uo+jTV64iG9x+WcB+Ng0C17pccaPQI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=P/4OTaW5cm5SH5Tdq5da9MBXsPXXwMKjs3CXFbsySac/tLJFNODGmoO2BV+r8/Vsv
         DUtjW1kCnr/3BCqGiHR2yR61a+4ijRav+V5xEjdbsMZ3uye0qQdmlbBhOFml8Iw++y
         5LVx+uZ5HjJ0U091ucbXErapEXv6c4rhBEVPDHEw=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0118
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 16 Aug 2022 13:48:43 -0700
Date:   Tue, 16 Aug 2022 13:48:43 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Reaver <me@davidreaver.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/1] tracing: fix a WARN from trace_event_dyn_put_ref
Message-ID: <20220816204843.GB2004@templeofstupid.com>
References: <cover.1660347763.git.kjlx@templeofstupid.com>
 <4e43a4eece5f382d1636397fb3c0208f2afe81fc.1660347763.git.kjlx@templeofstupid.com>
 <20220816122559.17869abc@gandalf.local.home>
 <20220816185418.GA2004@templeofstupid.com>
 <20220816152411.086ce631@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816152411.086ce631@gandalf.local.home>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:24:11PM -0400, Steven Rostedt wrote:
> Actually, I think the issue is that the unreg() calls trace_event_put_ref()
> but the reg() does not do the try_get_ref(), but the perf_trace_init()
> does. Which is the broken symmetry.
> 
> I think if we pull out the trace_event_put_ref() from the unreg() function,
> we fix the bug and also put back the symmetry.
> 
> Does this patch work?

Yes, thanks, this change looks correct.  It also does build and pass the
tests that I included in the original e-mail.

> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a114549720d6..61e3a2620fa3 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -157,7 +157,7 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
>  	int i;
>  
>  	if (--tp_event->perf_refcount > 0)
> -		goto out;
> +		return;
>  
>  	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
>  
> @@ -176,8 +176,6 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
>  			perf_trace_buf[i] = NULL;
>  		}
>  	}
> -out:
> -	trace_event_put_ref(tp_event);
>  }
>  
>  static int perf_trace_event_open(struct perf_event *p_event)
> @@ -241,6 +239,7 @@ void perf_trace_destroy(struct perf_event *p_event)
>  	mutex_lock(&event_mutex);
>  	perf_trace_event_close(p_event);
>  	perf_trace_event_unreg(p_event);
> +	trace_event_put_ref(p_event->tp_event);
>  	mutex_unlock(&event_mutex);
>  }
>  
> @@ -292,6 +291,7 @@ void perf_kprobe_destroy(struct perf_event *p_event)
>  	mutex_lock(&event_mutex);
>  	perf_trace_event_close(p_event);
>  	perf_trace_event_unreg(p_event);
> +	trace_event_put_ref(p_event->tp_event);
>  	mutex_unlock(&event_mutex);
>  
>  	destroy_local_trace_kprobe(p_event->tp_event);
> @@ -347,6 +347,7 @@ void perf_uprobe_destroy(struct perf_event *p_event)
>  	mutex_lock(&event_mutex);
>  	perf_trace_event_close(p_event);
>  	perf_trace_event_unreg(p_event);
> +	trace_event_put_ref(p_event->tp_event);
>  	mutex_unlock(&event_mutex);
>  	destroy_local_trace_uprobe(p_event->tp_event);
>  }
> 

If it matters:

Reviewed-by: Krister Johansen <kjlx@templeofstupid.com>
Tested-by: Krister Johansen <kjlx@templeofstupid.com>

Thanks again,

-K
