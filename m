Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF773483DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiADIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:05:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59204 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiADIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:05:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC00EB8115E;
        Tue,  4 Jan 2022 08:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88958C36AE9;
        Tue,  4 Jan 2022 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641283552;
        bh=bBl6GFiQlIpAxFuDZscc9Ed/8davAxBQUYjawmSmJp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U25B1x40JDwVwqiiZ7/jb0pzBKytBy4bjxlaGvwRGJLFL4AbVTxid1g/NTO/z1bRK
         fVgRlrNisE6oHwIMiq4/zED7o8q6HXh+VA67IxGJxJo4tJlsTeMu3EMx3gH0JmtM6N
         dzTyOiXsDtv9JbY+jQDLljHZzBhgdog2/TGyAmAnQrdFMdl7Pgvu+kpHnl+7NpuGVb
         WKwoHMRhHsGtFiula+VbKxsAOrje+uInwZ0P+GYBaj81kb+HD37B8ZZA462riPPgiZ
         Y+lJQshJaitSKvMgWQAjHcvcc5sZL/HObDiiSXwKE4C9EWGuEjCzggWav+mJ8ynQ7Z
         eUIk+HjDBs2gQ==
Date:   Tue, 4 Jan 2022 09:05:48 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     hch@lst.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
Message-ID: <20220104090548.76112534@coco.lan>
In-Reply-To: <07f8cf68-525b-4fca-a1f9-fd40150fc6e1@gmail.com>
References: <87mtkcxws9.fsf@meer.lwn.net>
        <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
        <07f8cf68-525b-4fca-a1f9-fd40150fc6e1@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 4 Jan 2022 10:54:52 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro, see inline comments below.
> 
> On Tue, 4 Jan 2022 09:04:30 +0900, Akira Yokosawa wrote:
> > Hi,
> > 
> > On Mon, 03 Jan 2022 15:46:30 -0700, Jonathan Corbet <corbet@lwn.net> wrote:  
> >> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> >>  
> >>> After a change meant to fix support for oriental characters
> >>> (Chinese, Japanese, Korean), ctex stylesheet is now a requirement
> >>> for PDF output.  
> > 
> > FWIW, ctexhook.sty is a new requirement of xeCJK.sty v3.8.7 released
> > in June 2021.
> > 
> >         Thanks, Akira
> >   
> >>>
> >>> Reported-by: Christoph Hellwig <hch@lst.de>
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> >>> ---
> >>>
> >>> See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/
> >>>
> >>>  scripts/sphinx-pre-install | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> >>> index 288e86a9d1e5..46aaab414098 100755
> >>> --- a/scripts/sphinx-pre-install
> >>> +++ b/scripts/sphinx-pre-install
> >>> @@ -78,6 +78,7 @@ my %texlive = (
> >>>  	'ucs.sty'            => 'texlive-ucs',
> >>>  	'upquote.sty'        => 'texlive-upquote',
> >>>  	'wrapfig.sty'        => 'texlive-wrapfig',
> >>> +	'ctexhook.sty'       => 'texlive-ctex',
> >>>  );  
> >>  
> 
> I'm afraid this update of the list for Fedora/openSUSE won't help
> Debian Stable (bullseye) users.
> 
> ctexhook.sty is in texlive-lang-chinese on Debian/Ubuntu.

On such case, it is needed to map it for Debian/Ubuntu.
Could you please test the enclosed patch, applied on the top
of the previous one?

Thanks!
Mauro

-

[PATCH] scripts: sphinx-pre-install: Fix ctex support on Debian

The name of the package with ctexhook.sty is different on
Debian/Ubuntu.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 46aaab414098..ea96d18ee946 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -367,6 +367,7 @@ sub give_debian_hints()
 		"Pod::Usage"		=> "perl-modules",
 		"xelatex"		=> "texlive-xetex",
 		"rsvg-convert"		=> "librsvg2-bin",
+		"texlive-ctex"		=> "texlive-lang-chinese",
 	);
 
 	if ($pdf) {
