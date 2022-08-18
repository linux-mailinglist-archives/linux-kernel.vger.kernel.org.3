Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54B598CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbiHRT44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHRT4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:56:52 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01952D077B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:56:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d1so1999888qvs.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=x6C9oaqjzTmMIXnSanHNNBqmdNheWpmGgKycJO3HRsM=;
        b=gfAiGgfU47zX+cjYD7NiEzDLnPng/4RgoLNcE7yXZwuQsCkYh6DuL+H6yoGVCTHa2Q
         V/6mVSPdZCfxjUjJTx9DrLZ9Ys2L5yZ79mAjNMm9n8J0PQJHpQvlAGvAyj4Q2SBZxWFZ
         t26GDzke1tpBmCY4TdoEIVXiwp+jlSi/xdhFk20mwHR07fciMFVVM+R7NXLKKCF6U3aU
         OQJyWplK3dXf4JkkWtiG8+Ydaz8pAO/XpBfnXMcL4zPd8S1umrVwdIk6OhAeGDLEMkXx
         7Mg8oWg34Wf/FoY4/Opw7G8NmNG7CRPzYkas+2YD4f+ssZouEsGVRqif0gZc/7BAOzvK
         FRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=x6C9oaqjzTmMIXnSanHNNBqmdNheWpmGgKycJO3HRsM=;
        b=ihypMS3NUwG6ovCGK23uUojKdgUo4LlttLSwfHb7kxvurn2Dgkqg+PHfpAID8hc1Ga
         31Vq0v6xQDHS2j5InC8VEz4mILlPtngGx8/vWolD4blsphcz6yhY7domUzGhpA6DhsxX
         y7boSKvEkG6C/13s/BUKVZE0Y0yEtlzVLC9kWNbZJq7iqP1LZEO0PWzbYH1F1+qlEw18
         zOIJWOU0m4rYaIDTMa1qBflRimYzG4HaJnyVf+OJAIt4e9ZZekCfx0UPQg2/Tma0J0xo
         39GCeloh3moAFQIheOQ3hVCRYttLZtiMklcUivFwGxLcjcJgm9qY3o7T9PtCMpb2zL/D
         uBxw==
X-Gm-Message-State: ACgBeo3pKyY9rIJCgw0Pv1dNqPfL+dWtsNpWkdWUsm7qb7Whrc/7RoPN
        X8uyhuXL3VwAWrt3H6oKqV8I5Ax+EMOmzPuwNAb/jthROno6sg==
X-Google-Smtp-Source: AA6agR7RbJOL290Hi3wzTTDdbg3I8cd5NBL3HNzk9tEdeyVn7rbY2UKNuv2cT1h8Th+5tvNhCOhI6OCzCFxR3wEjYSs=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr3792263qvq.64.1660852611084; Thu, 18 Aug
 2022 12:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220817200335.911-1-kabel@kernel.org> <20220817200335.911-2-kabel@kernel.org>
 <CAHp75VecURpGCBY3WVKqhd64Ngobjvi-w=PuHQBH2V-MqCzkuw@mail.gmail.com> <20220818214828.22023dc7@thinkpad>
In-Reply-To: <20220818214828.22023dc7@thinkpad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 22:56:14 +0300
Message-ID: <CAHp75VfN1_0Wgop3Fx4DP2ECRTi9gUV87eUQhKgs4LfYGTzbpA@mail.gmail.com>
Subject: Re: [PATCH linux-phy v2 1/4] string.h: Add str_has_proper_prefix()
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        josef.schlehofer@nic.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:48 PM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
> On Thu, 18 Aug 2022 22:10:58 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Aug 17, 2022 at 11:06 PM Marek Beh=C3=BAn <kabel@kernel.org> wr=
ote:

...

> > Besides not the good naming (what 'proper' means),
>
> The naming comes from similar naming in math: proper subset is as
> subset that is not equal to the superset. See
> https://en.wikipedia.org/wiki/Substring :
>   "A proper prefix of a string is not equal to the string itself"

It's nice to learn something, but I still think that name has too
broad meaning(s) that may easily confuse the developers.

>
> > the entire function is not needed. You may simply call
> >
> >   str_has_prefix() && p[len] !=3D '\0';
> >
> > Correct?
>
> Do you mean that I should implement this function to simply return
>   str_has_prefix() && p[len] !=3D '\0'
> or that this function should not exist at all and I should do that in
> the code where I would have used the function?

The latter since this seems do not have users, except a single newcomer,

--=20
With Best Regards,
Andy Shevchenko
