Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0983A46791A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381344AbhLCOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:11:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45940 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352478AbhLCOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:11:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F93A62B10;
        Fri,  3 Dec 2021 14:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7F4C53FC7;
        Fri,  3 Dec 2021 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638540508;
        bh=eDoEsNNsQZ17vVQwvSAUdLea63vK4M1VwU4kJH81afU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ON2iTtZ47aa327omlPy9Dxj9VtrvSjufKZu/0XOqeeu6GIw1GTDJ3tWa8P0G3u0A5
         VcioyuqtlHNPOkjJNoq00rTvwP8EFCz04GkxzhTVTF1MEl+j6DI8gvV2OiW1uAZBIq
         aFCb7L7OxkXlzlx+HXSo+AbeqGT33iPWAOe0+Id7tt+bU9RVpduAz0PV1ne0LkDl42
         NdD7tJ1ZqjjgocXZd1lVUkNekDirvPjQv3gsKWUG6PoJtVSjYZYQfll7IbFi/HAQTk
         pTaWPSnHW1XRTulExZMYqj1klEb3xyYpS+NowLdWQJhLiCu6rt8t+dmubXDF1byx4L
         Wf71u5K63W9zw==
Date:   Fri, 3 Dec 2021 15:08:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v3 1/4] docs: allow selecting a Sphinx theme
Message-ID: <20211203150822.54a81cbb@coco.lan>
In-Reply-To: <20211202124700.7e395897@coco.lan>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
        <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
        <CANiq72nu9TvLzxxj64b+EwFicwGexT7VTmVYVnVDzQgwkk+9ZA@mail.gmail.com>
        <20211202124700.7e395897@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 2 Dec 2021 12:47:00 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 2 Dec 2021 12:24:53 +0100
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> escreveu:
> 
> > On Wed, Dec 1, 2021 at 6:59 PM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:  
> > >
> > > Instead of having RTD as an almost mandatory theme, allow the
> > > user to select other themes via a THEMES environment var.
> > >
> > > There's a catch, though: as the current theme override logic is
> > > dependent of the RTD theme, we need to move the code which
> > > adds the CSS overrides to be inside the RTD theme logic.    
> > 
> > Does Sphinx support leaving the selection of the theme to "runtime",
> > i.e. to let users pick a theme from a few from a combobox (e.g.
> > light/dark)?
> > 
> > I assume not, but asking just in case.  
> 
> The RTD dark theme allows that. It basically places a <sun>/<moon>
> icon. When such icon is clicked, it switches between light/dark.

Btw, I'm now using it at:

	https://linuxtv.org/downloads/v4l-dvb-apis-new/index.html

As we use a dark theme at linuxtv.org since ever.

It was built with the following script:

	CSS=linuxtv.css
	THEME=sphinx_rtd_dark_mode

	cat << EOF > $CSS
	  html body {
	    font-family: arial,helvetica,sans-serif;
	    margin: 0px;
	    padding: 0px;
	  }
	  html[data-theme='dark'] body {
	    color: white !important;
	  }
	  html[data-theme='dark'] .sig-name {
	    color: green !important;
	  }
	  html[data-theme='dark'] .wy-menu-vertical a {
	    color: #ffcc00 !important;
	  }
	  html[data-theme="dark"] h1, html[data-theme="dark"] h2, html[data-theme="dark"] h3 {
	    color: #ffcc00 !important;
	  }
	  html[data-theme="dark"] h4, html[data-theme="dark"] h5, html[data-theme="dark"] h6 {
	    color: #ffcc00 !important;
	  }
	  html[data-theme="dark"] h7, html[data-theme="dark"] h8, html[data-theme="dark"] h9 {
	    color: #ffcc00 !important;
	  }
	  html[data-theme="dark"] .wy-nav-content a, html[data-theme="dark"] .wy-nav-content a:visited {
	    color: #ffcc00 !important;
	  }
	EOF

	make SPHINXDIRS='media' CSS='$CSS' THEME='$THEME' htmldocs

Thanks,
Mauro
