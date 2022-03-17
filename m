Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC224DC005
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiCQHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiCQHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:12:57 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D5316A698;
        Thu, 17 Mar 2022 00:11:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j29so3137412ila.4;
        Thu, 17 Mar 2022 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsH1jTwGh70nbMJVP8wAJmLqUSHhmR9shuFU76M+9Dc=;
        b=EBzB740TKu1d1Imn3mpaSB1EfZ2FjXarBVL0Npr4JVxuTydJxK6GaorJm5cvoHan50
         vid57wYTSwXyO/dPQEoc3X4KoEUoPrrxfj+fIagyseVtSHFazHuJcsVS4DC0u8l/7CZ7
         QpUcDmZaqTc0eu0rXYtIrRTDKW44Nsl+7U6kTOHKQlI0d3A2is47q9H5Lm6YKIwokwif
         bu5m2qhNTXEzDk07DaC1a0TwpqdPkxzIEfeffk19Si+088MSC3fURJLeLeA4KvopIpj4
         ldGfVVm7o0WDdtHqG0wYQtxjEPI/yExWJky43z4PltQEh9PsZNwU4h6GrjWNCbxOrvyA
         Tr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsH1jTwGh70nbMJVP8wAJmLqUSHhmR9shuFU76M+9Dc=;
        b=23wqmmZBHZS3Xr6HJtueq+9C7Eunj8Bk3XKhNCvTIb6B4tWojy+KWMXa0+GkqPfEVb
         S4HESCiHBC/ZC/L3EweouG7SxkG7iVck9yxd9g5AymhcJKs+ktzmLPDXDFKc8yBn1P18
         ikR7MSkSUs0+1FpqRMEKib3d2CIOxVF7Zd6t0B0osPWVciJ61cdUeYmYTas7v/WmcGcz
         QWwVy8wDD8bWpMq/1bOVNln8rseuPszFAR1D2zvwgTvmk0uTB0FYfR6dM+HtKvB8IRta
         8EaIBFjKBHzW8CAOOdSl2LOKe7Jjs/C7R3FdPd5z3mVolUuwoDHlM1LAtLWBhDMkfB0E
         0xPw==
X-Gm-Message-State: AOAM5304TBP6wF/qwQVS0k2gsOlAjrvxuIOtXO0Q+pGIo2GmjX9cxCI1
        /xEsfT2XBPHEExa1L/Wc8hHaCpiw3C2isClH1ZI=
X-Google-Smtp-Source: ABdhPJylbMRWa83N8Qi1rEHyJaDatdhRujBdMy27TMS6aUMu0aXeRV6F+XT1QD0fGBvkRtFEXxUAEinfYkWcWu6zA1g=
X-Received: by 2002:a05:6e02:1846:b0:2c7:b032:5d92 with SMTP id
 b6-20020a056e02184600b002c7b0325d92mr1331857ilv.237.1647501100639; Thu, 17
 Mar 2022 00:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220317170254.0f6e3bac@canb.auug.org.au>
In-Reply-To: <20220317170254.0f6e3bac@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 17 Mar 2022 08:11:29 +0100
Message-ID: <CANiq72=Ww3Qb4RfAHfognp8F2PbCRyA-3asqB-6f2R76uBLiXg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
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

Hi Stephen,

On Thu, Mar 17, 2022 at 7:03 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This

Looks good to me -- thanks!

Cheers,
Miguel
