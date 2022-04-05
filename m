Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B64F3657
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345975AbiDELBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiDEIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:39:54 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF25B87;
        Tue,  5 Apr 2022 01:33:36 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r2so14271902iod.9;
        Tue, 05 Apr 2022 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mylkO58ZKq1iBj80uJdfaHLKrfd/MmPSeOlKdlAN2g0=;
        b=iBAh71Mhiz3dylNCqZo+yDdLJKHX7Ups2H7UShUJq9aLEVD+v/UN+esg2OInSOp5eR
         qvwe656xyvQiVAOv2OVxK5ZZSjQkfewL3pNXUdN70ByDSmVqmu0Zx3vT7wfK1MP0/MVt
         HISlGvX/tlI0uOfIlc4Ma/qL76vQv2D0ceU5GVbmucnU65zfj/NtDmfkm4mFZtmcOw7O
         W5Qheo8WSoFs5cJ75vHsokH98+9pTpwERAc2S5c0RQs50gBe2zf6ZHKwRRHPUgkeOr7C
         NT4QV/TckpGkTeuxPaWu964ZgslgqYRXix0btKt7SxTt2WoZWgSqtC6jVDcZtqMwS99u
         5iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mylkO58ZKq1iBj80uJdfaHLKrfd/MmPSeOlKdlAN2g0=;
        b=wFNy8fIYr79iTI/nb17r/AgAA3WR9idrtNSPWrGpqOy0gGxnQGmwxbuIe8pfRx8+DO
         GwI5XElXHinVvzARs+u3drQ/V2AbMO10CzymwPI313mUwi+QW8ZjAP3NoV0auy38DilL
         Fxowg1z+PWKaSDOUSB33wCOpsEPrZg5Gx891RXoPoAfzZmmY4lckz8kapx7B13Ciyo0x
         uaM89+hgi/gaqq8pGawu1oXPt4RrJYKhNgl3mI4mD4IZ+EZYDVCK2KIGHjcULu+y7GUG
         Wq5JWQ1KaGWcsAr52FF8YVfkT/jzduR0LBvjnNRl2XTs9bZCTeuzWT8tM8butIyglVr8
         LbCA==
X-Gm-Message-State: AOAM533QjB/5kQo/hqRvJr8KsTaZgEC4nUsawCpU+q4JbWULOGUKgjpN
        PeG0YYkckQTZ2BAJN44LiBOxxQ3Vn5tuRA2DHeM=
X-Google-Smtp-Source: ABdhPJz31mODfRf19/XwGfqFgcDFZs9wfyNoZm+PEmbmm8OtKipv6FNIiNgPJ1ZoLDVD0q2ZrQeH9IKSUdZPNp+Wevg=
X-Received: by 2002:a05:6602:1341:b0:637:d4dc:6f85 with SMTP id
 i1-20020a056602134100b00637d4dc6f85mr1069163iov.155.1649147616151; Tue, 05
 Apr 2022 01:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220405131412.381b8a97@canb.auug.org.au>
In-Reply-To: <20220405131412.381b8a97@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 5 Apr 2022 10:33:25 +0200
Message-ID: <CANiq72kvTE2u=9ahNhSbnchfxT9_xrD8JBTJYbw=oe8j8zCbig@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Chun-Tse Shao <ctshao@google.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Tue, Apr 5, 2022 at 5:14 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This

Looks fine, thanks Stephen!

I will likely rebase again for -rc2 like for -rc1 (done to avoid a
build error on our side and a conflict on yours).

Cheers,
Miguel
