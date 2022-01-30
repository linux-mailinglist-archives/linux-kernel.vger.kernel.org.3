Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA034A375D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiA3QKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:10:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46580 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344953AbiA3QKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:10:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A80961251
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 16:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D731C340E4;
        Sun, 30 Jan 2022 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643559007;
        bh=/1u+pt8tW21RlrDy+BIpS9Rs86AWcPQauetCdYmv3S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOnyLq9OMTt+pt4Z50QiU3CskGVIet0bd1d2jbv2pg7TcyH81wpyyK0SyZrc3gwGI
         sjsqxZ1XNyFwMHCFvAo7omM9VjRlnacgXFaQ/MNYSxf5CoXslGXY6U8N4jIYUzZcYh
         UcxIBPW0+3LcXHxsc8/4nP70im3Zz2IWGMc9x//3H6P6YQtk2hxC0l5CdQ2MTfI4PO
         02hqV3CAh7C55r5iRCH6K15GcG05F2eGHQx2NDkO1kpmfP6+pw9+nfXaGfTnMaCWNX
         Y1vx2Of1QESqL4bJso/inQELLbH1174nq/PaCB5hHWbkBJP9pfYFkgjhDgqVe0XeEn
         IgKPUcJFpW+6g==
Date:   Sun, 30 Jan 2022 18:10:00 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
Message-ID: <Yfa4WMeauvmgkQ9H@kernel.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
 <YfKngOPLeI3rQOn3@casper.infradead.org>
 <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:21:59PM +0100, Karolina Drobnik wrote:
> On Thu, 2022-01-27 at 14:09 +0000, Matthew Wilcox wrote:
> > On Thu, Jan 27, 2022 at 02:21:25PM +0100, Karolina Drobnik wrote:
> > > Add a dummy io.h header.
> > 
> > Rather begs the question of what memblock.c needs from linux/io.h.
> > 
> > Wouldn't it be better to:
> > 
> > +++ b/mm/memblock.c
> > @@ -18,7 +18,6 @@
> >  #include <linux/memblock.h>
> > 
> >  #include <asm/sections.h>
> > -#include <linux/io.h>
> > 
> >  #include "internal.h"
> > 
> 
> That was something I considered in the very beginning, but didn't have
> a chance to verify it works for all architectures. I can take a look
> after I'm finished with other v2 changes.
> 
> > (allmodconfig on x86-64 builds fine with this; I have not done an
> > extended sweep of other arches / build options).

I did a sweep for defconfigs for all arches and all were fine.

Karolina, please send the formal patch. Let's see how kbuild bot reacts.

-- 
Sincerely yours,
Mike.
