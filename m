Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6140253FAA8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbiFGJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbiFGJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:59:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F90813EF;
        Tue,  7 Jun 2022 02:59:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so34042256ejj.10;
        Tue, 07 Jun 2022 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxVWtgk2MYK7tyuypm6e6PUQAcCHSHou/3ZRAHbOVpk=;
        b=VQY1loPqU6cmtCq5MRX6W0SUd2IIzjij1i4LvyyQHZO9sypUIWSaN58u3MkyhwOTCw
         x04dCTwmvWZ5sJrbeYH36tuBLTiVpYOS1BEQAGxdfYkBNPpDQrLGHuq9wndgRgO15Api
         DVoLIFic1x1/0akX/jkXeWT1Uzh2pcSjZfQtjf+7s17UJ/mHk56WZhLxgmDWmdQw8n9k
         nefJSFxgYYuAUCSkY1beh4DoEyZuGCIUkeWclLr6i6E1mCaqFp3j/TPmzc1fiY1HEVwn
         donSUzVAekTmUAK+j2Bl9IUjuUu8pZRALvbUGPDeTxi4Al+80RngkUjmtNK27mvCLuFI
         sa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxVWtgk2MYK7tyuypm6e6PUQAcCHSHou/3ZRAHbOVpk=;
        b=hFOhhff8ynkWiSgkjD+2lwjRvC2Hx53Lob0RyP2VcXqCHVY/kNkRRHvX2s9USj4B1N
         sOCL3lCDGvgUyqnjcqwJYLfdKOpmPG0e9Wi2UpXPz09rWtTXWkO/fyYIjQaWbWlx5O2z
         oP6DDtee6L21L3/n+DPehKZsUdIXJ4/Ls64+YrsJ0d+gB8XEXudYp29WaLbXXWrr8l1u
         kYEMhaPHGlnV5XVqhCTblcl1CCo65Y/qhkXZA5YQYh6b/N3gJxCfMr4ulhEqurY9Apu8
         JxTguH7yP+Wg48kKb/q6Etnet8raQ+G40TveYPrAC7Nr2qWH8PaNvIajuUvdLPI3xBLM
         0H7A==
X-Gm-Message-State: AOAM5328HeDSUNwVJtiuGk5NYf5r7AZXlr1QpqGZXjgrcjt6ManKILWg
        JFjFQcacpKB3t+KEqoLqQgm+n2b9gg/7kk1KzmItl+UBefl5FQ==
X-Google-Smtp-Source: ABdhPJw9TTzAR820+KlxuAowdaRO/HTzzE8b4ylykIraDj7jVSMwXYdCf34or+khV/0U9tR3CzPcrTVrwlbkh1m5+ws=
X-Received: by 2002:a17:907:2ce3:b0:6ff:1447:d3a4 with SMTP id
 hz3-20020a1709072ce300b006ff1447d3a4mr26847700ejc.497.1654595972614; Tue, 07
 Jun 2022 02:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220602083128.22540-1-jslaby@suse.cz> <20220602083128.22540-2-jslaby@suse.cz>
 <CAHp75VfsR6sVwO9iF6RA0bhVjMF1jC1_JEkv106TubPgL_m8YA@mail.gmail.com> <4d4549ef-f8f8-d0cb-6d27-e6200aa14048@kernel.org>
In-Reply-To: <4d4549ef-f8f8-d0cb-6d27-e6200aa14048@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Jun 2022 11:58:56 +0200
Message-ID: <CAHp75Vd4H2AOcDV-cWug+MCup5RY0udTZX2uq3rzP+czy0uiJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty/vt: Makefile, add --unicode for loadkeys invocation
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jun 7, 2022 at 7:42 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 06. 06. 22, 16:35, Andy Shevchenko wrote:
> > On Thu, Jun 2, 2022 at 12:30 PM Jiri Slaby <jslaby@suse.cz> wrote:
> >>
> >> For a long time, we generate unicode tables using loadkeys. So fix
> >> Makefile to use that flag too.
> >
> > generated
>
> We still do, but I didn't even know there is even a rule for that ;).

I understand, but here is English stylistics like this. You need to
use past ind. or present perfect ("for a long time" dictates that).

-- 
With Best Regards,
Andy Shevchenko
