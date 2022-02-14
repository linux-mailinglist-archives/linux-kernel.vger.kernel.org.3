Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF8C4B5C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiBNVC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:02:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBNVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:02:53 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C0FB18A5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:02:44 -0800 (PST)
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MpD39-1o4YKc2XHj-00qiib for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022
 20:13:29 +0100
Received: by mail-wm1-f46.google.com with SMTP id i19so8759314wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:13:29 -0800 (PST)
X-Gm-Message-State: AOAM531Fmh+lmrrhR9lzWUPcnsoU9mOCFQfwhYEbYT1Z59tFDjHstobM
        LEYJuS4Q9SgK42RA1KiY9WFbXLvTL/7lc+FmcXU=
X-Google-Smtp-Source: ABdhPJyJlY94tBVkGpgY9F9Fep611CS7TPV4PO1eAfR5mWbxDC/4GiIdtTlhmZnlrcELAnMXaJ51at1SiHDsXIIGmao=
X-Received: by 2002:a05:600c:2108:b0:34e:870:966e with SMTP id
 u8-20020a05600c210800b0034e0870966emr84692wml.173.1644866009298; Mon, 14 Feb
 2022 11:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20220207184652.1218447-1-michael@walle.cc> <YgpkCyoSMg5RYfkO@google.com>
 <YgpkQMbhWAJG6oCh@google.com> <CAK8P3a0UWO=h6K4NpzCVC2vbOvThJH28GM5ddm9U1crr1Su7vQ@mail.gmail.com>
 <YgqE/OvNDco5wEY3@google.com>
In-Reply-To: <YgqE/OvNDco5wEY3@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 14 Feb 2022 20:13:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1aqcsD-fGBgAmsi0qf9Td_y3Ry+o32Z1fU8H3qmEn0GA@mail.gmail.com>
Message-ID: <CAK8P3a1aqcsD-fGBgAmsi0qf9Td_y3Ry+o32Z1fU8H3qmEn0GA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the sl28cpld
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ng+3bxaAbzBc0Zs4kN+g7FnCrLfcLMjKqnfFATWcrzLxvMre9JE
 7E4ViqVNNT9AVrx0OQwVYEjIoKt8ffZiFAIV3V9gvLD+McWqPiVgh92gXJEF8sewnYAgVar
 PwC3j/8xPY7Y7Lueu0erkkbdHSuz9vQAXNJHk5YYTMOgLXhsRbRmXnKGFdughffGe5q9gM6
 OAknnDeqabR8/kxYurxFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K5Oyuej6exs=:5FF5EtVQ5c+Tc/ZcT8TVh6
 KJ3GzdE2ZHS9oZ7h4nc9Ua/8Z7chA7wpcUQ2aMV6TiI4jZbQUtyeQM2Nu790a62A/f+BmnBUH
 Wc4yMDk+EYkGPT2Jqx8YHGBhDHWPWWpGKxBnsexHAQLgCBq7ZeMaVnZft3kSsgw8W0n4TCKFb
 xSeRgcU7AVxPFiDmbGPRALVOjgRQbB3E9JtZMOoR53PeJArhGlXPIwpq63PRmgW3IOfYfNhlw
 ZMT1cwYqJEp1UU5qp3UKqUZKsefEtZGZMHSVDLd2SshAEDAgYpqwK1RpZb95EvlyBIWFHgGN3
 qTM9yvyaGH5xHjUUV0xDf/Y57KTUxWCVj6KTZ9bubjmb0rLw3qYDr3D4N/0ieXldPzJ29BAD/
 KvVtICwsJMdDgxsGqMZDDx8Qh7qiDQLgwTUdzBFjpKEtCNdAxLcMdF33ozdKGRGcHsovwSR9v
 75urjBhekDNJXJ6WIaao3+OAT1U1WodPlEhZzzXgCgZlxCrS2N/4MAaBvVJSNkVKc+rC4J0sj
 JKbus9YNVRzKFFjDnBp4WbEsucp0QKra3QdrF8w8Vlqse3CiKt3dQmPHGfGwqO2m/FzcJ+DCi
 vez/asswHspuR6FLuzFj1KArJ3SmV8Sd5pqVG5ggmSCKEyaVOkcfy8r3qwjXrsxKrrzEHD54K
 fqCBzkGvoqFmN3/YbXl36Qhw88fTv2ZNpomqsMj2InAUqnBLH8aExZqy38zib50dnfMU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 5:36 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 14 Feb 2022, Arnd Bergmann wrote:
> > On Mon, Feb 14, 2022 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > Hold on, you're not going to get many Acks if you don't send it to the
> > > other subsystem maintainers. :)
> >
> > I've already applied this one through the soc tree.
>
> You did?  I missed the acceptance email.

I see now that the automated mails only get sent the submitter and
the list that is owned by patchwork. I completely missed how this
was sent to multiple maintainers and just grabbed it from patchwork
along with some other maintainer changes I picked up.

> It would have been nice to give the other maintainers a chance to look
> at it first, but I guess it's not a big deal in the great scheme.

Right, I need to find a better process to look at the actual emails
when going through patchwork. Sorry about that.

         Arnd
