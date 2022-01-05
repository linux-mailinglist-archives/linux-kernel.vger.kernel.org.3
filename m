Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB770484ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbiAEHsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiAEHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:48:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C8EC061761;
        Tue,  4 Jan 2022 23:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F6A61678;
        Wed,  5 Jan 2022 07:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501BEC36AE9;
        Wed,  5 Jan 2022 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641368894;
        bh=qAR0DdsQmFnTTK5g9cuCROo8rZY6iVY+o+zsOmyEqiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTfm0IOJbaBHNG0fDqzl0kpIykh3n+CftOOWJcHeYzoKY8aGrBKuLqSK4bIlRia69
         DSJ3a1I9usMOCPGNacTyrz+R9HRapp1PGbQbdLukgDb+IH3dMeK+sM5i477i+FmsWI
         hLiXM1c+j8gm0y/3bypyqFPM+40gxaRB31Go6a5o90wUbEtqbJpysfN4jDKAJc1B2x
         jgzqmLnmh2ZNS1gfIwN9dqjfh24rO2+GJcVzegs34HJio4RmoQjqOf9rd41AoEGJci
         zxIrgXKljJt8Mh9Vcatw/8XaVQoOQHQPW6i1r7B4UhlV207surikYE2H2WMrWCPwXg
         SlHzKlagA1f8A==
Date:   Wed, 5 Jan 2022 08:48:09 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     hch@lst.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
Message-ID: <20220105084809.157e3f34@coco.lan>
In-Reply-To: <73e62b16-7685-ace2-18d4-e1b79f543caf@gmail.com>
References: <87mtkcxws9.fsf@meer.lwn.net>
        <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
        <07f8cf68-525b-4fca-a1f9-fd40150fc6e1@gmail.com>
        <20220104090548.76112534@coco.lan>
        <73e62b16-7685-ace2-18d4-e1b79f543caf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 4 Jan 2022 19:26:10 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Tue, 4 Jan 2022 09:05:48 +0100, Mauro Carvalho Chehab wrote:
> > Em Tue, 4 Jan 2022 10:54:52 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> >> Hi Mauro, see inline comments below.
> >>
> >> On Tue, 4 Jan 2022 09:04:30 +0900, Akira Yokosawa wrote:  
> >>> Hi,
> >>>
> >>> On Mon, 03 Jan 2022 15:46:30 -0700, Jonathan Corbet <corbet@lwn.net> wrote:    
> >>>> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> >>>>    
> >>>>> After a change meant to fix support for oriental characters
> >>>>> (Chinese, Japanese, Korean), ctex stylesheet is now a requirement
> >>>>> for PDF output.    
> >>>
> >>> FWIW, ctexhook.sty is a new requirement of xeCJK.sty v3.8.7 released
> >>> in June 2021.
> >>>
> >>>         Thanks, Akira
> >>>     
> >>>>>
> >>>>> Reported-by: Christoph Hellwig <hch@lst.de>
> >>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> >>>>> ---
> >>>>>
> >>>>> See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/
> >>>>>
> >>>>>  scripts/sphinx-pre-install | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> >>>>> index 288e86a9d1e5..46aaab414098 100755
> >>>>> --- a/scripts/sphinx-pre-install
> >>>>> +++ b/scripts/sphinx-pre-install
> >>>>> @@ -78,6 +78,7 @@ my %texlive = (
> >>>>>  	'ucs.sty'            => 'texlive-ucs',
> >>>>>  	'upquote.sty'        => 'texlive-upquote',
> >>>>>  	'wrapfig.sty'        => 'texlive-wrapfig',
> >>>>> +	'ctexhook.sty'       => 'texlive-ctex',
> >>>>>  );    
> >>>>    
> >>
> >> I'm afraid this update of the list for Fedora/openSUSE won't help
> >> Debian Stable (bullseye) users.
> >>
> >> ctexhook.sty is in texlive-lang-chinese on Debian/Ubuntu.  
> > 
> > On such case, it is needed to map it for Debian/Ubuntu.
> > Could you please test the enclosed patch, applied on the top
> > of the previous one?  
> 
> Looks like we need an additional hunk.  See below.
> 
>         Thanks, Akira
> 
> > 
> > Thanks!
> > Mauro
> > 
> > -
> > 
> > [PATCH] scripts: sphinx-pre-install: Fix ctex support on Debian
> > 
> > The name of the package with ctexhook.sty is different on
> > Debian/Ubuntu.
> > 
> > Reported-by: Akira Yokosawa <akiyks@gmail.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > 
> > diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> > index 46aaab414098..ea96d18ee946 100755
> > --- a/scripts/sphinx-pre-install
> > +++ b/scripts/sphinx-pre-install
> > @@ -367,6 +367,7 @@ sub give_debian_hints()
> >  		"Pod::Usage"		=> "perl-modules",
> >  		"xelatex"		=> "texlive-xetex",
> >  		"rsvg-convert"		=> "librsvg2-bin",
> > +		"texlive-ctex"		=> "texlive-lang-chinese",
> >  	);
> >  
> >  	if ($pdf) {
> >   
> @@ -380,6 +381,7 @@ sub give_debian_hints()
>         }
>  
>         check_program("dvipng", 2) if ($pdf);
> +       check_missing_tex(2) if ($pdf);
>         check_missing(\%map);
>  
>         return if (!$need && !$optional);
> 

