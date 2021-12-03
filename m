Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC613467836
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhLCNc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:32:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53528 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352186AbhLCNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:32:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A37B62A81
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 13:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A5DC53FAD;
        Fri,  3 Dec 2021 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638538122;
        bh=NwJ1lhqF2Aj0siD8FXO/9LVapPv2s9vz7saNe9OMvj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIdIeXTnMoFZZBiL+O94Z5zo137xnEFxJaHhlEin0Fbt4fl98kTVIXRuJ1ad/4MxO
         cZuJ+hT4GqsVyZ6mJ2+/cPW1zQ3qK4Gfh+csF7kQWovxMEE9rsyiFPTeomLzorXUsm
         ZAix8aAIRUgiC37luZYvuZWCs0v7A5ZJSJX2okBg=
Date:   Fri, 3 Dec 2021 14:28:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        corbet@lwn.net, rdunlap@infradead.org, mchehab+huawei@kernel.org
Subject: Re: [PATCH v5] include: linux: Reorganize timekeeping and ktime
 headers
Message-ID: <YaobiAO2swGf3X3+@kroah.com>
References: <b5d4536f-a096-b259-1385-3c1d32754dbf@vt.edu>
 <095645cd-ce53-a803-cb99-522545a409b8@vt.edu>
 <YSJP18Z72t0X+xsp@kroah.com>
 <1c156aca-d0ad-e7e8-2238-5c3d904d171c@vt.edu>
 <327f5c2f-b996-8aa1-cbbf-3354e01ee1f3@vt.edu>
 <fb66b935-b498-723a-1f05-f02648f8f580@vt.edu>
 <YYN78YlFrV0vFPq9@kroah.com>
 <ce75dfa1-b51d-1988-9371-ca90ab5e1535@vt.edu>
 <18f2afb6-7c42-fff1-2c79-ea473ae2b72a@vt.edu>
 <0ec6b0b3-0d59-ff68-13b3-c9798f3ac6c6@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec6b0b3-0d59-ff68-13b3-c9798f3ac6c6@vt.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:22:21AM -0500, Carlos Bilbao wrote:
> On 11/16/21 5:11 PM, Carlos Bilbao wrote:
> > Reorganize and separate the headers by making ktime.h take care of the 
> > ktime_get() family of functions, and reserve timekeeping.h for the actual 
> > timekeeping. This also helps to avoid implicit function errors and strengthens
> > the header dependencies, since timekeeping.h was using ktime_to_ns(), a static 
> > function defined in a header it does no include, ktime.h. Include the header 
> > timekeeping.h wherever it is necessary for a successful compilation after the 
> > header code reorganization.
> > 
> > Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> 
> Someone, look at me! What a lonely and solitary patch I am...

Yes it is, maybe the time maintainers will pick it up eventually if they
feel it is valid.

good luck!

greg k-h
