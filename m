Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A194B507C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353414AbiBNMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:44:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBNMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:44:25 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9AD4AE25;
        Mon, 14 Feb 2022 04:44:17 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id n5so12187805ilk.12;
        Mon, 14 Feb 2022 04:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdSVOhXvPflvsh6Jc0LXMR2FThi2beB719bBXF7UQpg=;
        b=IVbEf0st+pMoHzt5k6frRYpNKaZp+57tz/hbu0enuiNNoJw5mNi00EBoMHz9DVwT6Q
         GxYouE7wzfyu4kh3nOz+NdXpyC7PRJjUpywCDnHtr22gA2FAznDP8hh4yLkoMOYCs9Cd
         hJ/9PFmPm9Y5ck9kZTyuENHeqJMsJccrAM0YQ0Ry+HeigYvwH30ypp0CFqNpVVeO8bQg
         RZLS67kiMFyicu0SxMGNCQSZJqL2OMOR7sj8fVcDndUJiatvZGTfzP9hxz3zef+q38OW
         gLRY1+iTIZUA0e2luZg/JMR0aZcJg7Q+JJhHU3b8NCbBtJRs51luwQVTpuQeMeIYFEPy
         Inmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdSVOhXvPflvsh6Jc0LXMR2FThi2beB719bBXF7UQpg=;
        b=c+Etdjecy5IjqKEDGNqvm/718dWTPw+v1v3uznjID1gb8CGOZj2d/2QgBIzoKgXUFZ
         nD5rzZHXKT5ytHQhfh0cytgmtXakhF7NmQ/FQHQJs4pdUNRSKlc0JHpUPswRgyJsiJyp
         YL5c2zhrodCj2oG6//JBQEljlBdXykCijaOPoV5rI/6Ce8QjFlrZbksjDRjFpxb8R2IB
         9hmCaqiT5JYrxga3r8eC41DrKxDvMOSWbTh2g5E46QZ+R4lAZoDTFQuuqqTrkVO7q8bE
         wJiybupKievkuYoI/jNSDc5cMSzdXwa2OfrdFtECH3mc8PNJW93BP+VBCFBfWy/ARN+0
         jf2Q==
X-Gm-Message-State: AOAM530zuZhPZ/lIuhewY+EiyADRhEE7TCtm3OOnEZ5wlmCq6Z+bHO4k
        0NYkDnUMRaw4i3ppbCpFap80SRAoQ6J5GNMlQG4=
X-Google-Smtp-Source: ABdhPJxnxCpvFqcAkK1eb4qN90HrjGF7tGDYDWp/VQDGl0lHHe3UOhC6H/tACygYgV3u7p/NbqVgxS7j4QHSwdz1aHI=
X-Received: by 2002:a05:6e02:1ba2:: with SMTP id n2mr8253361ili.5.1644842657184;
 Mon, 14 Feb 2022 04:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-16-ojeda@kernel.org> <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
In-Reply-To: <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Feb 2022 13:44:06 +0100
Message-ID: <CANiq72kYLEbw7s9_V8aUC0YDYtb979z2y-UgmOhFyCkgpz4cuA@mail.gmail.com>
Subject: Re: [PATCH v4 15/20] docs: add Rust documentation
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Wu XiangCheng <bobwxc@email.cn>, Daniel Xu <dxu@dxuuu.xyz>,
        Gary Guo <gary@garyguo.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Finn Behrens <me@kloenk.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>
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

Hi Akira,

On Mon, Feb 14, 2022 at 11:47 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> Please find inline comments WRT ReST-in-kereneldoc.

Thanks a lot for the detailed review & references. I will apply the suggestions.

Cheers,
Miguel
