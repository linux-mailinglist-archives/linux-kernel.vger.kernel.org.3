Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD4485AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiAEVml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:42:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38442 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiAEVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:42:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 138D261958;
        Wed,  5 Jan 2022 21:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9F8C36AEF;
        Wed,  5 Jan 2022 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641418955;
        bh=Z62ZGw97M5RnmKYhjj7JfThBBVv+a2Z2kxNkIBQi58U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W0dwsUfuOWclBN5inU2x/cTojBZtAQk+RrkvLvXzPZu3vLDwZgyz/n2C6L0b4iD3B
         RALBXd6YmhgkGhiIhGzBjeGLfMJbX7KqHhYzg9kSNwjKrHagEpDH6K9qu9+Ok6uJvi
         eTWhqJ58X+yWCHwzQynjgnPseq6v/GmNIWaCuNmT0BFKL2aM4yxQcUMJLacd5LweMi
         RhJS12tfrzEp6PjLROj4ChOTtB8Z058jPK+ED423ixyzOv/2REdBz4htd2O50GDeTz
         +z2EtPbKZwceLFo93w6Kd6acWsg77H3FN6KMcHZM/DgXADo52RLoyLyMA+z7ZoaTHD
         2SJsRXDuo++4Q==
Date:   Wed, 5 Jan 2022 22:42:30 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     hch@lst.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
Message-ID: <20220105224230.0700351f@coco.lan>
In-Reply-To: <241d31e4-5447-a075-69b6-11c14427582d@gmail.com>
References: <87mtkcxws9.fsf@meer.lwn.net>
        <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
        <07f8cf68-525b-4fca-a1f9-fd40150fc6e1@gmail.com>
        <20220104090548.76112534@coco.lan>
        <73e62b16-7685-ace2-18d4-e1b79f543caf@gmail.com>
        <20220105084809.157e3f34@coco.lan>
        <241d31e4-5447-a075-69b6-11c14427582d@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 5 Jan 2022 21:09:59 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Wed, 5 Jan 2022 08:48:09 +0100, Mauro Carvalho Chehab wrote:
> > Em Tue, 4 Jan 2022 19:26:10 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> > 
> >> On Tue, 4 Jan 2022 09:05:48 +0100, Mauro Carvalho Chehab wrote:
> >>> Em Tue, 4 Jan 2022 10:54:52 +0900
> >>> Akira Yokosawa <akiyks@gmail.com> escreveu:
> >>>   
> >>>> Hi Mauro, see inline comments below.
> >>>>
> >>>> On Tue, 4 Jan 2022 09:04:30 +0900, Akira Yokosawa wrote:  
> >>>>> Hi,
> >>>>>
> >>>>> On Mon, 03 Jan 2022 15:46:30 -0700, Jonathan Corbet <corbet@lwn.net> wrote:    
> >>>>>> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> >>>>>>    
> >>>>>>> After a change meant to fix support for oriental characters
> >>>>>>> (Chinese, Japanese, Korean), ctex stylesheet is now a requirement
> >>>>>>> for PDF output.    
> >>>>>
> >>>>> FWIW, ctexhook.sty is a new requirement of xeCJK.sty v3.8.7 released
> >>>>> in June 2021.
> >>>>>
> >>>>>         Thanks, Akira
> >>>>>     
> >>>>>>>
> >>>>>>> Reported-by: Christoph Hellwig <hch@lst.de>
> >>>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/
> >>>>>>>
> >>>>>>>  scripts/sphinx-pre-install | 1 +
> >>>>>>>  1 file changed, 1 insertion(+)
> >>>>>>>
> >>>>>>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> >>>>>>> index 288e86a9d1e5..46aaab414098 100755
> >>>>>>> --- a/scripts/sphinx-pre-install
> >>>>>>> +++ b/scripts/sphinx-pre-install
> >>>>>>> @@ -78,6 +78,7 @@ my %texlive = (
> >>>>>>>  	'ucs.sty'            => 'texlive-ucs',
> >>>>>>>  	'upquote.sty'        => 'texlive-upquote',
> >>>>>>>  	'wrapfig.sty'        => 'texlive-wrapfig',
> >>>>>>> +	'ctexhook.sty'       => 'texlive-ctex',
> >>>>>>>  );    
> >>>>>>    
> >>>>
> >>>> I'm afraid this update of the list for Fedora/openSUSE won't help
> >>>> Debian Stable (bullseye) users.
> >>>>
> >>>> ctexhook.sty is in texlive-lang-chinese on Debian/Ubuntu.  
> >>>
> >>> On such case, it is needed to map it for Debian/Ubuntu.
> >>> Could you please test the enclosed patch, applied on the top
> >>> of the previous one?  
> >>
> >> Looks like we need an additional hunk.  See below.
> >>
> >>         Thanks, Akira
> >>
> >>>
> >>> Thanks!
> >>> Mauro
> >>>
> >>> -
> >>>
> >>> [PATCH] scripts: sphinx-pre-install: Fix ctex support on Debian
> >>>
> >>> The name of the package with ctexhook.sty is different on
> >>> Debian/Ubuntu.
> >>>
> >>> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> >>>
> >>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> >>> index 46aaab414098..ea96d18ee946 100755
> >>> --- a/scripts/sphinx-pre-install
> >>> +++ b/scripts/sphinx-pre-install
> >>> @@ -367,6 +367,7 @@ sub give_debian_hints()
> >>>  		"Pod::Usage"		=> "perl-modules",
> >>>  		"xelatex"		=> "texlive-xetex",
> >>>  		"rsvg-convert"		=> "librsvg2-bin",
> >>> +		"texlive-ctex"		=> "texlive-lang-chinese",
> >>>  	);
> >>>  
> >>>  	if ($pdf) {
> >>>   
> >> @@ -380,6 +381,7 @@ sub give_debian_hints()
> >>         }
> >>  
> >>         check_program("dvipng", 2) if ($pdf);
> >> +       check_missing_tex(2) if ($pdf);
> >>         check_missing(\%map);
> >>  
> >>         return if (!$need && !$optional);
> >>
> > 
> > This would be more complex than that, and per-distro tests are
> > required, in order to avoid the script to fail on other
> > distros.
> 
> Thank you for looking into this!
> I must admit I'm far from grasping how this perl script works...
> 
> > 
> > Something like the following (possibly incomplete) patch.
> 
> I'll test it under various distros/setups.
> It may take a while.

