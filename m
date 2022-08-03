Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10F958862C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiHCELH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHCELE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:11:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59D5FF7;
        Tue,  2 Aug 2022 21:11:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id tl27so11422568ejc.1;
        Tue, 02 Aug 2022 21:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBcWLfOi59Zr0OA6U2ZttJvd4WsA8un2MakZZH/LgV0=;
        b=D6kV0fC3rK/LOD5m0hcWijn1wlfGGcZssoqodkcTn+/Cm0HOeSQ4TfcZ1qjI0He4+Z
         ZexOIfLUrcDA0spFK3yGySsBVibEV++GmmBTY8WEdFt52uNemXA+mxP7srG48R9TGX2T
         0DeXhTkxTzUM4WG5IrLgNaK7oNAS7/95/uj+VOXGeP06ioEb9dK2gtDrAx5P1lwHEJz4
         A0HorGO9TB0SMac2TPz3RSVKmGJkCBY/02IVX/TSXeV9A3eCpFtuXS5IIpPUi5LArKH+
         nhXWlhiM7K+vBGdFzg3cc1DpmXwts8Z95jLd87uu2XYwKUMXVMUvIDnUAHiz8VtAPksP
         gcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBcWLfOi59Zr0OA6U2ZttJvd4WsA8un2MakZZH/LgV0=;
        b=GgkbuSJy+l7kO8PQ5KokpnUl2zptObCpWD5rYrNjOQE0DXS4mz8Q3NY2FfVbHcs8LT
         g99Bzi+5+C1EX+JRaB+Rqy/D+3XpyoYZ4eIKQD/f+eVxARfXUDAE7WV0HiVkv2Pqc4NK
         T0FzGEEb+9HRuULldmJka1tA9WjRckWvvonotlsvbq+S48oKW6ObZ/R+9xwyhXcve3T0
         bZvfXnZD+H5iYK691hjRIFn+Qvy86Llz6Y8kwpNnTpeI+Vf0HXND0Ix1COm0rygAga3a
         VaOuQpWJd0D7cvDdxR/amWktpjSaAXwOcdp7XhEyKyz/XvrkPVZHHWK6FUaZS4fPtVxF
         Uu/A==
X-Gm-Message-State: AJIora8nPI0vIlAw1W6xBKB063GxuMQiLR/Aq4yDLVsE/bfOQFbe6GqU
        NmXSucuFGB0THHLzmETTOyroSFXDMyR/nqPY/dE=
X-Google-Smtp-Source: AGRyM1soNFypQaJtvjgXMvAEI6HJEv2aCgoO8EqtElH6QUrSikaWdCRfoInwTfCYEKKwn0F52DRoiLdyScRVZ84K0XQ=
X-Received: by 2002:a17:906:2ed7:b0:72f:d080:411 with SMTP id
 s23-20020a1709062ed700b0072fd0800411mr18505734eji.203.1659499861920; Tue, 02
 Aug 2022 21:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220728155121.12145-1-code@siddh.me> <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me>
 <Yuepw21SyLbWt9F+@kroah.com> <182597c78f6.70a93066293735.4741894763116073008@siddh.me>
 <182597eccd3.14cac6a4293987.1730526835854998440@siddh.me> <20220801161642.GA1932489@berlinger>
 <1825abd83c7.2fc2819e194605.6286442523651645797@siddh.me>
In-Reply-To: <1825abd83c7.2fc2819e194605.6286442523651645797@siddh.me>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Tue, 2 Aug 2022 21:10:50 -0700
Message-ID: <CANX2M5aK5HED2R=VyXGw9osEn3MoX=sRjH9x2i8WvGcM8VFhrg@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing watch_queue
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>,
        Marius Fleischer <fleischermarius@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 11:49 AM Siddh Raman Pant <code@siddh.me> wrote:
>
> On Mon, 01 Aug 2022 21:46:42 +0530  Dipanjan Das <mail.dipanjan.das@gmail.com> wrote:
> > Are you referring to the reproducer attached to our original report?
> > https://lore.kernel.org/all/CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com/
>
> Yes, I meant the reproducer you gave.
>
> I suspect I must have missed CONFIG_WATCH_QUEUE=y while setting the kernel
> up, extremely sorry for it.
>
> I now tried 5.10.y with it (using a modification of syzkaller's dashboard
> config I had been using[1]), and I'm getting a __post_watch_notification()
> crash (which is a related crash, as the fix[2][3] for that causes the
> reproducer to not reproduce the post_one_notification crash on mainline),
> but not the post_one_notification() crash you had reported. It seems if I
> apply my patch, it doesn't trigger this related crash, so these bugs are
> seem to be very related maybe due to racing? I haven't looked at that yet.
>
> I then tried on v5.10.131 since that was the exact version you had
> reproduced on, and it reproduces the post_one_notification() error
> successfully. Applying 353f7988dd84 causes __post_watch_notification()
> crash, and then applying this v3 patch does not trigger the issue, but
> the patch to fix __post_watch_notification() crash is [2], which does
> not really address the issue of post_one_notification() crash which
> is due to the dangling reference to a freed pipe.
>
> Can you please try reproducer at your end?

We can confirm that the repro triggers the `post_watch_notification`
crash on 5.10.134 (7a62a4b6212a7f04251fdaf8b049c47aec59c54a). After
applying your v3 patch, the repro did not trigger the bug.

>
> [1] https://gist.github.com/siddhpant/06c7d64ca83273f0fd6604e4677f7c0d
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e64ab2dbd882933b65cd82ff6235d705ad65dbb6
> [3] https://lore.kernel.org/linux-mm/18259769e5e.52eb2082293078.3991591702430862151@siddh.me/



-- 
Thanks and Regards,

Dipanjan
