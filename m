Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9580857C4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiGUG5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiGUG5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:57:44 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3842579698;
        Wed, 20 Jul 2022 23:57:44 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i206so1300781ybc.5;
        Wed, 20 Jul 2022 23:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jg5xOF91IhH6UhEHXcn/aeKc4aPmRft3G2hr/M5lf6g=;
        b=NBSldHK6FpMdAlxxUuLg21qM7MvYGPsblpeRtCPMU9ocE2OsSga27Eix0B9nMOxzQA
         vQQ792uyBIT5uVcKz8E/a1pAPCLH/o+3EVU+hvUZxAiFNqslo935U5Uxajdw1CeNdWev
         hscq56Bbflsrr19qnh2M4jlec1csEWIhpkQOCXhRBWAN/xItnehLfJsSOzeimm+93a+S
         ru0lQfQKoVrPXnarS6jLwTbVNvVOBkw+4aSXT6jcyLx866Em73FnLvzb6p4bj0TKxCLd
         jnyxXl26Y0RY+nROWQGw12QV/c2+We4Ou+zHUt6+x9pNPUvU1Peu1T0esCMPDf94BoQr
         LOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jg5xOF91IhH6UhEHXcn/aeKc4aPmRft3G2hr/M5lf6g=;
        b=bP6D/lLHr66ZV85E8jnaYLMujjP0AFxhnvycwcyCAxzptBgxWWZbHkXAj5QFnM2OSr
         Vax2YHn4ekogQRi2Wys259w71EdtCUofY9yuokGPCaF2vSDOuqkQ5g0tjlVk6HPgfL4J
         qMzbPyrJSUZVSToFp9t1Buzrkus9H3XtWhyT2e11p91AQLLjdy8x7D7IfdV2riMVNv13
         xrYHLLjQunSYIOHLIyUaRDoHAp//jBLZLwDnKqeU3BPrYnRYGyE3Ocqs9KrJSOWZPKXK
         0OFcAB7Oq84aJDUxNKKtZU87gQMQxoVGNTzwtiMtHJARkPOu7+5Oemh8GBFN4lb7edMB
         RLaw==
X-Gm-Message-State: AJIora+8kTVuFFyag6Eq5QO0wfepNS2JqQVr+fJOFnL3ktsL2rcymfld
        J2HPSrEX9modiNvArJVd3SMpGyIKZ6CSCS99o+4d3zOj
X-Google-Smtp-Source: AGRyM1vzwThamKsUX82SkFlbBKzaTixjuFa4gle7e+nxdUkGlWKzyrl4wTNu03WjVDKbNuUyk22PYuFIPxEcPByJUTk=
X-Received: by 2002:a05:6902:1504:b0:670:b7ad:ab0e with SMTP id
 q4-20020a056902150400b00670b7adab0emr1169590ybu.77.1658386663328; Wed, 20 Jul
 2022 23:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220720223603.58acc431@canb.auug.org.au> <CAK8P3a0mK4CHcHUX2XX2rGH29FM4suWiOUpCpR7M2Tg5kn6VpA@mail.gmail.com>
In-Reply-To: <CAK8P3a0mK4CHcHUX2XX2rGH29FM4suWiOUpCpR7M2Tg5kn6VpA@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 21 Jul 2022 08:57:32 +0200
Message-ID: <CAKXUXMw0hpzY+pGH2S45UZYK5BYsUmqndGwPcs5TLuN61rBoVw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the asm-generic tree
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Wed, Jul 20, 2022 at 2:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 20, 2022 at 2:36 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the asm-generic tree, today's linux-next build (arm64
> > defconfig) failed like this:
> >
> > drivers/char/mem.c: In function 'page_is_allowed':
> > drivers/char/mem.c:66:16: error: implicit declaration of function 'devmem_is_allowed'; did you mean 'page_is_allowed'? [-Werror=implicit-function-declaration]
> >    66 |         return devmem_is_allowed(pfn);
> >       |                ^~~~~~~~~~~~~~~~~
> >       |                page_is_allowed
> > cc1: some warnings being treated as errors
> >
> > Caused by commit
> >
> >   cdfde8f61a00 ("asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED")
> >
> > arm64 does not have a separate declaration of devmem_is_allowed() and
> > was using the asm-generic one by accident ... some other architectures
> > may be in the same boat.
> >
> > I have reverted that commit for today.
>
> My mistake. I was already aware that the patch was broken, and Lukas said he
> wanted to send an updated version. Unfortunately I picked up the old version
> of my asm-generic-fixes branch as I applied a different patch. I've reworked
> the branch to take this one out again now.
>

Stephen, thanks for testing and already the first quick analysis on
the issue. I will try to get an updated version in place and then we
can see which architectures beyond arm64 really need more care.


Lukas
