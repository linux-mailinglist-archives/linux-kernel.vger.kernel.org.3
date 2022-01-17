Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38964910F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbiAQU16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235244AbiAQU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642451276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+lYxU3tVqA2sSSaMSI/HeSKHJBhjb7QNjws1JqnTIg=;
        b=D0xUKo7JW/IUVOKgDRCcP8+8cKPjhXj7hYZtl2Uat8z2XdqAsbta/AqFMkDyz1Ki9Vw8Ps
        SrGSxVem7ou8YtIVpql6rfWlfzE1blaqBZUgJ9LeiRFmVahtAD/Jrr3htWZk+hNStOIhLI
        TCn3jyKKXJEFi3Sov7tKfU1uRLSbb9A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-hNBY44byN7m84_IX3zZvTw-1; Mon, 17 Jan 2022 15:27:55 -0500
X-MC-Unique: hNBY44byN7m84_IX3zZvTw-1
Received: by mail-qv1-f69.google.com with SMTP id f7-20020a056214076700b0041c20941155so4354608qvz.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+lYxU3tVqA2sSSaMSI/HeSKHJBhjb7QNjws1JqnTIg=;
        b=RTY5Afu9pl1S04htd4yIDDci5i58z97/V+lvpzbXViAe0tDqXAvKtCkpFCNdvJgh5b
         BIYxjefbN2R2peSDAV+yDkxaiURe70H+jjWe/TyXO15q7F5bAPYkBCpgX7AqQiZbFvpc
         UK4HWDNlfDRV3oAwyl3ttmpo0PCaSJX5PFQKSxRDJt/cOds+ohlUqruwdZtGWTPZu3Ns
         2kMhhMW4R5wpQeeRL7wZDxEDApfBT5sPFS8jEqM5Y3SHLT8Z+WuISnfhwgUX0tfslopX
         3GkueqV+Q1WyfcJ5URVgDju++TrAeAJP6Fru+Z/i3EnIKN58tu3UgYrgwTqQQsN5xJ1k
         DVtA==
X-Gm-Message-State: AOAM533m/eqr9zV89F30CoASqjL+lOgoWiE47NRk3pddmKO4J2BE1Ud5
        MG7+POVfvi6HhfuSL6ZdR0aGzemSlqESnz/EEie9cJE4z2rdz/68Eg9GZVihPYRzJF8LvgPHevN
        Ja0tmOnj8+KSkwxC6imQBqTj8
X-Received: by 2002:a05:6214:f26:: with SMTP id iw6mr19691040qvb.67.1642451274761;
        Mon, 17 Jan 2022 12:27:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3XNICSdZNx6ynNTtHC90JL4P9Ip7fLcLdm1kojcwkjIVtaCVBn7LBIowiz1ljZavnrxt2tw==
X-Received: by 2002:a05:6214:f26:: with SMTP id iw6mr19691027qvb.67.1642451274500;
        Mon, 17 Jan 2022 12:27:54 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id r2sm2236608qkp.62.2022.01.17.12.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 12:27:53 -0800 (PST)
Date:   Mon, 17 Jan 2022 12:27:51 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
Message-ID: <20220117202751.bmwvfsnqxokob6d2@treble>
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220117194836.vj2rxr3wocrtdx7k@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:48:39AM -0800, Josh Poimboeuf wrote:
> On Mon, Jan 17, 2022 at 10:27:14AM +0530, Kaiwan N Billimoria wrote:
> > Hi there,
> > 
> > Am researching using the cool faddr2line script to help debug Oops'es
> > from kernel modules..
> > I find it works just fine when used against the unstripped vmlinux
> > with debug symbols.
> > 
> > My use case is for a kernel module which Oopses, though. Here's my scenario:
> > I built a module on a custom debug kernel (5.10.60) with most debug
> > options enabled...
> > KASLR is enabled by default as well.
> > 
> > A test kernel module Oopses on my x86_64 guest running this kernel with:
> > RIP: 0010:do_the_work+0x15b/0x174 [oops_tryv2]
> > 
> > So, i try this:
> > 
> > $ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x15b/0x174
> > bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> > $
> > 
> > (It works fine with addr2line though!).
> > Now I think I've traced the faddr2line script's failure to locate
> > anything down to this:
> > ...
> > done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 ==
> > fn { found=1; line    =$0; start=$1; next } found == 1 { found=0;
> > print line, "0x"$1 } END {if (found == 1) print     line, end; }')
> > 
> > The nm output is:
> > $ nm -n ./oops_tryv2.ko |grep -i do_the_work
> > 0000000000000000 t do_the_work
> > $
> > 
> > nm shows the text addr as 0x0; this is obviously incorrect (same 0x0
> > with objdump -d on the module).
> > Am I missing something? Any suggestions as to what I can try, to get
> > faddr2line working?
> 
> Hi Kaiwan,
> 
> Thanks for reporting this issue.  The module text address of 0x0 is not
> necessarily incorrect, as the address is relative the the module, where
> all text usually starts at zero.
> 
> I was able to recreate this problem using a module which only has a
> single function in .text.  Does this fix it?

Actually, that patch has other problems.  Try this one?

----

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] scripts/faddr2line: Only look for text symbols when
 calculating function size

With the following commit:

  efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")

... it was discovered that faddr2line can't just read a function's ELF
size, because that wouldn't match the kallsyms function size which is
printed in the stack trace.  The kallsyms size includes any padding
after the function, whereas the ELF size does not.

So faddr2line has to manually calculate the size of a function similar
to how kallsyms does.  It does so by starting with a sorted list of
symbols and subtracting the function address from the subsequent
symbol's address.

That calculation is broken in the case where the function is the last
(or only) symbol in the .text section.  The next symbol in the sorted
list might actually be a data symbol, which can break the function size
detection:

  $ scripts/faddr2line sound/soundcore.ko sound_devnode+0x5/0x35
  bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000

Similar breakage can occur when reading from a .o file.

Fix it by only looking for text symbols.

Fixes: efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6c6439f69a72..2a130134f1e6 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -189,7 +189,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
+	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$2 !~ /[Tt]/ {next} $3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
 }
 
 [[ $# -lt 2 ]] && usage
-- 
2.31.1

