Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF5526A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383899AbiEMTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383889AbiEMTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:40:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF53F881
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:40:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v4so11418075ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQ6m56IkNfx6TOZa4NyOX1e/UvXRK2PyXxRKo48NDaE=;
        b=lDbFjGKKBhM8Gt+fUkFJKo8DdEovRML0GVwMO6M4CIG7Z75+nYbMyZizZlmJ0lnRUP
         RzwMg6mMX9zlOVwm5aWWup+CIC6WdtUBrDkupJXkIyUWjZ3QQEiqNsWqxwqpOl5Olpt9
         4O9oRII0kbYsbKQULaH3yC3akKRKOqWhw+8hclgX6s10S4gPZq7+Rhux7JFOqGcJaffg
         AGTNHhU3n6JMeGUq6oXFUxuhwaa76C98QMnmY5Fbhf3SI9kIWng/+iMLz7DzqtvT5S9b
         AltxK9/vrTOIYtD4dhfSWF2hQc9tSl1VGRozl0EsqQsXAEcRzFWHRwDeFybxJtIFo4O2
         DGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQ6m56IkNfx6TOZa4NyOX1e/UvXRK2PyXxRKo48NDaE=;
        b=vPXHJONwrGBt2AdTA7gFGep7wTEJvV2qe+Mtaell+OtQXfOrONT2SZduMWACmqeEZ+
         Cudh8QdesskkEvghdiFH5dMIg07tVn6/KGENwg6xtFmiEDR0F2m+VPMG2Dww7o/t7GSO
         hAXQpMNh/pgGMzRalTCf74/n6RlyXqD3AS7arGMv1o+WMQ/kQk1UZHNwujtVOjADD7E5
         kYwduTifSPOewYMHbmgchML3scKAVBHgWYeBRQCNropi4ixc7raIGb3C4YLDpcJ+ARLM
         5JyHLayLiNswFg2RSnQdDfUvdKo7eve9unozmFOM3U2aHZotsBvwmK3lffUWss82igVf
         BqdA==
X-Gm-Message-State: AOAM532NmzMbaF83Hi0f+Zq3cWDuu4D4qoygRT2b6MelBJ+ZZeeR0zvC
        nN8Qug9c2oANsuxAOVDROSj725OoQaqTiD7kBfxG5A==
X-Google-Smtp-Source: ABdhPJzyP8gSUBuzQhXkYjjcm6QVX0cIYBMoPrTrbUmdjkIySE8ac4yxDfnc1IsHuZhajCV6mainxrW6qQKLzixG4EQ=
X-Received: by 2002:a2e:aa8e:0:b0:251:f929:3e7d with SMTP id
 bj14-20020a2eaa8e000000b00251f9293e7dmr3860576ljb.352.1652470807106; Fri, 13
 May 2022 12:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220510065336.hlfjrc25ajed5zj4@M910t> <CAKwvOd=OnJ=ZhsbX+epzbhg3sWg9yOaR=zQ4jF_Deo=B8Nx9Og@mail.gmail.com>
 <10BD31AB-C9F3-45FD-9A4A-EF7DC07C94D5@sifive.com> <20220512083007.gdvlaq7ar2tyarza@M910t>
 <CA+wH296d8p06E6LU4HUxcGZEf6ZkcUS_oEUY4k_zcC-Y6+-1+Q@mail.gmail.com>
 <CAL5JJjHYLTskw6YdC9qMj4KUAeY+0rO88Gh-TRaZyxCGJe+dnw@mail.gmail.com> <20220513034629.l662gw4mn6bi4zen@M910t>
In-Reply-To: <20220513034629.l662gw4mn6bi4zen@M910t>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 May 2022 12:39:55 -0700
Message-ID: <CAKwvOdnbRnEpxyGu2N0g_AqRRD_YT7rtYTNuknSeCuoSHwKjog@mail.gmail.com>
Subject: Re: riscv: llvm-compiler: calling convention violation: temporary
 register $t2 is used to pass the ninth function parameter
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Craig Topper <craig.topper@sifive.com>,
        Alex Bradbury <asb@asbradbury.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Rostedt <rostedt@goodmis.org>, hw.huiwang@huawei.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 8:46 PM Changbin Du <changbin.du@huawei.com> wrote:
>
> On Thu, May 12, 2022 at 07:49:41AM -0700, Craig Topper wrote:
> > Changbin, can you provide a pre-processed source and a command line? I can
> > reduce it on the llvm side.
> >
>
> hmm, clang can not build the preprocessed source by itself!

Sorry, I should have provided more info.

In order to get the preprocessed source, you generally can do:

$ ARCH=riscv make LLVM=1 -j$(nproc) defconfig lib/string.i

replace the final command line parameter with the path to the source
file you care about.

Then, to get the command line invocation, you can do:

$ ARCH=riscv make LLVM=1 -j$(nproc) lib/string.o V=1

Then you can provide the output of those two commands.
-- 
Thanks,
~Nick Desaulniers
