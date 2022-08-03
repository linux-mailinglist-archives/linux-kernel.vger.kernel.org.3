Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E8358896B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiHCJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbiHCJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:28:56 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF25A141;
        Wed,  3 Aug 2022 02:28:55 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d80so139925iof.12;
        Wed, 03 Aug 2022 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dle9h48PzYrkYr1tEeCiB+iPlZLQESDR0z8su/KIJjw=;
        b=SjCPfeSZxmX/VGg4XUmntqZW/LhY+g7FpTih/fKj6p03FRSrdbF9ku60KR337JA6om
         zl3tihPq0ufDHx3sJW0AVs/52CNGFFETb/5YlNXtxX0CqJ0l5A0H0BZTteXSxyXtzd78
         JkCXnzlaBGTAU/KYQViDgBaDF0a13LnaeYtM5ZIIHeVZhYONkAFa0juUpiibWYAgGbw9
         QXhCndSY39zKkqgiTYe7WJUCwY1f7jAX0TnD8gi6IhC9H2J2nY4A1g4wpuKvIO4f3aIv
         PN7PJ8QdiWxpjwtVOtAZ7OPAi21Oi0iIdfXtslActBnJkXz0nZqk8ssoP/+4erCiE0Ko
         LF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dle9h48PzYrkYr1tEeCiB+iPlZLQESDR0z8su/KIJjw=;
        b=kNUP1EWBY/2j6z6jpzY5lps7hvcFQ3Xwpe1f4jb5BOZUP6BZs76DgeJOj0GMy3csz7
         XbzsIwVh06+FjWGG/5QiatxqogA23qg12jMcwSDloXgkh9KGmGib91hXWipb0AE0xkFX
         llC4DJ7BECNX+b58+7wBojuXD+q+NZHV/uwJBCUQWW+UEs3NQ8QbDsBFNO+i21vQ6N+N
         DobvLOSVWzzGtc/JdUKL+utiyu/oSgYjN8TFPC7g7KUO2ENpkTIMIGB3PXmZXNohaBHL
         hjwSfXLadgIh227uskzOJfQ4FGx202axdK6y6h58vE1THnbmoEMvVA0Y4l9+7TbPoVeW
         SKnw==
X-Gm-Message-State: ACgBeo3jSZNGDiKSP6BhtaIaaWJ1+OROMd1jpHXGkbERWTIY//PNcMTs
        +YGQMvNl3gEsvqThBCucwA5Gp3VxaNKg4ygEuJM=
X-Google-Smtp-Source: AA6agR7jqNitVhgGQyxl1ogBL3e5zRTPtT4aJap1SIZpVFW4uU+kJY7eDxHzwAHUWrA0U4TG29EoiIGseMbk8uTHpus=
X-Received: by 2002:a6b:e511:0:b0:67f:9ef6:5779 with SMTP id
 y17-20020a6be511000000b0067f9ef65779mr4860634ioc.177.1659518934836; Wed, 03
 Aug 2022 02:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220802233844.2613013-1-broonie@kernel.org>
In-Reply-To: <20220802233844.2613013-1-broonie@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Aug 2022 11:28:43 +0200
Message-ID: <CANiq72nbMchMo5a1sQtBRF_rdBX8pdmHhVjft=-o_9-ZEpT2TQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kbuild tree
To:     broonie@kernel.org
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Wed, Aug 3, 2022 at 1:38 AM <broonie@kernel.org> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good to me! Thanks!

Cheers,
Miguel
