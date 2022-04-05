Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC184F4830
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378069AbiDEV3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448523AbiDEPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:48:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205681C908;
        Tue,  5 Apr 2022 07:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEBB2B81E4D;
        Tue,  5 Apr 2022 14:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1BBC385A0;
        Tue,  5 Apr 2022 14:29:35 +0000 (UTC)
Date:   Tue, 5 Apr 2022 15:29:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/process: Update ARM contact for embargoed
 hardware issues
Message-ID: <YkxSTBBb5Hj1EQPF@arm.com>
References: <20220324151605.266645-1-catalin.marinas@arm.com>
 <YjyilfhMgbqTo3eL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjyilfhMgbqTo3eL@kroah.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 05:55:49PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 03:16:05PM +0000, Catalin Marinas wrote:
> > With Grant taking a prominent role in Linaro, I will take over as the
> > process ambassador for ARM w.r.t. embargoed hardware issues.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Grant Likely <grant.likely@arm.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  Documentation/process/embargoed-hardware-issues.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> > index 6f8f36e10e8b..41a2afaaea75 100644
> > --- a/Documentation/process/embargoed-hardware-issues.rst
> > +++ b/Documentation/process/embargoed-hardware-issues.rst
> > @@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
> >  an involved disclosed party. The current ambassadors list:
> >  
> >    ============= ========================================================
> > -  ARM           Grant Likely <grant.likely@arm.com>
> > +  ARM		Catalin Marinas <catalin.marinas@arm.com>
> 
> Nit, no tab is needed.  I missed this on the next line:
> 
> >    AMD		Tom Lendacky <tom.lendacky@amd.com>
> 
> But no need to follow bad decisions :)

I was wondering. There are currently three entries with spaces and the
rest with tabs, so I went with the majority. I'll repost with spaces and
get Grant to ack again without the legal disclaimer.

-- 
Catalin
