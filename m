Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D454A59DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiBAKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiBAKUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:20:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F106EC061714;
        Tue,  1 Feb 2022 02:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LKpIwZq9VaTuVEW18fuo+yQ6Mf7+kNsF1BsaoDQ9Ud4=; b=HCfPLhurzWyecX4HCH7XJhq4Yu
        9ycpU36CisfL7uPe9H27OUW0sMjULkn0Wmnh7zY7oqijPdR1qgg3YSJ6LByu/+LEKxAwlkepGxS5u
        g54w8ORvr38ZkevO0lp8L+6Kf03pqROHy/FRoeuOeEbzG1KoLgl19kfk+y9q6a9FbdkzggbHzQ0OV
        WjCO89b5H1wMRKTsrphRMkdvaJ9xao42rCKWqvN5+bcdpUu58avnivexVnQTbdfNuMi44Qqpdy6vH
        uYZbSD6esMevof6AARIY2AWulQnan/U10qiE5kvj5mggRAyZwK77VEN7nky3nqsCO2gs/+HiQ4p8v
        KnL8fU7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEqH1-005pMF-TM; Tue, 01 Feb 2022 10:20:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE32398623E; Tue,  1 Feb 2022 11:20:29 +0100 (CET)
Date:   Tue, 1 Feb 2022 11:20:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 08/13] ACPI: add perf low power callback
Message-ID: <20220201102029.GS20638@worktop.programming.kicks-ass.net>
References: <20220126233454.3362047-1-eranian@google.com>
 <20220126233454.3362047-9-eranian@google.com>
 <YfKY4k+ZO9of3Ipd@hirez.programming.kicks-ass.net>
 <CABPqkBQoLh+v0ANLb=U-JTjT0yjBacVLTh6f=0q4J4XhVQeeuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQoLh+v0ANLb=U-JTjT0yjBacVLTh6f=0q4J4XhVQeeuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:33:10PM -0800, Stephane Eranian wrote:
> On Thu, Jan 27, 2022 at 5:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jan 26, 2022 at 03:34:49PM -0800, Stephane Eranian wrote:
> > > This patch add an optional callback needed by some PMU features, e.g., AMD
> >
> > "This patch" is a documented fail.
> >
> I understand this is not ideal.

git grep -i "this patch" Documentation/process/submitting-patches.rst

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

IOW, don't use "This patch" to start a Changelog (lot's of your patches
here do so).