Did a quick test here with this lxc container:

	$ OS=debian REL=bullseye ;lxc-create -n ${OS} -t /usr/share/lxc/templates/lxc-download -- --dist ${OS} --release ${REL} --arch amd64

If we add check_missing_tex(), it will then complain about lots
of packages that don't exist in Debian (se logs at the end).

That's one of the biggest issue with texlive: each distro splits it on
different ways. So, basically, the %texlive hash at the script is meant
to the way Fedora and openSuse distros usually map packages. I would
expect that Mageia would also be similar if not identical, but other
distros map packages on different ways.

I'll prepare another patch for fixing the debian issue.

Regards,
Mauro

---

mchehab@debian:~/docs$ make pdfdocs
Documentation/Makefile:41: The 'sphinx-build' command was not found. Make sure you have Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point to the full path of the 'sphinx-build' executable.

Detected OS: Debian GNU/Linux 11.
Warning: better to also install "convert".
Warning: better to also install "dot".
Warning: better to also install "dvipng".
Warning: better to also install "fonts-dejavu".
Warning: better to also install "fonts-noto-cjk".
ERROR: please install "gcc", otherwise, build won't work.
Warning: better to also install "latexmk".
ERROR: please install "python", otherwise, build won't work.
Warning: better to also install "rsvg-convert".
Warning: better to also install "texlive-amscls".
Warning: better to also install "texlive-amsfonts".
Warning: better to also install "texlive-amsmath".
Warning: better to also install "texlive-anyfontsize".
Warning: better to also install "texlive-capt-of".
Warning: better to also install "texlive-cmap".
Warning: better to also install "texlive-ctex".
Warning: better to also install "texlive-ec".
Warning: better to also install "texlive-eqparbox".
Warning: better to also install "texlive-euenc".
Warning: better to also install "texlive-fancybox".
Warning: better to also install "texlive-fancyvrb".
Warning: better to also install "texlive-float".
Warning: better to also install "texlive-fncychap".
Warning: better to also install "texlive-framed".
Warning: better to also install "texlive-luatex85".
Warning: better to also install "texlive-mdwtools".
Warning: better to also install "texlive-multirow".
Warning: better to also install "texlive-needspace".
Warning: better to also install "texlive-oberdiek".
Warning: better to also install "texlive-parskip".
Warning: better to also install "texlive-polyglossia".
Warning: better to also install "texlive-psnfss".
Warning: better to also install "texlive-tabulary".
Warning: better to also install "texlive-threeparttable".
Warning: better to also install "texlive-titlesec".
Warning: better to also install "texlive-tools".
Warning: better to also install "texlive-ucs".
Warning: better to also install "texlive-upquote".
Warning: better to also install "texlive-wrapfig".
Warning: better to also install "xelatex".
You should run:

	sudo apt-get install imagemagick graphviz dvipng fonts-dejavu fonts-noto-cjk gcc latexmk python librsvg2-bin texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-capt-of texlive-cmap texlive-lang-chinese texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-luatex85 texlive-mdwtools texlive-multirow texlive-needspace texlive-oberdiek texlive-parskip texlive-polyglossia texlive-psnfss texlive-tabulary texlive-threeparttable texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-xetex
