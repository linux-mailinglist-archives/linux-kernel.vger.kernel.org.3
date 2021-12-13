Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3927A471FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhLMD71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhLMD70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:59:26 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333ECC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 19:59:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t23so21634581oiw.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 19:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OtQHb3uGVvvleXWJLYhGFtxLvxFVtU+Bbl9uaeK7i8c=;
        b=TUh65o6wo7281h2otq7gQvCynFBYMPZdz1plxh8eAGjj5/6nyKLSD4HcMuPYjnrw5/
         caVfSro6kGt44Euv32EmnqTf7ioAN35BwWUlnT/cCqM5hmmt5Do76QfVnM45jODOBRK6
         dDd+7P3NvRjzY3g7PnOtPgqMxv9y8CmTjwcDkwSVA/HyNhERTJR3DP9RfyIuUa01hAI6
         ejt9Umx1CE6anw//fTyrkkRwIccr+Q8KGgSrhF+fPXCTRZueBs3niXTluz37GQSJRALn
         MYcFYRO7McxXCOBRn65UBwUq9s5tAxjHq+d+tIu3PyW/g0lZzLSzT5P+uIdT6CXRbUPn
         oEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OtQHb3uGVvvleXWJLYhGFtxLvxFVtU+Bbl9uaeK7i8c=;
        b=0Q5YT+PZ2fnoZpLUweKRKjWhSxKyK33UzlWYnUQjxXHG/oTt7ZFqypobgDL2K11gaP
         1tYU53r1sjcut4Nwadi4BeLxY2Oyz+PHYFVCv+KyYBzyUqT0+OxMt9uQs0b/5ty6YrrJ
         dlBpAkZiG+1gfgvpEgm3wjIWB8WHdk314u3VHQs0KNtuCp5geJowUmvwkBlnnbrl0K7v
         8zYN1DSUzX4Nl3fWp+QhMTCma1DpH+2KhlFjv8TsXGwZQO/F71f8WX+WOi/RdD6Eqdyx
         NpPHAB5T5YHs0cD4miWWEnFuAG4HzCvKoVyEQflbONgR4Zz8Hnz5goYYaiRU321uFtqU
         4rmQ==
X-Gm-Message-State: AOAM530QSlGUFnuUdZH3AoQbeMyIwidWCRZgXFD3rTTrmD9tdsEBDJci
        3ddAjr7Jnm0oh6rMwZ9Frd38JpxbscU=
X-Google-Smtp-Source: ABdhPJwFMtgs8idiTbiHky4rp63Kquzq77GK9/+p8qUrcOWue2HGHX4EGmsIjJMv545V2KwmIzlegQ==
X-Received: by 2002:a05:6808:d54:: with SMTP id w20mr25519021oik.146.1639367965327;
        Sun, 12 Dec 2021 19:59:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s6sm2543246ois.3.2021.12.12.19.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 19:59:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Dec 2021 19:59:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc5
Message-ID: <20211213035923.GA735445@roeck-us.net>
References: <CAHk-=wixe1NPqC0PmgUbV0Xoa8D0Pbyu7X_0sfABYMG+ocLdbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wixe1NPqC0PmgUbV0Xoa8D0Pbyu7X_0sfABYMG+ocLdbQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 03:24:52PM -0800, Linus Torvalds wrote:
> So everything looks fairly normal. This rc5 is perhaps a bit bigger
> than usual, but it's not like it's breaking any records. I blame
> people trying to get stuff done before the holidays, and/or just
> random timing effects.
> 
> Anyway, I do expect things to calm down over the next couple of weeks,
> but we'll see.
> 
> As to rc5, the patch is dominated by drivers (network, sound, hid,
> rdma, usb... and a lot of other random things) and selftest updates
> (bpf, kvm and networking).
> 
> The rest is fairly random - filesystems (cifs, btrfs, tracefs), core
> kernel and networking. Some fixups to the new damon virtual address
> space monitoring code.
> 
> Shortlog appended.
> 
> Do give it a good testing - with the holidays coming up, things are
> probably going to slow down both on the development and testing front,
> and as a result I expect that I will also extend the rc series by
> another week not because it's necessarily needed (too early to tell,
> but doesn't feel that way), but simply because nobody will want to
> open the next merge window immediately in the new year.
> 

Build results:
	total: 153 pass: 152 fail: 1
Failed builds:
	mips:allmodconfig
Qemu test results:
	total: 480 pass: 480 fail: 0

Same old.

Building mips:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

Guenter
