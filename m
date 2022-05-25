Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD85339F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiEYJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiEYJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:34:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28218A326;
        Wed, 25 May 2022 02:34:20 -0700 (PDT)
Date:   Wed, 25 May 2022 11:34:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653471258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BDuC1M83okFLvS1+Asx6My6EAgtEJl/fGn/qK8yy/g=;
        b=OGX1WV45bkvE5/HLctakku/QnFGGlxFmrDE89NZh2h/+AgW3yKIMbGkk0+oaILwP+fEEfL
        ss4sCljtOrbb0tBkvaueEOnKZHvo/uxNAeMwyVHG0fkM3R2pZuQ79wBw4ywsuCD1jyEL71
        mVPnujD4GT80b7ZoWy7KZjQo+G1taafoMb8KObT0PBSIdu6wNnBiNYge0U11LN04fs3Onh
        qhXvoSxivTj+mC8kX2GZrEnZj0wjbwEb9KMbs8ANyzYSSaVtcyA6cJ/kFppswPIr3CTMpw
        fX5yX8DEXP6kk9ezmd/jIdcnyMZ+qxpKwCMO2jb0D05KrIabjjWy0/rzQ9t4yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653471258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BDuC1M83okFLvS1+Asx6My6EAgtEJl/fGn/qK8yy/g=;
        b=ezgKY9Z5IoxbTrMK1PmZCuUtUK2dBS8xPqNlDTOSSY7eKcDOeP75DkrhUHFHje1x44zL3I
        pvTxMSjSobVHDBCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev,
        "Acked-by : Mike Rapoport" <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <Yo34GGK62yVkPzZy@linutronix.de>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
 <20220425162400.11334-2-fmdefrancesco@gmail.com>
 <YmeYzKT8Ikq5SfdE@linutronix.de>
 <YmwLXvtSgl2BA2mC@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmwLXvtSgl2BA2mC@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-29 08:59:26 [-0700], Ira Weiny wrote:
> I think some discussion needs to happen around this API.
> 
> Highmem has little use.  I don't think anyone disagrees with Linus there.
> (Although I think there are still a few users out there.)

arm32 is still built and they have sometimes 1 - 2 GiB of memory.

> kmap may be a poor name for an API without the highmem functionality.  But
> perhaps not.  One could interpret it to mean simply getting the kernel mapping
> of the page rather than creating one.  After all that is what 64bit has done
> all along.
> 
> This interpretation helps when you consider features which attempt to layer the
> direct map with additional protections like PKS.[1]  Those protections mean
> that a simple page_address() is insufficient to access the direct map.
> 
> As far as calling kmap() and kmap_atomic() deprecated I'm ok with that if the
> community is.
> 
> The current kmap() call sites need work and Fabio's work on auditing them is
> extremely helpful.  That said, if we officially deprecate kmap_atomic() then
> those sites could be added to the list for rework.

Maybe I oversee something obvious but there is no problem with removing
kmap_atomic*() and keeping only kmap_local*() around, is there?
I never intended to deprecated kmap(), only kmap_atomic*() in favour of
kmap_local*().

> Ira

Sebastian
