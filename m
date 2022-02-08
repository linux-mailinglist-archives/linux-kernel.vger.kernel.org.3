Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F654AD35E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349392AbiBHI0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244762AbiBHI0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:26:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785B4C0401F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:26:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE68C611B1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3747C004E1;
        Tue,  8 Feb 2022 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644308789;
        bh=/iDMh8+8sXpSoskjRDDOyzMOhIrAveqBuI41oF00f0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=16W82cPIbXPFkpzimXgu9NmUmCFY4ZtIJfNGxLuiwXWjhp2fhZW5crJL0O73SwSj7
         KT4qNty6mzdpvwSH10QOiOqvmWwdv5s3UvkTOA28GMvQY+RMhzzVjtlrvhAjlWK9Yy
         XKiCwrmVVwDsH8QR0CYL2zVJ6IEo7c3ZpnzUyaoM=
Date:   Tue, 8 Feb 2022 09:26:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        Leonardo Araujo <leonardo.aa88@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: core: 'associcated' may be misspelled
 - perhaps 'associated'?
Message-ID: <YgIpMuShlOamHV68@kroah.com>
References: <20220207234210.26097-1-leonardo.aa88@gmail.com>
 <2122312.NgBsaNRSFp@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2122312.NgBsaNRSFp@leap>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:09:10AM +0100, Fabio M. De Francesco wrote:
> On martedì 8 febbraio 2022 00:42:10 CET Leonardo Araujo wrote:
> > This patch fixes the following checkpatch.pl warning:
> > 
> > CHECK: 'associcated' may be misspelled - perhaps 'associated'?
> > 
> > Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_ap.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> "Staging: r8188eu: core: 'associated' may be misspelled - perhaps 'associated'?" 
> it's not the way patch subjects are created for inclusion in Linux.

I do not see anything wrong with this.  What do you think is not
acceptable?

> Please follow what is clearly described in the "Philosophy of Linux kernel 
> patches" document at https://kernelnewbies.org/PatchPhilosophy...

The in-kernel documentation describes this well also.

> "In patch descriptions and in the subject, it is common and preferable to use 
> present-tense, imperative language. Write as if you are telling git what to do 
> with your patch.".
> 
> It's not my job to accept or reject patches for this subsystem and I don't want 
> to tell you what to write but, if I were you, I'd send a v2 with a subject like 
> "Fix misspelled word in comments" (or something else similar to this subject).
> 
> Furthermore, please take note that the name of this subsystem is "staging" (it 
> is not "Staging").

Either is fine, I will not reject a change for an upper-case letter like
this.

> Decide by yourself whether or not the other two patches that you submitted this 
> morning have to be sent anew as v2 with due changes in the subjects.

I do not see a problem with this change at all, nothing needs to be
resubmitted.

greg k-h
