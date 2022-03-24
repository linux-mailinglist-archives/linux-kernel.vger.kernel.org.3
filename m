Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558284E675B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352006AbiCXQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352041AbiCXQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:56:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267FD10E2;
        Thu, 24 Mar 2022 09:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3CEBB82449;
        Thu, 24 Mar 2022 16:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2DAC340EC;
        Thu, 24 Mar 2022 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648140914;
        bh=jm+6LYBgkUC0IdPTORyvi5g/WjdMl7NogA6BC4AYlJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvAcWeNqh6XVjqYg+LqiEAxosej9vK6qLykyPXroLexOGpwXPpD76SnxftfJXAVIH
         GSiSHFX/sLBaExrd9WXl+aGEpmuOfn4icbBzT/ebz6I/W0KdIe4xDZCNFfK734Wp4E
         NIYYaCJ/eUW4iTXD/Ds4lsd1qQWO7rNciogbQm4k=
Date:   Thu, 24 Mar 2022 17:55:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Grant Likely <Grant.Likely@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/process: Update ARM contact for embargoed
 hardware issues
Message-ID: <YjyibzHcFamjx0JD@kroah.com>
References: <20220324151605.266645-1-catalin.marinas@arm.com>
 <F5B89578-5AEE-4C29-B146-B84265FD2B4E@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F5B89578-5AEE-4C29-B146-B84265FD2B4E@arm.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:39:09PM +0000, Grant Likely wrote:
> 
> > On 24 Mar 2022, at 15:16, Catalin Marinas <Catalin.Marinas@arm.com> wrote:
> >
> > ﻿With Grant taking a prominent role in Linaro, I will take over as the
> > process ambassador for ARM w.r.t. embargoed hardware issues.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Grant Likely <grant.likely@arm.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Grant Likely <grant.likely@arm.com>
> 
> > ---
> > Documentation/process/embargoed-hardware-issues.rst | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> > index 6f8f36e10e8b..41a2afaaea75 100644
> > --- a/Documentation/process/embargoed-hardware-issues.rst
> > +++ b/Documentation/process/embargoed-hardware-issues.rst
> > @@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
> > an involved disclosed party. The current ambassadors list:
> >
> >   ============= ========================================================
> > -  ARM           Grant Likely <grant.likely@arm.com>
> > +  ARM        Catalin Marinas <catalin.marinas@arm.com>
> >   AMD        Tom Lendacky <tom.lendacky@amd.com>
> >   IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
> >   IBM Power     Anton Blanchard <anton@linux.ibm.com>
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Response is now dropped :(

Grant, you know better....
