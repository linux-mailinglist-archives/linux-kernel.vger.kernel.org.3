Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6857A3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiGSPz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiGSPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:55:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A831CD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:55:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d8so2342869wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0gPBEwvkwP9AzAvrwoXC4f0AhgzYIbN/zElv9y8340=;
        b=bT+XcNi2mYPVIubJjqbv+OWMnppG9RF2NZECGSytk9rHKM/p2Fs2Z8ohaKiX1hdm4n
         t8EkuR8wjuE/Y/Jvs5jQLO1DPT0jdvPRadiIWre+yusfP65o2h99XpREUm1HRTkEsBMB
         ow0/UGBXWSTBRevc4mZ4F5FWlZiaos0xyzWl0b8SVow0OFuQmfpX2WErvS5jWTF7/VfI
         86XSsy3j6Y1UzHXXIPRr2snfBKGY5j/a9wHEaYtvxBlyoalTrOAjQZCk0XUp/yM6Tn44
         5rdW4/CNxxooaSW87kFGCuxeFXCWiqOdLdLIsqLvhrr724RR2CtQeltJvAc4ZM5SSL6F
         rVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0gPBEwvkwP9AzAvrwoXC4f0AhgzYIbN/zElv9y8340=;
        b=fFppR/DIaw3IZ+A9d0to6cWViHRh/qIKt2b5jdTwlGjNPPIXKyY7SqEelzLPOAQQq/
         Km/xFkwJ87X6pIo93YaNa6F9xowA/81N2KIa9rWAJHxyULDUO846Hm5M+43vjuSW1AY8
         AheUuNp50wVx1SdjLNJEfKmq1hxkViKHP5jPRKu30YNTHjBi+2oH9TXW0YKWPp0iTQ0J
         Mloq87J+Xw6W6GJbUm3OWRkxPP4TxLxNEQFLO6w/9cPsx24tXJmBL9HFLStapYnWXPvI
         Ik0BTlYOuZ9s2IuO7QxxpScDT4frNZCA/Ci0r+f13+C7lTwhcvRLHbQNHckw7NQUG/YA
         z9sQ==
X-Gm-Message-State: AJIora9Z5OjEcfj8H8AL5ZGCTAQl1q1J+3BDtlg2YAXlfL9zBZBj4lFW
        BSIVuAUIh3MH4d9rPjYqfqnHUrP5Ettqj8VXoFbFHw==
X-Google-Smtp-Source: AGRyM1vYL297rf/f1P2yZpbi5pivzUlIYTkIb5FxW4ONjjZ+gPGhTyCIVsXJ7VkziTz6//lCC5sDBn8rsUFKesZLG1w=
X-Received: by 2002:a5d:4d92:0:b0:21d:6f02:d971 with SMTP id
 b18-20020a5d4d92000000b0021d6f02d971mr26598782wru.300.1658246119804; Tue, 19
 Jul 2022 08:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <YtQLDvQrBhJNl3n5@kernel.org> <28992751-7de9-7900-ae78-be1a5d30c3c0@redhat.com>
 <YtbDeMAdspQg5EA2@kernel.org>
In-Reply-To: <YtbDeMAdspQg5EA2@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 08:55:07 -0700
Message-ID: <CAP-5=fVngjnNXPokakt8qRKC+mbiq4myR2pBTbs2K3wxXTbGNg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel sources
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 7:45 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 19, 2022 at 03:15:58PM +0200, Paolo Bonzini escreveu:
> > On 7/17/22 15:13, Arnaldo Carvalho de Melo wrote:
> > > tldr; Just FYI, I'm carrying this on the perf tools tree.
> >
> > Thanks, I'll add a sync patch myself to the KVM tree.  Do you have a script
> > to do that?
>
> we have tools/perf/check-headers.sh that flags differences, then to
> address it I copy and send a message, yeah, some scripting here would
> help some.

In the past I've copied things over and there have been complaints
that the commit history isn't copied over. If we script this could we
also scrape the commit messages?

Thanks,
Ian
