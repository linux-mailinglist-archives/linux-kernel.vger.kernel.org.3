Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C837148F45E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 03:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiAOCQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 21:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiAOCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 21:16:38 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEADC061574;
        Fri, 14 Jan 2022 18:16:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a5so4351171pfo.5;
        Fri, 14 Jan 2022 18:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GhtO3G0vvXRrIVaPWG9MifsIuKW68vqTseRFdmwK/VA=;
        b=jRA3u11br7x72YzaahbRFWeZDSDFC8+gLKnrudbYwKnbLICQmCljXTelR/nCZMo1iP
         PdYYtt58ABapVq6g9lRZkDPzAwquMi57j8T9mek26lIAHmvKkoedu316bWQroBGXuxnb
         +auwxZ+69PB6GOOB5c6T4DaTBsZSRpUGiFsuDh4BfzKEF078RIbj36FZgLgQEHJNNT/f
         KfzEQQfBjD0OxJwGOuFhgOCoTYfpPF/E8+YKEVuM0hS707LlfDVPVHCw93VpuTavrPa7
         FPtTgnrEZ/01jEzJ5KHfJqRB5y68/NY40Es/+8PEMv/4gs8m9tDHLHCANl3yV5uwLLmt
         KCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GhtO3G0vvXRrIVaPWG9MifsIuKW68vqTseRFdmwK/VA=;
        b=EfF1X5SID2ypLv79JQx9itryBvT7aTaVl3PJh7i1kw7xjhWLcbvhxv+RM9JVth/YRv
         wSyYki2oQm1MAKLUXO9FF+sHj7i0lr4SINo/KpgxbU6RfSbi7P9OHNLqLu2MCjzZvTIi
         27DdKLeCDlb0cvEZbEKOBwnSyvDFsMRHLJuRdfQvG5qRtn06eMF49VqdERUSzLKdi8Gx
         iA48oQmzj0kzqTWWKuNEzSX2sAe7vbVhBaLma+TwVVYn0rUYNwFTlDBmtdB4NVCF6zQ3
         pscvHTtfjJEjrvoVHVe6OjLsrjPIAtikXig5QAxmi8Wmkbi2stzx0IealDieDMhjgFto
         +qsQ==
X-Gm-Message-State: AOAM530qoTHL+vH2VXsEMHgvq2Cz0WtgZR0BiO6oEEzb+O2Bel5R2PtO
        /6dmnJJ6+/jV2YfSLc+N87U=
X-Google-Smtp-Source: ABdhPJx828tltAw+f8FrEdwoh/U2ENETHc1ygIMUCwIE4h04CnFDvVxVf+auOSv+GKcwgKaaDEuP0A==
X-Received: by 2002:a05:6a00:1c6c:b0:4be:ac47:c045 with SMTP id s44-20020a056a001c6c00b004beac47c045mr11405393pfw.57.1642212997791;
        Fri, 14 Jan 2022 18:16:37 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p10sm6885880pfw.87.2022.01.14.18.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 18:16:37 -0800 (PST)
Subject: Re: [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
 <e545803a-8f09-f0e7-4ca0-16b673ef1796@gmail.com>
 <20220114094535.5bb9ba94@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <e03de287-4eef-8a68-89f3-8614db66a74b@gmail.com>
Date:   Sat, 15 Jan 2022 11:16:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114094535.5bb9ba94@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 09:45:35 +0100,
Mauro Carvalho Chehab wrote:
> Em Fri, 7 Jan 2022 22:45:47 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Wed, 29 Dec 2021 20:42:00 +0900, Akira Yokosawa wrote:
>>> This patch set improves conversions of DOT -> PDF and SVG -> PDF
>>> for PDF docs.  
>>
>> Gentle ping.
>>
>> Mauro, any comments?
> 
> Sorry, have been busy those days with not much time to test it,
> and I'm not expecting any time to test it on the next couple of
> weeks.

Mauro, no need of apologies.

We are in the middle of the v5.17 merge window, and I think of this
series as a v5.18 material.
Which means it won't be merged into doc-next until v5.17-rc5 or -rc6
(mid March or so), unless Jon thinks otherwise.

I'd like to have your Tested-by: and/or Reviewed-by: tags if you
could manage to spare time for testing.

> 
> The main concern from my last review is that inkscape is too noisy 
> (well, frankly, textlive is also too noisy).

You mean the harmless warning msgs delegated to kernellog.verbose()?
Or the direct redirection to /dev/null as of v1's 3/3?

>                                               If this was solved
> on a nice way,

An excerpt of messages from Inkscape is as follows
(on Debian bullseye, with "make SPHINXOPTS=-v SPHINXDIRS=doc-guide pdfdocs"):

----------
convert SVG to: {out}/svg_image.pdf
Warning msg from inkscape(1) (likely harmless):
Unable to init server: Could not connect: Connection refused
Failed to get connection
** (inkscape:119): CRITICAL **: 01:58:03.988: dbus_g_proxy_new_for_name: assertion 'connection != NULL' failed

** (inkscape:119): CRITICAL **: 01:58:03.988: dbus_g_proxy_call: assertion 'DBUS_IS_G_PROXY (proxy)' failed

** (inkscape:119): CRITICAL **: 01:58:03.988: dbus_g_connection_register_g_object: assertion 'connection != NULL' failed

** (inkscape:119): WARNING **: 01:58:04.300: Fonts dir '/usr/share/inkscape/fonts' does not exist and will be ignored.

assert best format for: hello.dot
convert DOT to: {out}/hello.pdf
Warning msg from inkscape(1) (likely harmless):
Unable to init server: Could not connect: Connection refused
Failed to get connection
** (inkscape:129): CRITICAL **: 01:58:04.454: dbus_g_proxy_new_for_name: assertion 'connection != NULL' failed

** (inkscape:129): CRITICAL **: 01:58:04.454: dbus_g_proxy_call: assertion 'DBUS_IS_G_PROXY (proxy)' failed

** (inkscape:129): CRITICAL **: 01:58:04.454: dbus_g_connection_register_g_object: assertion 'connection != NULL' failed

** (inkscape:129): WARNING **: 01:58:04.628: Fonts dir '/usr/share/inkscape/fonts' does not exist and will be ignored.
[...]
----------

On Fedora 35, I don't see any message from Inkscape.

Is this acceptable to you?

>                 and provided that the output files on both html and
> pdf are working fine with those conversions, I don't have any 
> objections to this series.

This series affects only PDF.
My test coverage is not perfect, but I don't expect any regression
in "make pdfdocs" or "make htmldocs".

        Thanks, Akira

> 
> Regards,
> Mauro
> 
[...]
