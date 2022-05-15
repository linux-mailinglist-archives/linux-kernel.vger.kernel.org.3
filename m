Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB4527689
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiEOJL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiEOJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:11:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4F2BB3D;
        Sun, 15 May 2022 02:11:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 204so11477315pfx.3;
        Sun, 15 May 2022 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=hfMVvEM6vaHEBJKHF5ti7tr+GNbeVh1Fj7Lz2XuFJas=;
        b=SKdkUX8smXfIVh75dXPn/LgIXpyOmdAoijupL4g/kIA8g9JeXMK7b+Z344rZFKM3jq
         zgA7PjVaTg8ifJs6TE6Yqb18v0lWJHlv8r9Vf6B0KESH8bOfmRBZROVrcofhpP8nTDXs
         Kiwd7KPtTq8QbGqio+c24HjZZ3x0ZT8PN1YHWPxIzBzRIFVd0IlBTO6fyRkDEVFX3IqT
         s1d5L6dhN8q40R4EDwiSuPhp24Qq2t4hAdHUeG7ifOBnP61yaz3EIv7wfyUpqzuThi4G
         y0TQJEJSJytFYD7InHLQmcRfV0jOsgJgUzODPQrKRbbRGghQXEeh4XmV23dnG9hjnhse
         NcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=hfMVvEM6vaHEBJKHF5ti7tr+GNbeVh1Fj7Lz2XuFJas=;
        b=7CB0ZZBYDFOkEBOm3YTXc1dClwiWOPz0uBl5SsXDFLPHb9lcYBCBGF2CRLpwYVbOZt
         MuSuSVhKas8bYEBfNlDhMnS4nJ7+EzmFVHlgC/SpVL5rUsvf2RgGgVT9BnckkgqQWYKr
         5bts7N6q0NXyxB/+QYsawzSuWqk6dc71p55ec60UXmOCpTHIXtltwznWwD6knMoZcbBE
         9Yb6BjselnWL5uaUt+6xJBcwfRfh6VdxgWVy8ZNdIIVFUqno56bEKEme4jdMReZSNnce
         5OfwTSONO6r5WSNZdEOjTZsvdrFrHI+zfRbjJDqZd8l6j5EmsGYHYEDLwiC4bASCQL3c
         UY2g==
X-Gm-Message-State: AOAM532sUZgzm8ZqzoG57bu8uatKEz2ba9si8G4n0VG12WhhzXTPCABv
        3d6yOQMREofZ3Z0M0NVlK8o=
X-Google-Smtp-Source: ABdhPJzQ26g/dK+hBG4nIji59oNyIp7QYa2TAHLdsXCiQIbXoIyj4m0AqCey4lEXiAeEL3j4FdDqCg==
X-Received: by 2002:aa7:88d1:0:b0:510:3ee2:3f25 with SMTP id k17-20020aa788d1000000b005103ee23f25mr12370982pff.41.1652605911755;
        Sun, 15 May 2022 02:11:51 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090322c100b0015e8d4eb2besm4768941plg.264.2022.05.15.02.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:11:51 -0700 (PDT)
Message-ID: <f4d40da6-756b-9e75-b867-cc9eedc4b232@gmail.com>
Date:   Sun, 15 May 2022 18:11:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk>
Subject: Re: [PATCH 0/3] Documentation: Fix issues with Oxford Semiconductor
 PCIe (Tornado) 950
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Fri, 13 May 2022 23:41:57 +0100 (BST),
Maciej W. Rozycki wrote:
> Hi,
> 
[...]
> 
>  For the latter command however I need to note that several other 
> documents in our Documentation/ tree suffer from a problem that causes 
> `make pdfdocs' to fail (and the failure cannot be worked around with 
> make's `-k -i' options, i.e. no output is ever produced), e.g.:
> 
> Markup is unsupported in LaTeX:
> filesystems/9p:: nested tables are not yet implemented.
> 
> and similarly for: filesystems/erofs, filesystems/f2fs, filesystems/ntfs, 
> networking/device_drivers/ethernet/dlink/dl2k, scsi/arcmsr_spec, 
> scsi/g_NCR5380, scsi/ncr53c8xx, and scsi/sym53c8xx_2.  I don't know if it 
> is a known problem, possibly addressed in a newer version of tools, so 
> I've thought it might be worth reporting.
> 
[...]
> 
>  NB XeTeX, Version 3.14159265-2.6-0.99999 (TeX Live 2019/dev/Debian) and 
> Sphinx 1.8.4 here.

As mentioned in the section titled "PDF and LaTeX builds" in
Documentation/doc-guide/sphinx.rst, "make pdfdocs" requires Sphinx 2.4 or
later.

Another hint for you.

You can say "make SPHINXDIRS=<sub dir> htmldocs pdfdocs" to
test-build docs under Documentation/<sub dir>/.
You might see false warnings of "WARNING: undefined label: ..."
which you wouldn't see in full builds, though.

Hope this helps.

I see there is no mention of the SPHINXDIRS make variable in the
doc-guide.  I'll see it can be explained somewhere in sphinx.rst.

        Thanks, Akira
> 
>  The issues are not directly related to the changes proposed here though,
> so please apply them.
> 
>   Maciej

