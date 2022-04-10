Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22144FAD16
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiDJJsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiDJJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 05:48:36 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67AD2AE27
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 02:46:25 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id e22so11034106qvf.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 02:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oq7wc2A3KeI5ACESVg++iWu6Z4DsIQaLdq/BQi3IsLI=;
        b=l0vMMu/D1wkuqi13cVDCWQRz4QrWDvqVuaJodbhZ6g6mIIXp8wlzLzllRZpRVsfl36
         C4LobcssN8/Wa48qxD2cOm0UXT1EQbKoZdAMVjbmHM9tnmUhPf+NIdc/ZfN0N0R8oYtQ
         lAOo4acgzzcSrEpiGYa8/7DA25+jo+hH6jqymSgyL17Al0tY3iKL3nda0AUA0AHqvi4K
         Zx+aXZ7mskTBSJf4sUbhDD7Drf7EZoXvYiVUYlzFPXwt5iAkNpMmvSzsVcjY1HU+5P4X
         JV7q+BndouNn1UpJhwu6xLIP4LmlGR09NXyx59eLzVqIBWujJISFa7cfqKrASp3/j/DL
         9j1A==
X-Gm-Message-State: AOAM532DYMk2MQpV1/xYQjyMeW9WnbItbEibkKD4TzuQ1inAMzpC1O0b
        6iGWB7oh85ADdQLZyQ5po6aUKe76+9TZfg==
X-Google-Smtp-Source: ABdhPJwbdnEteFKB3xsqPsF15gmloD3fPUuLHp33+eAnNawna3eVY0CYvAMyP8+ghtgktTAWCLcDfg==
X-Received: by 2002:a05:6214:2628:b0:444:1721:bde5 with SMTP id gv8-20020a056214262800b004441721bde5mr12197192qvb.127.1649583984083;
        Sun, 10 Apr 2022 02:46:24 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm23021816qtb.28.2022.04.10.02.46.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 02:46:23 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2eba37104a2so137576797b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 02:46:23 -0700 (PDT)
X-Received: by 2002:a0d:e743:0:b0:2eb:3106:9b32 with SMTP id
 q64-20020a0de743000000b002eb31069b32mr22781269ywe.512.1649583983145; Sun, 10
 Apr 2022 02:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617144725.6415-1-geert+renesas@glider.be>
 <20190617160011.GB3927@kernel.org> <CAMuHMdWPDMhz9YdEs-=iCLa6w--iS-Ug9SMUa=UG0bW2mMYyxA@mail.gmail.com>
 <CO1PR11MB4803640A785DF199D0496017E8E49@CO1PR11MB4803.namprd11.prod.outlook.com>
 <70411972-e31a-27a1-acbf-26f5ab471a6a@linux.intel.com>
In-Reply-To: <70411972-e31a-27a1-acbf-26f5ab471a6a@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 10 Apr 2022 11:46:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV8ROcNZ1o+uEa9s-VnZp2NZET7SFcX_+-K1RJa-UBCmQ@mail.gmail.com>
Message-ID: <CAMuHMdV8ROcNZ1o+uEa9s-VnZp2NZET7SFcX_+-K1RJa-UBCmQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Add missing newline at end of file
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhengjun,

On Fri, Apr 8, 2022 at 4:45 PM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
> On 4/5/2022 9:59 PM, Liang, Kan wrote:
> >> On Mon, Jun 17, 2019 at 6:00 PM Arnaldo Carvalho de Melo
> >> <arnaldo.melo@gmail.com> wrote:
> >>> Em Mon, Jun 17, 2019 at 04:47:25PM +0200, Geert Uytterhoeven escreveu:
> >>>> "git diff" says:
> >>>>
> >>>>      \ No newline at end of file
> >>>>
> >>>> after modifying the files.
> >>> Auto generated files, IIRC, Andi, Kan, Sukadev?
> >> The auto-generated files have been updated, the issue still exists.
> >>
> > It seems like a converter tool issue.
> >
> > + Zhengjun
> >
> > Zhengjun, could you please take a look?
> >
> > Thanks,
> > Kan
> It only happened for perf core event files. Add "\n" at the end of the
> perf core event file, then the issue is fixed.
> I have updated the event convert tool
> https://github.com/intel/event-converter-for-linux-perf , then the next
> time uses the convert tool to generate perf events, the issue will be
> disappeared.

Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
