Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB100557ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiFWPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiFWPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:46:16 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5B393FE;
        Thu, 23 Jun 2022 08:46:12 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25NFjdPb021143;
        Fri, 24 Jun 2022 00:45:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25NFjdPb021143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655999140;
        bh=j/xESgTYpvfBYOpf/MQrncNNB876CiujNKiv36ApBsU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kG9zvmHK+8+0XQmcXc01OEe4w90ZSPiHDOk+1zF8zvewXbuvkPkMjBvGOks9b8rp9
         Qfn9sNBYUHgUkVKSsu+bHOl8lxzZ+Vsqe/KA5QPWY/q8yEjovEx5BiubuatjPjFfPr
         dVIU2VKDEPSllH3K1RtB+FGMbaWrZMRX6SpDFZwEIQfbi22/PC+cp/ZS7O+2fLVvi9
         8354B+KnQtvtV2ExeuogWgOEtR54XTIUuxgmHWMp8bPDbyqdgrRwoXBScfMdlCvd+t
         T8i+9eNUpL8oxI9gLW0FaaESPvqRwpiM/JwCqBbye6tVqWzWhZ+AXfO+hDCEMfi4vB
         ZFLPfZ4P3Gavw==
X-Nifty-SrcIP: [209.85.221.44]
Received: by mail-wr1-f44.google.com with SMTP id v14so28548940wra.5;
        Thu, 23 Jun 2022 08:45:39 -0700 (PDT)
X-Gm-Message-State: AJIora9RSoHW3j8kTWV6zU+hW852qRTAGupOu7PCEUsOufOD/+txTV9b
        JQPysbT6KYoqu2l3zAM4d/tbkuXLgyDgWV6Ahs4=
X-Google-Smtp-Source: AGRyM1vLtYcBsNb2y8tCxGLb/KkzQNtIx/yx2J45Hrac4bCV7fR3CpMfMyMVDrpAcCoBSFscDVRbsO6fqf/3iFZ/WlU=
X-Received: by 2002:adf:f5ce:0:b0:21b:832c:80dd with SMTP id
 k14-20020adff5ce000000b0021b832c80ddmr8828918wrp.235.1655999137985; Thu, 23
 Jun 2022 08:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220621133526.29662-1-mikoxyzzz@gmail.com> <CAKwvOd=Bmu40+_11GOBTeJBjToUf0LNG_RX0RiLcRLimUUkgcw@mail.gmail.com>
 <CAK7LNAT3FrpLnhSgfTo5bxk-9cHm6g1ti58wSY6W-fxMx+mUrA@mail.gmail.com> <2817735.mvXUDI8C0e@sakura.myxoz.lan>
In-Reply-To: <2817735.mvXUDI8C0e@sakura.myxoz.lan>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Jun 2022 00:44:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqJc74MGFyU6fvhM9VkDKYUXyCt0NF1qAr1RmfUqC0=w@mail.gmail.com>
Message-ID: <CAK7LNAQqJc74MGFyU6fvhM9VkDKYUXyCt0NF1qAr1RmfUqC0=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 12:42 AM Miko Larsson <mikoxyzzz@gmail.com> wrote:
>
> On Wednesday, 22 June 2022 03:57:34 CEST Masahiro Yamada wrote:
> > If you want to say "use this option carefully",
> > EXPERT might be another option.
> >
> >     depends on ARC || EXPERT
> >
>
> Yeah, this would be a fair compromise, though I think it would be
> better to use "visible if" instead of "depends on". I can get a v2 of
> the series together if this is desired.


Why is "visible if" better than "depends on"?



> --
> ~miko
>
>


--
Best Regards
Masahiro Yamada
