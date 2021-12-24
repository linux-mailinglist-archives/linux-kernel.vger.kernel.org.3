Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48D47EA68
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350643AbhLXBxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhLXBxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:53:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F6DC061401;
        Thu, 23 Dec 2021 17:53:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7342CCE2208;
        Fri, 24 Dec 2021 01:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC889C36AE9;
        Fri, 24 Dec 2021 01:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640310823;
        bh=SyN8Kz1dAUsFwNkZnuPpLDKw25zRawfmaGOuaAemJMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EkZaBlfdi7XbE5iP5i9UPgu3AorfvTVmTXRGi78D/v31rfJ2uc5i4Bt/eUdKhid/t
         Wot6NLgcX33RTpBDlL7/4lba3nkC160mkJoqSmZNILuXTm0dg8RCUPPQKP/eSIcMQL
         p3hBaR+mdYFsDLouqFJY+7r9KKSfH6YRRQEAm+rHQ3A+UJmI1PxgH5Yg2fcQu+q9tp
         uUEN8ocN7UFCl/1GqwcwNPPkkONSipTfSJQBwq69XELz6r8t6tjGJVTl1AYoLHn5TW
         mr9WdIg+DjVShW00z7F14ZUWKKczsDOPrfmqYy6w0mbU1Putvvxuejt50Zx3rliwbA
         B9sT9PL4XEHgQ==
Date:   Fri, 24 Dec 2021 02:53:39 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
Message-ID: <20211224025339.5f214d5b@coco.lan>
In-Reply-To: <87wnjudgre.fsf@meer.lwn.net>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
        <87r1a3drhz.fsf@meer.lwn.net>
        <38207705-f72a-8d79-caf9-d995bcd2a883@gmail.com>
        <87wnjudgre.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 23 Dec 2021 16:48:53 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Akira Yokosawa <akiyks@gmail.com> writes:
> 
> > On Thu, 23 Dec 2021 12:56:56 -0700, Jonathan Corbet wrote:  
> >> Akira Yokosawa <akiyks@gmail.com> writes:
> >>   
> >>> This patch set improves conversions of DOT -> PDF and SVG -> PDF
> >>> for PDF docs.
> >>>
> >>> * DOT -> PDF conversion  
> >> 
> >> So I'm unclear on the status of these patches; Mauro, are you happy with
> >> them?  If so I'd like to get them in before the merge window.  
> >
> > Jon, whether Mauro is happy or not, I want to do a respin of this and
> > at least fix the typo in PATCH 5/3 Randy pointed out.
> > Maybe merge PATCH 5/3 with PATCH 3/3 as well. 
> >
> > There is no reason to hurry, I suppose.
> >
> > I was kind of distracted by a development in other project lately.  
> 
> No worries, I can wait :)

I'll test the next review then... I guess the conversion is ok,
but I'll do a better test on a v2, after arriving from vacations.

Merry Christmas and Happy New Year!
Mauro
