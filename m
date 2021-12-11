Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC0247116E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 05:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbhLKE3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 23:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345848AbhLKE3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 23:29:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF854C061714;
        Fri, 10 Dec 2021 20:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hMJaezcaXFjxYvQz76vBf34HY8ePOcN+yipmVud6RxU=; b=CZvDQUgFscVaGgL7QlTR2KyfL9
        G7DpWBfmnrWgZyJKT6kl03bfskkyJNnw7LmPnH1ryqUvMQcL1UsbaavNe9fpiA5ZQIZK4L+fg7wtF
        oAiQ5hXlGKRWFISuvy91hr40LOGYW64raZjuICLkRsQCDOQuL2G/GLFtdVwHLe6h+ReqljwjDYhff
        cezSSsLftp9Zt6N4RTL0S7ws5YvrYilLPMuKeXG5bhlV5k5nCPJiDe327khtoBdVIgTtGR1fhvcI/
        lf32TBjVES+iWWJZBed6SB+LZyowGMB6j8TaaIaTATqkLHGyT3dTCShXzS0OZKWGybu5l2wi6mLCo
        pGRmx2KQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvtwo-00AwzR-4Q; Sat, 11 Dec 2021 04:25:23 +0000
Message-ID: <91c1afe2-a91e-5e67-f9d8-c98301989998@infradead.org>
Date:   Fri, 10 Dec 2021 20:25:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 0/4] docs: add better support for Sphinx themes and CSS
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, Alex Shi <alexs@kernel.org>
References: <cover.1638870323.git.mchehab+huawei@kernel.org>
Content-Language: en-US
In-Reply-To: <cover.1638870323.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro-

On 12/7/21 01:52, Mauro Carvalho Chehab wrote:
> Hi Jon,
> 
> This series comes after my patch fixing Sphinx support for RTD 1.0.0:
>  https://lore.kernel.org/lkml/80009f0d17ea0840d81e7e16fff6e7677919fdfc.1638004294.git.mchehab+huawei@kernel.org/
> 
> On this version, I renamed the vars to DOCS_CSS and DOCS_THEME,
> based on our previous discussion.
> 
> I also changed the description of patch 4, better explaining how to
> override the CSS theme and giving an example that looks fine,
> at least for my eyes.
> 
> -
> 
> Sphinx allows using different output templates for HTML (and e-pub).
> 
> Right now, the Kernel was hardcoded to use the Read the Docs theme,
> falling back to whatever default is setup on a given Sphinx version.
> 
> Well, themes and templates are actually an user preference.
> 
> This patch set allows selecting different themes and even provide
> extra CSS override files.
> 
> With that, one could, for instance, do things like:
> 
> $ echo "body { color: darkgreen; } div.body { color: darkgreen; } " >my_css.css && make SPHINXDIRS=input DOCS_CSS=my_css.css DOCS_THEME=nature htmldocs

When testing this one, I get:

make DOCS_THEME=nature DOCS_CSS=my_css.css    O=DOCS SPHINXDIRS=x86 -j9 htmldocs
make[1]: Entering directory '/work/lnx/next/next-2021-1210/DOCS'
  SPHINX  htmldocs --> file:///work/lnx/next/next-2021-1210/DOCS/Documentation/output/x86
make[3]: Nothing to be done for 'html'.
Using nature theme
WARNING: Unknown configure key: latex_elements['extrapackages']. ignored.
source directory: x86
cp: cannot stat 'my_css.css': No such file or directory
make[2]: *** [../Documentation/Makefile:96: htmldocs] Error 1
make[1]: *** [/work/lnx/next/next-2021-1210/Makefile:1783: htmldocs] Error 2
make[1]: Leaving directory '/work/lnx/next/next-2021-1210/DOCS'


'my_css.css' is in the top level of the kernel source tree:

$ ls -l  my_css.css
-rw-r--r-- 1 rdunlap users 59 Dec 10 20:16 my_css.css


> In order to use the Sphinx nature theme with the normal font in green.
> 
> patch 1 adds a theme selection make variable (DOCS_THEME);
> patch 2 adds a css selection variable (DOCS_CSS);
> patch 3 sets the classic theme to look a little better, as this will be
>   used if  the RTD theme is not installed;
> patch 4 adds support for the RTD dark mode theme, which seems to
>   be currently the only theme that allows the user to switch between
>   dark/light mode when visualizing the documentation.


Overall this is looking very good. Thanks for your work on it.

-- 
~Randy