This would be more complex than that, and per-distro tests are
required, in order to avoid the script to fail on other
distros.

Something like the following (possibly incomplete) patch.

Thanks,
Mauro

[PATCH RFC] scripts: sphinx-pre-install: better handle pdf dependencies

Not all distro hints check for missing LaTeX dependencies.
So add a call for it for check_missing_tex() to all distros.

While here, change the parameters to pass the map hash, as
distro-specific mapping could be needed.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index ea96d18ee946..03c252590e54 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -227,7 +227,8 @@ sub check_pacman_missing($$)
 
 sub check_missing_tex($)
 {
-	my $is_optional = shift;
+	my $map = %{$_[0]};
+	my $is_optional = 2;
 	my $kpsewhich = findprog("kpsewhich");
 
 	foreach my $prog(keys %texlive) {
@@ -381,6 +382,7 @@ sub give_debian_hints()
 	}
 
 	check_program("dvipng", 2) if ($pdf);
+	check_missing_tex(\%map) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -449,7 +451,7 @@ sub give_redhat_hints()
 
 	check_rpm_missing(\@fedora26_opt_pkgs, 2) if ($pdf && !$old);
 	check_rpm_missing(\@fedora_tex_pkgs, 2) if ($pdf);
-	check_missing_tex(2) if ($pdf);
+	check_missing_tex(\%map) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -503,7 +505,7 @@ sub give_opensuse_hints()
 	# "Noto Sans CJK SC" on openSUSE
 
 	check_rpm_missing(\@suse_tex_pkgs, 2) if ($pdf);
-	check_missing_tex(2) if ($pdf);
+	check_missing_tex(\%map) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -548,6 +550,7 @@ sub give_mageia_hints()
 	}
 
 	check_rpm_missing(\@tex_pkgs, 2) if ($pdf);
+	# check_missing_tex(\%map) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -578,6 +581,7 @@ sub give_arch_linux_hints()
 				   "noto-fonts-cjk", 2);
 	}
 
+	check_missing_tex(\%map) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -604,6 +608,8 @@ sub give_gentoo_hints()
 				   "media-fonts/noto-cjk", 2);
 	}
 
+	# Gentoo doesn't need to map tex, as there's a single package,
+	# and extra fonts are mapped via check_missing_file()
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -622,7 +628,7 @@ sub give_gentoo_hints()
 		printf("\tsudo su -c 'echo \"$cairo\" > $portage_cairo'\n");
 	}
 
-	printf("\tsudo emerge --ask $install\n");
+	printf("\tsudo USE="-cjk" emerge --ask $install\n");
 
 }
 
@@ -685,7 +691,7 @@ sub check_distros()
 	my %map = (
 		"sphinx-build" => "sphinx"
 	);
-	check_missing_tex(2) if ($pdf);
+	check_missing_tex(\%map) if ($pdf);
 	check_missing(\%map);
 	print "I don't know distro $system_release.\n";
 	print "So, I can't provide you a hint with the install procedure.\n";

