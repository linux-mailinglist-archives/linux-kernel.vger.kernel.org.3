Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7146A569
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348310AbhLFTPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242520AbhLFTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:15:42 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5624C061746;
        Mon,  6 Dec 2021 11:12:13 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 751CF4E5;
        Mon,  6 Dec 2021 19:12:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 751CF4E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638817933; bh=PH4s1a0/Y7y7NcCim60akyERAMn7F0Mb3gN/DfC8FsA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OB9UJulp3Ds9tqGj9IWBphc8QN4UA3qoisY2wENPBcQbHO1pPJvmVLuqocJUulqy1
         c/bNXbevG+fYGO5MIgqD4Aqg+Te+ZUzXFn1KiMIrXus2IgzQpzzkcZ3V42rwgfKhlY
         wXEMrDktdqfQ3/D1g1HCS/TuXPfIxkx3xCR3/B8SJpeTNjdx4oa/wi7wIc/l2ElySg
         P9vx3x6umK5mcVdMQiOZQI2SArSBmjE2HB39P7iHTSJXuuN1gRjGmDKjo3pBYEHIml
         cPk2RXYnd84uLE7dcORK6Dl5foczrhxFTyLg/sKltB6/S9UwkRcjP1DlevZhEAV/wi
         LqqUlRorm9p1A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] docs: allow selecting a Sphinx theme
In-Reply-To: <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
 <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
Date:   Mon, 06 Dec 2021 12:12:12 -0700
Message-ID: <878rwx35v7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Instead of having RTD as an almost mandatory theme, allow the
> user to select other themes via a THEMES environment var.
>
> There's a catch, though: as the current theme override logic is
> dependent of the RTD theme, we need to move the code which
> adds the CSS overrides to be inside the RTD theme logic.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>
> See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1638369365.git.mchehab+huawei@kernel.org/
>
>  Documentation/Makefile             |  3 ++
>  Documentation/conf.py              | 52 +++++++++++++++++-------------
>  Documentation/doc-guide/sphinx.rst |  8 +++++
>  3 files changed, 41 insertions(+), 22 deletions(-)

So I'm playing with this now, and definitely want to apply it.  I do
have one little worry, though...  THEME seems like an overly general
name to use here, and seems relatively likely to conflict with other
uses.  THEME= on the command line is fine, but what do you think about
something like DOCS_THEME for the environment variable?  Or even
HTML_THEME as Sphinx uses?

Thanks,

jon
