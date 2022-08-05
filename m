Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8158AA91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbiHEMMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHEMMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:12:39 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD12D1D0DE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:12:37 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id x1-20020a056830278100b00636774b0e54so1796000otu.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VrVuJuhrSZE+9DmS5M6DpJAhDp1BcvxZgTQm+rO0ARg=;
        b=YbZ2Y78Rhf7+LSn7fDJEM5mcxwVzCDJb5lhY5JWU+HbqP1AhzX5aeRcrr4zPyLXAkU
         Fk850q3fMMmUXfGJJlFA6UTuSZUE9AVMUtS49UVeFoiaq5F4Igzc16xEW8INwClzyYw3
         3gLytTV6qvmLqc9NQPUy7qQ74lhFQDPca+KcTERr+mQuYw6YivHuEjTbqoG7t2a/WTHu
         0f4GAlhYMIwErVQvW0TITlsKiAO80f1V5KIl8SRzJPUNM06pO+19iOsfALk4Uc68sHom
         yLc7l3+vHv+CSehz7VjZxMUxYuxyBfJAr9O1s0TpfgYo8xcj3GJCACAAJvyslHdDKdTl
         uKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VrVuJuhrSZE+9DmS5M6DpJAhDp1BcvxZgTQm+rO0ARg=;
        b=nR9ZMNJA4j1QAMXOtdpyNj+JthsOqybz7xOey9wvuVSz/aEuqso+oCANsX0Zvy6LDM
         oPwkC4dCvQc0t35jKCC90hw4ogCTpDCPQBFx+qEZ6SVGJX5tXFkR9PmSOosfyABIdILM
         jr5T8W4dms3hi1p4LdTFWDMachHFzPvAzwNQ/1ZZ49pbyRQiIaeMusF+Kv7jGYSU8KVf
         ChxxbMKo/DkGUwD++hVRCQYUGldp0YnFs4pEz6DmhrwGygKBfZ5zAIEn8RBWWZ4yNTlu
         DgLjziWtNMtVJUrZ3FyvXD2Ow4LXo5QQ9llJWnPaNOPr1qDtiQYTw2ekNYZFB2moqNdo
         ZvKw==
X-Gm-Message-State: ACgBeo28tUEcIIN6poeHdx+JnMvU7AqDDA4/i4LkTC9K33hkXDd9qJ5y
        L9NeHlVzbehc1QImnPrwYsbcnbGm2tDmhMyA1kE=
X-Google-Smtp-Source: AA6agR7kklYXTJ+Ss410QTU7DK05grNnqNjwUjZLQ89wKHHhQYawiYoF1jCuNesJJpuLN/K8T/i+oYo2xa6l1brViCw=
X-Received: by 2002:a9d:ef3:0:b0:636:bc6d:4916 with SMTP id
 106-20020a9d0ef3000000b00636bc6d4916mr191665otj.341.1659701556849; Fri, 05
 Aug 2022 05:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210623120127.327154589@linutronix.de> <20210623121452.214903673@linutronix.de>
 <CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com>
 <4812abd6-626c-67e4-7314-be282cd25a4a@intel.com> <CANaxB-w1+zCupiS5HyofGhVD7TKqZCoRjv9VZiegROiPkMY3NA@mail.gmail.com>
 <291808ee-d5ab-a7b2-33e2-62a449e90cbf@intel.com> <37ba2de3-26b3-12eb-6a9d-c0f0572b832c@intel.com>
In-Reply-To: <37ba2de3-26b3-12eb-6a9d-c0f0572b832c@intel.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 5 Aug 2022 05:12:23 -0700
Message-ID: <CANaxB-wFSTO+CCv2wCZb3JXwo1j8okiR2qAOMYcOiL8mn6WaTw@mail.gmail.com>
Subject: Re: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 4:32 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> On 7/25/2022 2:26 PM, Dave Hansen wrote:
> >
> > Do you happen to have a quick reproducer for this, or at least the
> > contents of the buffer that you are trying to restore?
>
> While not following this report, I think there is a regression along
> with the changes:
>
> As looking into the spec, this state load does not depend on XSTATE_BV:
>
>       RFBM := XCR0 AND EDX:EAX;
>       COMPMASK := XCOMP_BV field from XSAVE header;
>
>       IF COMPMASK[63] = 0
>           THEN
>           ...
>           IF RFBM[1] = 1 OR RFBM[2] = 1
>               THEN load MXCSR from legacy region of XSAVE area;
>           FI;
>           ...
>       ELSE
>       ...
>
> But our upstream code does reference XSTATE_BV instead of RFBM [1,2].
>
> My test case [3] fails with the upstream but works with 5.13, which is
> before the series. Then, this change looks to make it work at least for it:

gVisor test passes with this change too. Chang, are you going to send a patch?

Thanks,
Andrei
