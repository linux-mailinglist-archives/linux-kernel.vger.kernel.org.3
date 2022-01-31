Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4074A4089
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiAaKzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiAaKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:55:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1876C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:55:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u14so25937516lfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=o12ziMwfhRAv4Y8yIpDTd9CVii+Lz/UC4YUFGN0mD+4=;
        b=kZGVV9YswfPgPJXnCV8na0vQVbzhjWz64FS0Z/ItOVhkij8oOXcS8yJSCeBpgUnmLV
         Un4eW5RA//kdu0yVyzyWHbjXzBkHW6Srz7OhDfw+rsLcZtOelJkUJtuJYXYDmRn9zfAs
         13+c5JrelzeJ5ewR/yzgNRAu09EPURxnmaq5BtySmTMSnGgW5lGf8g7OMTWV0pm6BhG0
         uRkxbX2Nj45jl/SviekcXZCznismFZl40uDN9b5OLMXF30SYtNqlp9dw6XY+CuXOTW/0
         PweiY/KSCEMxee93W+5Vzh9p06mZdKS31g4Jg50KyltEvdJVNhw5oEQmtblWu8XEPUK7
         ochg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=o12ziMwfhRAv4Y8yIpDTd9CVii+Lz/UC4YUFGN0mD+4=;
        b=58YDLV+eHS3ADh1Sx0blDuGadVWLkKEzwoTEHIFJMDy1heE2CKhwjRH0WwUOhC/gB+
         DfM23VFdpJYgXoIAc2qSbHXGEw7mg96L/2esfOs4pnZws5vWq5DQAZZqf1N6Ru8Loiea
         SHb4MLuAHc+2LpgsD2Tsv5b5oBCvRWuF/Ddrrd8uxxJ3t2ACK7fD5r2YhKxPCieWUjtX
         FIozYK0weW3p4AD645IKKyBmk7ZbBpm6Ua4pUu/aOxBuz8vcBLdLAwtisBuZbpM1wqK5
         im1J0e5QxlsopOwJd+okThIOP9DJnaOY0oFrn+M6e/73BED8WesSlB0CAI/PMsMtw7O8
         cmpQ==
X-Gm-Message-State: AOAM531wptbGsjLzNO0MU72jZbytH1cEvfkGaVSErEG22CYUBb11we1i
        IvjALpr+we3XHysRm+pqbhE=
X-Google-Smtp-Source: ABdhPJyXyc71R0pt5d2tCiK1t2yweLeVbKbv1Qos9KZ7zi3zkvx28nqtZgxGllxcVdFhy54suXkWvA==
X-Received: by 2002:a05:6512:2283:: with SMTP id f3mr14941442lfu.198.1643626541085;
        Mon, 31 Jan 2022 02:55:41 -0800 (PST)
Received: from [192.168.50.104] (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id h19sm1783458ljh.29.2022.01.31.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 02:55:40 -0800 (PST)
Message-ID: <5e2c456af89b60c845db2232664f6f9694aa9840.camel@gmail.com>
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Jan 2022 11:55:39 +0100
In-Reply-To: <YfbQlMyohx31FhSW@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
         <YfKngOPLeI3rQOn3@casper.infradead.org>
         <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
         <Yfa4WMeauvmgkQ9H@kernel.org> <YfbQlMyohx31FhSW@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Sun, 2022-01-30 at 17:53 +0000, Matthew Wilcox wrote:
> I think I found a deeper problem which is masked due to our maze of
> header files:
> 
> include/asm-generic/io.h:#ifndef virt_to_phys
> include/asm-generic/io.h:#define virt_to_phys virt_to_phys
> 
> so there's an assumption that <asm/io.h> defines virt_to_phys().
> You can see that in a number of architectures, eg:
> 
> arch/alpha/include/asm/io.h:static inline unsigned long
> virt_to_phys(volatile void *address)
> arch/ia64/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/mips/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/nios2/include/asm/io.h:#define virt_to_phys(vaddr) \
> arch/parisc/include/asm/io.h:#define virt_to_phys(a) ((unsigned
> long)__pa(a))
> arch/powerpc/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/sh/include/asm/io.h:#define virt_to_phys(address)  ((unsigned
> long)(address))
> arch/x86/include/asm/io.h:#define virt_to_phys virt_to_phys
> 
> That's clearly not the right place to define it.  Two architectures
> put it in asm/memory.h:
> 
> arch/arm/include/asm/memory.h:#define virt_to_phys virt_to_phys
> arch/arm64/include/asm/memory.h:#define virt_to_phys virt_to_phys
> 
> then:
> 
> arch/m68k/include/asm/virtconvert.h:#define virt_to_phys virt_to_phys
> arch/sparc/include/asm/page_32.h:#define virt_to_phys           __pa
> arch/sparc/include/asm/page_64.h:#define virt_to_phys __pa

Oh, that's a lot...thank you for checking it. The simulator has its own
mm stubs, so it shouldn't be impacted by such a clean up, correct?

> This needs to be properly sorted out, but I don't want to tell
> Karolina that's now her job as a prerequisite for merging this
> patchset; that would be unfair.

Thanks. Also, I think I'm not be the best person to (efficiently) sort
this out :)


All the best,
Karolina

