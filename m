Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE2950AB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442254AbiDUV7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDUV7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:59:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579A4D27D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:56:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z99so8196550ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2XnpBOwTDdjnVA+25Nh56cl0azTcJsJDuS10iR7LTc=;
        b=C4S3R9quYIAIUDMHwwKrVcSNKDQy/sv5rRXpMlQl5RbY0E6QCEpJJslLkmjuhZaAhy
         MSMKHKSuf9ocQqSSQIHa2TXWFKOr3GZsp0jsMvlUHKBNUoENlr+MfnW9fWQJjtpaQswu
         BvBzah3BjlbBsTa9DlggZC/CzseNvWqWXRWXPItaAi67V6OqN9DuiCVfzGm63cR6f3Uo
         DKZnpaVsA6/FbxqZsYxc0qZDUxvK66K37vUU0Oul6qCZKrEqwR78CHZWvJjpLhLmmBMY
         6rkaE84XTfRzu+0ONujt4PsR5Es3nLyMPVkCCPRiCy+dDRwAcQYp6lkalo/DThefYCqE
         Ry1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2XnpBOwTDdjnVA+25Nh56cl0azTcJsJDuS10iR7LTc=;
        b=cFdJJw8Cq8lj1xQ4nVceYI5nGoXcky6KsA2qzRXnaXRFQKcbUWs7WUaL7HC5ipDQB5
         TbZViCxrmhBZyqQKBdIY7TtziW6gvtQtM2DoVeNYhtfSo3dbRMQoR2OFPSCEzsK9SfZD
         txyUMjHH6mhtAm7hIB8zq2MCMHXHCZYS1/ITj1FnvC5N+myUpvBLE4anxZmdUBZOa1bk
         ha1Mc+0VaW0tyJjeuIXdZYIRJ2sr+RtxLTK1vDOfkCtenOk+X6nIHJcF2v7HLBasQ/vv
         Lm/MvVjrDA8JojhdI+kuZG4JyNn4ZK1brQ5OseXdSkFetuOJC4OLxlWvV+FDAh49Ub8s
         8z6w==
X-Gm-Message-State: AOAM531b//9FvOAaov9lLYypI+8x+6TJkUPqhnFIoAXjUS2IRX3EuA77
        dkGyxq0jvlqzc7FmjRd4FrDX7QqmujGTXtE1zror+Q==
X-Google-Smtp-Source: ABdhPJyVlCrDZZJwxaQZkTgcqpx6uvDXQzPAyz56fmdnocfKZWMqx+j2dPO18ZFNTaOiEQNbpcGIzLIYnQKG5YtYBJE=
X-Received: by 2002:a05:6402:11cd:b0:424:ba:877f with SMTP id
 j13-20020a05640211cd00b0042400ba877fmr1700976edw.292.1650578210823; Thu, 21
 Apr 2022 14:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220422075024.161914a8@canb.auug.org.au>
In-Reply-To: <20220422075024.161914a8@canb.auug.org.au>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Thu, 21 Apr 2022 14:56:40 -0700
Message-ID: <CAHBxVyEM4gO2KMP-+cGHLSvriYDuF+TO2JoETh-x1X+bRwuOfA@mail.gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the kvm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 2:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   38d9a4ac65f2 ("RISC-V: KVM: Restrict the extensions that can be disabled")
>
> Fixes tag
>
>   Fixes: 92ad82002c39 ("RISC-V: KVM: Implement
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> In commit
>
>   3ab75a793e49 ("RISC-V: KVM: Remove 's' & 'u' as valid ISA extension")
>
> Fixes tag
>
>   Fixes: a33c72faf2d7 ("RISC-V: KVM: Implement VCPU create, init and
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more than one line.
>
Sorry for that.
This probably happened while copying the fixes tag from mail to the
actual patch.
Let me know if I should resend the patches with correctly formatted fixes tag.


> --
> Cheers,
> Stephen Rothwell