Can't build as 2 mandatory dependencies are missing at ./scripts/sphinx-pre-install line 943.
Documentation/Makefile:41: The 'sphinx-build' command was not found. Make sure you have Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point to the full path of the 'sphinx-build' executable.

Detected OS: Debian GNU/Linux 11.
Warning: better to also install "convert".
Warning: better to also install "dot".
Warning: better to also install "dvipng".
Warning: better to also install "fonts-dejavu".
Warning: better to also install "fonts-noto-cjk".
ERROR: please install "gcc", otherwise, build won't work.
Warning: better to also install "latexmk".
ERROR: please install "python", otherwise, build won't work.
Warning: better to also install "rsvg-convert".
Warning: better to also install "texlive-amscls".
Warning: better to also install "texlive-amsfonts".
Warning: better to also install "texlive-amsmath".
Warning: better to also install "texlive-anyfontsize".
Warning: better to also install "texlive-capt-of".
Warning: better to also install "texlive-cmap".
Warning: better to also install "texlive-ctex".
Warning: better to also install "texlive-ec".
Warning: better to also install "texlive-eqparbox".
Warning: better to also install "texlive-euenc".
Warning: better to also install "texlive-fancybox".
Warning: better to also install "texlive-fancyvrb".
Warning: better to also install "texlive-float".
Warning: better to also install "texlive-fncychap".
Warning: better to also install "texlive-framed".
Warning: better to also install "texlive-luatex85".
Warning: better to also install "texlive-mdwtools".
Warning: better to also install "texlive-multirow".
Warning: better to also install "texlive-needspace".
Warning: better to also install "texlive-oberdiek".
Warning: better to also install "texlive-parskip".
Warning: better to also install "texlive-polyglossia".
Warning: better to also install "texlive-psnfss".
Warning: better to also install "texlive-tabulary".
Warning: better to also install "texlive-threeparttable".
Warning: better to also install "texlive-titlesec".
Warning: better to also install "texlive-tools".
Warning: better to also install "texlive-ucs".
Warning: better to also install "texlive-upquote".
Warning: better to also install "texlive-wrapfig".
Warning: better to also install "xelatex".
You should run:

	sudo apt-get install imagemagick graphviz dvipng fonts-dejavu fonts-noto-cjk gcc latexmk python librsvg2-bin texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-capt-of texlive-cmap texlive-lang-chinese texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-luatex85 texlive-mdwtools texlive-multirow texlive-needspace texlive-oberdiek texlive-parskip texlive-polyglossia texlive-psnfss texlive-tabulary texlive-threeparttable texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-xetex
Can't build as 2 mandatory dependencies are missing at ./scripts/sphinx-pre-install line 943.
make[1]: *** [Documentation/Makefile:43: pdfdocs] Error 2
make: *** [Makefile:1772: pdfdocs] Error 2
mchehab@debian:~/docs$ sudo apt-get install imagemagick graphviz dvipng fonts-dejavu fonts-noto-cjk gcc latexmk python librsvg2-bin texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-capt-of texlive-cmap texlive-lang-chinese texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-luatex85 texlive-mdwtools texlive-multirow texlive-needspace texlive-oberdiek texlive-parskip texlive-polyglossia texlive-psnfss texlive-tabulary texlive-threeparttable texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-xetex
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Note, selecting 'python-is-python2' instead of 'python'
E: Unable to locate package texlive-amscls
E: Unable to locate package texlive-amsfonts
E: Unable to locate package texlive-amsmath
E: Unable to locate package texlive-anyfontsize
E: Unable to locate package texlive-capt-of
E: Unable to locate package texlive-cmap
E: Unable to locate package texlive-ec
E: Unable to locate package texlive-eqparbox
E: Unable to locate package texlive-euenc
E: Unable to locate package texlive-fancybox
E: Unable to locate package texlive-fancyvrb
E: Unable to locate package texlive-float
E: Unable to locate package texlive-fncychap
E: Unable to locate package texlive-framed
E: Unable to locate package texlive-luatex85
E: Unable to locate package texlive-mdwtools
E: Unable to locate package texlive-multirow
E: Unable to locate package texlive-needspace
E: Unable to locate package texlive-oberdiek
E: Unable to locate package texlive-parskip
E: Unable to locate package texlive-polyglossia
E: Unable to locate package texlive-psnfss
E: Unable to locate package texlive-tabulary
E: Unable to locate package texlive-threeparttable
E: Unable to locate package texlive-titlesec
E: Unable to locate package texlive-tools
E: Unable to locate package texlive-ucs
E: Unable to locate package texlive-upquote
E: Unable to locate package texlive-wrapfig
