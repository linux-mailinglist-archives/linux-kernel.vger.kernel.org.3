Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B0947342E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbhLMSiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhLMSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:38:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC2BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:38:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so55041641edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+1fNpX93mnR718Y3ef5IctkzW2zgU6vi7fxWoUpSU8=;
        b=cksPQmGJ58gs4qQ1hs6rwiQWOiN3SNBrgroxr+rlu9ivw697v2jF2x1N7N8ZIV4Jb3
         mjEc2TL8CyMc9vFhja2BJ5pP4RuFZieLdZyPzAhs+oW0HRxLgedrk0QoInYOlu669WpO
         CCANEq5nPBSyn6AD/iJoEQGbJbC5tOR6pxjMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+1fNpX93mnR718Y3ef5IctkzW2zgU6vi7fxWoUpSU8=;
        b=MeYZ6Wq8cbUPTYlBEeh9NpjMmq/oYl9pZ7+aBrzQi14sAlCE9O6F7dSXY+w7pSdo1Z
         QkodA6MLmfgrkdsngvrmEkrQ4mrL7k2zX9WQFOAN4rwjLXnBaL+gXtCW+8qbcoRa4fV5
         BuQAwZeNlLWlHqvRLxTjiaJS9g9NMKeSAisR15Fmgi+aBNfPyOirePFAh5MrxCKzG1EE
         SD7HOEjDAvIcn4QsJs4qge6mfCx7tQYq1uQcdsyXn50lsIqMkw53WygDeOeuOUZnhoir
         SVTiVviQVLueep+dE4BliD112SDOcpbrLq8hqoVDDraKGCBQl8MLD7CtDve683H9Qp5m
         hALA==
X-Gm-Message-State: AOAM532VSvmj0CHZOaCvlfrI8sD2hyj1JjaecIAg3fCfEf6wODh+iGtq
        o43vQQeMTdZAesYWTo+rfppiDw9km/1sgBfo
X-Google-Smtp-Source: ABdhPJyPXEv0CrwfaagqwyQetLccI93ZHMPVKxXgLNh+0wT8503kaAJfB2sr7YowGykeXxh+vuD4RQ==
X-Received: by 2002:a50:a6ca:: with SMTP id f10mr621857edc.81.1639420686733;
        Mon, 13 Dec 2021 10:38:06 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id s12sm415616ejm.147.2021.12.13.10.38.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:38:05 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id t18so28582901wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:38:05 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr250902wru.97.1639420685627;
 Mon, 13 Dec 2021 10:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020> <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
 <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
 <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com>
 <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com> <20211213083154.GA20853@linux.intel.com>
In-Reply-To: <20211213083154.GA20853@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Dec 2021 10:37:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsTk2jym66RYkK9kuq8zOXTd2bWPiOq43-iCF6Qy-xQQ@mail.gmail.com>
Message-ID: <CAHk-=wjsTk2jym66RYkK9kuq8zOXTd2bWPiOq43-iCF6Qy-xQQ@mail.gmail.com>
Subject: Re: [LKP] Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     Carel Si <beibei.si@intel.com>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:34 AM Carel Si <beibei.si@intel.com> wrote:
>
> We tested your patch, the performance regression has recovered from -5.7% to
> -0.4%, thanks.

Thanks for testing.

That probably means that the cost was literally mostly the overhead of
function call/exit, and now that it's simple enough for gcc to inline,
it went back to being equivalent to the old leaf-function overhead.

I also suspect that it means that the benchmark is likely not great (I
didn't look at details - I assume it's literally a microbenchmark just
doing a very tight poll() loop in multiple threads), but hey, that's
not all that uncommon.

And I do think the resulting code after this patch is better (in
organization, in comments, and obviously in code generation), so maybe
the benchmark isn't great, maybe this case doesn't matter all that
much in reality, but the end result is better for it.

So I'll just apply the patch. Thanks for the report and the testing
(including testing the one-liner that didn't help).

           Linus
