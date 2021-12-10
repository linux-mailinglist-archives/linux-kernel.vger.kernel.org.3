Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77B5470C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbhLJVaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:30:39 -0500
Received: from ms.lwn.net ([45.79.88.28]:53648 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235807AbhLJVae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:30:34 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E76092CC;
        Fri, 10 Dec 2021 21:26:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E76092CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639171618; bh=X4CiTWJFSJN/F+ck+oupzcB0TgOMku3lpzfLUKQRz9E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TzAGLqZ0iJPBiibtFrDQECcXBGxnbpZKnDpbTsucGR8sasrTO9ZRFxRK3E3Y94XXp
         kZbvmlavyMz2alH54MSMJ38R+Goq6ZBa/iORIh2XyB9LQZMfjhweKKpCln77coQaiB
         TFmUro48n1Ypo/ENAZ9vJC82iTt2ZEoGkPA3IZDGe7JqxHdufTbUYP+Ajtb7QHIjZQ
         zSzeIPoZKr5xsuPe0J9K86ODusxEi74fDXxMZT5idcpWIw/AWwlYSslvE02OnWmbPu
         Pl5Qru+oHITh8Kgx95rwxhmTg9VfvCaS7yuB4oqBZ++uqyuziYg7HfHCNfrUjDQlXw
         otSYlt7lJXmwg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>, Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v4 0/4] docs: add better support for Sphinx themes and CSS
In-Reply-To: <cover.1638870323.git.mchehab+huawei@kernel.org>
References: <cover.1638870323.git.mchehab+huawei@kernel.org>
Date:   Fri, 10 Dec 2021 14:26:57 -0700
Message-ID: <87ilvwqhge.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

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

I've applied the set, thanks.

jon
