Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95CA501EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347530AbiDNXJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347505AbiDNXI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:08:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C0C4E06;
        Thu, 14 Apr 2022 16:06:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s18so12803568ejr.0;
        Thu, 14 Apr 2022 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWv6HfHgguUI/DkyUK/M7ub8F2Hnwf3DDEuvQm5kh6I=;
        b=jVw4GOcH3RcqMdY546tIfnHKAzKSFVrfdcuyiuXhRJIGn3nRu3J2PWpR+iHQpxNCTY
         jQ+0GaJtldFjCISeshgIIbBqo4oIUDlIb2qyJuoM95LzxDapZG3cPvzVonUy6xEh/i/W
         HT3l3O5uRTjYEK74yI6QMkszUHbK7FxncW1YiS4MXVD82YEfd+o7h7CYbke3vwYkAEXp
         8iCVEpE2NEUhRNGFRzsTDyxZikHEbFp3EcSb61jiQ+HnVFLDMMMVA5lV5M88Ym/c/Y2Q
         jTJREQhCH+nOyy+EB2bqJ7wdOuEGmLUZAr809Jwb1ijz5rROe9L/UeH3noCgbUKxb6+f
         O3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWv6HfHgguUI/DkyUK/M7ub8F2Hnwf3DDEuvQm5kh6I=;
        b=tEwyhzj2bkkFoFkgq4EjhdvP/2tYY59HtNS9ZNDe/Gv5XCKLCOQfSNU5c11EXg3lnb
         vRMm8Q3PaIKxeR8HbhtGiyhM/OBdzloHd102Wl0LvagS7GIDX+6TL+fdVdSrQHs87U5s
         +tEBhXA2QnJ6MVwTSz306mJXCWGVBJVC0CKjWeiUezBEOSZCJd9icMHy/NatexvV73w7
         AWQEeuwg5aLEXXRujvU7zK47y/6P6DkvCHFQU/dLAQ2MS6Qn+TpMHl3UEeo23P/uw/U2
         XMlFeWGlTWVdnwsa55wwAFA2VcKaEe69m7h6zxoiK2KXqAiNrPMgP6Y6RUfj31lDU6jh
         LzhQ==
X-Gm-Message-State: AOAM533gwFmk7g0fvWNEryemFWh7vQVxtt5oL83wXgJpVMjlqS87hv68
        uwNYSMYGX2aOVRRR2Z0RfzgtooLtyoM5U2nbT6FXIDPEGLptPQ==
X-Google-Smtp-Source: ABdhPJzFYecPFk5iqrvSN42xj2qiqfmHlA6CP+95l1Euk0rl59I2XblLMR2RCz1MPbEqv0sdHhhEn4ZtX1SD4NDGOuI=
X-Received: by 2002:a17:907:c05:b0:6db:f118:8834 with SMTP id
 ga5-20020a1709070c0500b006dbf1188834mr4220431ejc.536.1649977589007; Thu, 14
 Apr 2022 16:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 14 Apr 2022 16:06:17 -0700
Message-ID: <CAEdQ38EpBMnkP-PNZnwaoO4poFJQO5YSFJeZgiQ-obJmjogBFQ@mail.gmail.com>
Subject: Re: [PATCH] Alpha: Remove redundant local asm header redirections
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 12:01 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> Remove a number of asm headers locally redirected to the respective
> generic or generated versions.
>
> For asm-offsets.h all that is needed is a Kbuild entry for the generic
> version, and for div64.h, irq_regs.h and kdebug.h nothing is needed as
> in their absence they will be redirected automatically according to
> include/asm-generic/Kbuild.
>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Hi,
>
>  Noticed while fiddling with Kbuild for PARPORT_PC.  Please apply.
>
>   Maciej


Sorry for the delay. I'll apply this. I just haven't had much time for
alphas lately.

Maybe now's a good time to remind you that I'm still waiting on you to
upstream the m41t80/SWARM/i2c/smbus patches? It's been more than 11
years now, so it seems long enough for a ping :)
