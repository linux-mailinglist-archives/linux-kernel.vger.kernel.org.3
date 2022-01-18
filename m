Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2981B491E64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 05:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiAREIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 23:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245564AbiAREIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:08:47 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB34EC061574;
        Mon, 17 Jan 2022 20:08:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id i7-20020a17090a4b8700b001b4d486d9c2so501785pjh.4;
        Mon, 17 Jan 2022 20:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HAPEx1acaCP1M7+HDpwiBixmcTR8CIddXESJ3SH7olY=;
        b=iVW5/aO6a6deZsdE28WonY0b7GU9kU+ekkT8URjNU23dVYj6pvZeqAnqkObwTfAtTC
         PuEpbtTlVYpWn9U/XaYB2nNVHuN96oLnHmHX2AYd6DrLSbnl7hD+vV2wmfevcSan/ff8
         bMgx96PwzhTqG2t8EOfnQdcv88nVGf2sEOoQHOmboCvgDKVME31nsVQDA7/w7U3wcg+a
         pux1jWordsWrpd/ZR2r/UZjeww0Xq7yJ4M9gBIx9AG2EpmBKCFpCYt8aBIzBV/t2exFO
         oBF8kNofaCpBeXlPw0Oujn7wsBXWXAHGDThcIxhy7HnZM6YwuEoAQiGj3eZAqsm5kjDJ
         r8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAPEx1acaCP1M7+HDpwiBixmcTR8CIddXESJ3SH7olY=;
        b=bLUZNULHB+cw5kbDGvHnojoVKreG/cjoNEXyPYgxBKh5+x8xP5NObU+mX+naRiOnUH
         Bds8zz1DQecVI/0d6r+bzxnR7h1uU9j/BlxLKqmpTTzq8OY2/p3lfE4acDsj1PHETCyZ
         ZEtOQ3nNlSiQ3UJ3ECgUe6jDnzCXFv3TG36XwXBvMuKSORNloMy5dqvsbFLQ58x8rLmA
         symg+GmpBj9h7/MAztOyhXG1DInf7WmnviLsVRtJI6no/xpuUTRANPDfGHjV9RykDAiu
         ZSXnl3Rhbp7aNDpzK8o5iKWB2klcU8vg68BFZd2Wa6P/WfMUEvEoKwHoqd6daO9+h6Vk
         cSKw==
X-Gm-Message-State: AOAM5308J7kccDdUNSZSjXRe1FD3cJFJ2T1deEBBAhdJGSSrGJ9QxWxU
        Ye5BoV12XCeM+LI0t7QT5Ts=
X-Google-Smtp-Source: ABdhPJzNOBajz+OZsOHSDvNQdlR5gI+2zDZu7270b8u83fJJDmsjkyWRaDQ3yMoAaJY1bG+tdurCmw==
X-Received: by 2002:a17:902:ce90:b0:14a:7166:a186 with SMTP id f16-20020a170902ce9000b0014a7166a186mr25721216plg.107.1642478926428;
        Mon, 17 Jan 2022 20:08:46 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t128sm9096619pfd.219.2022.01.17.20.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 20:08:45 -0800 (PST)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220118010517.20826-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] Documentation: fix firewire.rst ABI file path error
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <dc527b05-2b65-cf88-c174-6fec6d458de4@gmail.com>
Date:   Tue, 18 Jan 2022 13:08:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220118010517.20826-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 17:05:17 -0800,
Randy Dunlap wrote:
> Adjust the path of the ABI files for firewire.rst to prevent a
> documentation build error. Prevents this problem:
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage: /work/lnx/next/linux-next-20220117/Documentation/driver-api/firewire.rst:22: (SEVERE/4) Problems with "include" directive path:
> InputError: [Errno 2] No such file or directory: '../Documentation/driver-api/ABI/stable/firewire-cdev'.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> I don't see what is causing this problem...

Randy, did you run "make SPHINXDIRS=driver-api htmldocs"?

I remember seeing similar errors with v5.14 or v5.15.
So I don't think this is a new issue.

Without "SPHINXDIRS=driver-api", I don't get this error on -next.

I didn't report it at the time as I was not sure it was expected
or not.

        Thanks, Akira

> 
>  Documentation/driver-api/firewire.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20220117.orig/Documentation/driver-api/firewire.rst
> +++ linux-next-20220117/Documentation/driver-api/firewire.rst
> @@ -19,7 +19,7 @@ of kernel interfaces is available via ex
>  Firewire char device data structures
>  ====================================
>  
> -.. include:: /ABI/stable/firewire-cdev
> +.. include:: ../ABI/stable/firewire-cdev
>      :literal:
>  
>  .. kernel-doc:: include/uapi/linux/firewire-cdev.h
> @@ -28,7 +28,7 @@ Firewire char device data structures
>  Firewire device probing and sysfs interfaces
>  ============================================
>  
> -.. include:: /ABI/stable/sysfs-bus-firewire
> +.. include:: ../ABI/stable/sysfs-bus-firewire
>      :literal:
>  
>  .. kernel-doc:: drivers/firewire/core-device.c

