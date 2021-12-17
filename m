Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743844784AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 06:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhLQFuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 00:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhLQFuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 00:50:24 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 21:50:24 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id d10so3502799ybn.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 21:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbxYFuhXciRdXFUcsp1Eus+7OgrQ8HqeVPRIesPErvo=;
        b=CicHRuYsu9gQulT86tmfz9IDPjUyCOGgQ61C6jEChS1p35Ve3SiBo15EEzdpWSqG3y
         AQ17V2JgwbunVjVOx5nHRUlnjGwg4L1BEvZqzjEBtFagQk/zaPaYd/qYef/a/DWzA/X3
         3iPE4HKUtAcZlz705NyfyBPEZ22Mob+bXXxdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbxYFuhXciRdXFUcsp1Eus+7OgrQ8HqeVPRIesPErvo=;
        b=I1swlRYt2/AO11W1lDqSq8JXnwyAfNZL85j6+wd00E3O8Uz2+LjJdL9qbUY5aef5Bf
         aGJv7WaX95MMKES39juaur6qDHK1RqwUZSnPD2EOvIILR/iUDTXogoDnl84HkzG7KNI2
         8oTt2cFE+ZInmN9A2pXbsO6kyvbRfA1gRCyGtMDvTLju/0dt3vH5fo566A0wOvACId6s
         2LpHdvcfSMy3ffh417L5qeTNW61ZbWtDa1BuZ6iSCWAeTIygwDT0w6mRE54N/cygP3YY
         Azn3yLLFmuHHU1f8CtZLcKEjK2/6CGs/Xs+26qA3rp5M1PlJo9JbuPTtsKNei3YKYF4O
         yzlw==
X-Gm-Message-State: AOAM533nE5F4ZeabqEUpKSdEbhyw2aUFdtZVVr/EIZHlqBkurnHUCldc
        5SuUosdRyUIF23hkB7lhzkwJ4TRtGeTmpIKkfX2B
X-Google-Smtp-Source: ABdhPJySH+njHDMdSsHjZNNEk79KBchC3iVUT1MckIXEbQ7YXVj2esVyGamHDnSMMU0LlK81DUevSaIQmJ6P0mJOzjI=
X-Received: by 2002:a05:6902:568:: with SMTP id a8mr2423433ybt.472.1639720223901;
 Thu, 16 Dec 2021 21:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20211129075451.418122-1-anup.patel@wdc.com> <20211129075451.418122-4-anup.patel@wdc.com>
In-Reply-To: <20211129075451.418122-4-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 16 Dec 2021 21:50:13 -0800
Message-ID: <CAOnJCU+MvAj79Pyjg+pimPkcWTVbq9kwSaoUAXSCV9Y1odD+5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] KVM: selftests: Add EXTRA_CFLAGS in top-level Makefile
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:10 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> We add EXTRA_CFLAGS to the common CFLAGS of top-level Makefile
> which will allow users to pass additional compile-time flags such
> as "-static".
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index c4e34717826a..ee6740e9ecdb 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -131,7 +131,7 @@ endif
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>         -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>         -I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> -       -I$(<D) -Iinclude/$(UNAME_M) -I..
> +       -I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS)
>
>  no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>          $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
> --
> 2.25.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--
Regards,
Atish

-- 
Regards,
Atish
