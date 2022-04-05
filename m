Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6C94F491C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390564AbiDEWD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349688AbiDEJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:50:57 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E18C63F8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:48:58 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id a5so9616543qvx.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcJDSJ2fdfUt88zDb7E40OVyeszW9qc0BswUs9f37cs=;
        b=W6ZXireIlFMS3LpHRniynZ9Sg9E/XQdFnIGmierel1/FjvRGsPxrzkW4tjuAoSa/RR
         dnXDxi0BD1ZHurB3LOLtPHevxxlUCPEPxChN8FZAgFlreffigTjKTdVDYdMUY2zry+/k
         riWWQEVQrKLX7flUNI2VHH6E7RxHpzVqDo7oyAnxyKEwX22fIzo7WBlEm2wV9ft1SjLl
         ZGAPtVE/UuuT3TYKkQdP51XCudV0QulNiZFPgpXH32spdsBigJhnlem9k/zfXCEX5oJj
         CDZ9mzF6fGMsB77rrXT4+Yrxhqc86cbP8SsX9Jzhwkl/4t76+WfELQoDs4QCRjs/EJUW
         LUpg==
X-Gm-Message-State: AOAM533eLMYlW40zfAL97Qsu5xbnLe/vfbvPIZTG7qy9PQf6BQ4Qxs8r
        visHZom4G3zkvX9LCFl+IugPtXhNvbWigg==
X-Google-Smtp-Source: ABdhPJy27BWa9Nez6BaVr/mjg/+z9MPdza3ysEZFsr3pPcrjJ3SJxCsJ5O76GCzeZyVOv7TeLE/eDg==
X-Received: by 2002:a05:6214:1d08:b0:443:d51c:69e with SMTP id e8-20020a0562141d0800b00443d51c069emr1975255qvd.97.1649152136615;
        Tue, 05 Apr 2022 02:48:56 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id q204-20020a3743d5000000b0067ece232979sm7742026qka.116.2022.04.05.02.48.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 02:48:56 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2e5e31c34bfso128982627b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:48:56 -0700 (PDT)
X-Received: by 2002:a81:1e13:0:b0:2eb:4c52:f8c9 with SMTP id
 e19-20020a811e13000000b002eb4c52f8c9mr1855606ywe.256.1649152135781; Tue, 05
 Apr 2022 02:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190617144725.6415-1-geert+renesas@glider.be> <20190617160011.GB3927@kernel.org>
In-Reply-To: <20190617160011.GB3927@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Apr 2022 11:48:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWPDMhz9YdEs-=iCLa6w--iS-Ug9SMUa=UG0bW2mMYyxA@mail.gmail.com>
Message-ID: <CAMuHMdWPDMhz9YdEs-=iCLa6w--iS-Ug9SMUa=UG0bW2mMYyxA@mail.gmail.com>
Subject: Re: [PATCH] perf: Add missing newline at end of file
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>,
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

On Mon, Jun 17, 2019 at 6:00 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Mon, Jun 17, 2019 at 04:47:25PM +0200, Geert Uytterhoeven escreveu:
> > "git diff" says:
> >
> >     \ No newline at end of file
> >
> > after modifying the files.
>
> Auto generated files, IIRC, Andi, Kan, Sukadev?

The auto-generated files have been updated, the issue still exists.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
