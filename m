Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307D9593458
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiHOR7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiHOR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:59:11 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E75B2980E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:58:34 -0700 (PDT)
Date:   Mon, 15 Aug 2022 13:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660586313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1hHwMB/Z3nDVYUNpyulTEjrjywAh+e32Egp6wegqoAQ=;
        b=n9otQmIYaAr6GyzXvxW31m/M57hUYHWoMi3139c++Q8e+IuvslaHRsu+pJx5AWLnKlHPZ3
        GEfSpTW4Q0gOsBI5sPoyAmjNktTZh/D5SBJEv2r8OTR6JwRLzeMXyf/sz1fwWxX6Rb0Dwe
        aXN1Hz2r3CcLCw1VIevL+Mwt1FtK4F4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 07/11] tracing: trace_events_synth: Convert to printbuf
Message-ID: <20220815175830.pndfli32u5lfa4ww@moria.home.lan>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
 <20220815172613.621627-8-kent.overstreet@linux.dev>
 <20220815134314.32f3d3fc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815134314.32f3d3fc@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 01:43:14PM -0400, Steven Rostedt wrote:
> On Mon, 15 Aug 2022 13:26:09 -0400
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > This converts from seq_buf to printbuf.
> > 
> > This code was using seq_buf for building up dynamically allocated
> > strings; the conversion uses printbuf's heap allocation functionality to
> > simplify things (no longer need to calculate size of the output string).
> 
> As I stated before. I'll look into converting the seq_bufs to printbuf for
> tracing at a later date. That includes this file.

You specified the other tracing patch, you did not specify this one.

Andrew, I just reran the tracing tests with this patch dropped - you can just
drop it, no other fixups are required.
