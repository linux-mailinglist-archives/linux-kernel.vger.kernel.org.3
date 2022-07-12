Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6057134B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiGLHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiGLHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:42:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC679A5FF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:42:03 -0700 (PDT)
Received: from mail-yb1-f182.google.com ([209.85.219.182]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mgvev-1ncxB10d8H-00hKPm for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022
 09:42:02 +0200
Received: by mail-yb1-f182.google.com with SMTP id r3so12588059ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:42:01 -0700 (PDT)
X-Gm-Message-State: AJIora8iZxvhkIR1ZFYX6VF90OFvPgPMhQm8W5DPqBV1MHe9OeHWVX9w
        ELYOHojifr9qqRIUGunqQO8SY57Pav5Eus6eqIw=
X-Google-Smtp-Source: AGRyM1vw5q+1b1GFRz5TdwJexD5OkGYKo1jyCKFZ55Ecd8PU9RZv+1mTrgnzHmZBZTJwn/fZQT0SQnfYY9I214QpYrY=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr21102574ybc.480.1657611720991; Tue, 12
 Jul 2022 00:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220712071941epcas2p2faa87d8efe182e9c28a924ea3de15209@epcas2p2.samsung.com>
 <20220712074705.420399-1-youngmin.nam@samsung.com>
In-Reply-To: <20220712074705.420399-1-youngmin.nam@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jul 2022 09:41:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pCov7ZiNhG+by7PpxMdBbBpUa7TKNc9e0p-zXvqg-7g@mail.gmail.com>
Message-ID: <CAK8P3a0pCov7ZiNhG+by7PpxMdBbBpUa7TKNc9e0p-zXvqg-7g@mail.gmail.com>
Subject: Re: [PATCH] time: remove useless "const" keyword in
 ns_to_kernel_old_timeval() and ns_to_timespec64()
To:     Youngmin Nam <youngmin.nam@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        hajun.sung@samsung.com, hosung0.kim@samsung.com,
        d7271.choe@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IoT7n8aWCk6oJW2V3aekdA9kGcb8W3D9a7AIn/rbHGUyGCj6EyH
 fx0ewF0YKjeIQ2TPnCnGvBZCIVN1Rn0vqhHGp4Z7mU9eC/LPROJIwtGbnHnJ8cI9x3Qs1w4
 2vqF0mYPqJWaDsxc/5/PoBwqYXUi/eN0Mzy62k8aTGHzi3fnfNw7z2GVvPyCqS+inRGfcEv
 ipDvh5cHUzoJadx/+/tEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nb45jMIP9jo=:H9kUfO1xl/AS9ZcIi2pFXK
 rLLVvKth8S/V1OKoluep+5sBaWNyGimhLVBjzYFcrHYH4FilkMp8i/F53C+xPXJchWgCU7jwK
 DojfutaAP0IWbs45qDVosj0vtVrvJn8TNbgfavGUi09f1Ck20VVNAXZMq3TQt8YBZaI8Eou8E
 jP5gTSP+G0WcTSOJNCKToqZftNYybZXtY4CwneNBNlmqk/zecRV4BYJcsCXMlBoQKJKzN63kg
 WKzsnGmUt0ex8feuVAShmcMi1pvo+nNc64sX5F31FIbojW5qSlHqLwiMRdDKxCTzKdKmxnFaz
 UVPJiRxRgT0lmG+sBEhpPo+gbj/SquqeCNPSZ/93YI3u3x6hln138kFT9N2SSqROdEmzy7AW0
 0DyfjKs1nI0/YghwvPb3x7dvt2tQMZ0ywZwD4aRrkShjSB6xNkKOUMJjpTAaEgxEUMyQn3t8w
 pUOsUa5V8Y0BpxpeEALTD01pzUeskkukAih36uy84nNbOQBORDt/UAZ9Js2bOgO/ttzwPuXnh
 EkFoYng7nGyaRO4EaOQn0A/26BZpd37jZvfzBBgV6+XwtFbd8IxWbsTijEj5IOVas2Xv9C7QF
 k4pM0dSVjU46PXuz9aSjOfFCvzDELIfrnUpVs5HEHTGSNE46X3YOfiAGe04mG7guj/+jT39sQ
 MG3JCNgcaKckkI+zwya8O82pwfgUuH/rfsoRDvMNW5AkOPh/WkGSP+++2mNW6qXBrjVEoFJVq
 e7TRRMh4PgvVeCbiHAEbFnbSDAdG1LBkr/sq/w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 9:47 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
>
> As mentioned below,
> https://lore.kernel.org/lkml/CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5BbesdvMBgA@mail.gmail.com/
>
> The "const" keyword is useless, so we drop it from the function definition and declaration.
>
> Change-Id: If35bba78aa7757476e22be42afc719c27fb0f527
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>

The patch looks good, but the description can be improved:

- drop the useless Change-Id field
- move the URL into a 'Link: field'
- wrap the lines to fit into the normal width of an email (under 80 characters,
  ideally 70)
- explain why the change helps, rather than just stating the keyword is useless.
  In your description, it's not clear if one is better than the other, it sounds
  like it should make no difference.

With that done:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
