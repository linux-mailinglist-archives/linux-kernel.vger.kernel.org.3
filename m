Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E32B4D646E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbiCKPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348478AbiCKPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:22:19 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDF1C65F0;
        Fri, 11 Mar 2022 07:21:15 -0800 (PST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mi27T-1o6AhM3yJV-00e2Dy; Fri, 11 Mar 2022 16:21:13 +0100
Received: by mail-wr1-f54.google.com with SMTP id k24so13443212wrd.7;
        Fri, 11 Mar 2022 07:21:13 -0800 (PST)
X-Gm-Message-State: AOAM532GJjCowykab+q4BsEgG7bbxyxR/h5bHYpfn8nFJFEY40g54ZRX
        mSNPNbfGNsk9Gi3eAo5Wmnc8H27N9LEsFWJfcW8=
X-Google-Smtp-Source: ABdhPJw9NDhuSTGQU9QfnpOildSbNkuwrW+GWGrbcDHOVBryRnm6vvVP6Bnb4fn03D/5c33g2QQrdz9i4OUDvElO/JI=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr4897403wrq.192.1647012073552; Fri, 11
 Mar 2022 07:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20220311150122.23010-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220311150122.23010-1-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 11 Mar 2022 16:20:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1qAHQ=Qv+5Ke2t5oPnrf1mQ9akog3uN-B=KYcaWxtd=g@mail.gmail.com>
Message-ID: <CAK8P3a1qAHQ=Qv+5Ke2t5oPnrf1mQ9akog3uN-B=KYcaWxtd=g@mail.gmail.com>
Subject: Re: [PATCH] clocksource: remove left-over from removing the
 timer-atcpit100 driver
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alan Kao <alankao@andestech.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:iujwSflD2FqnNKKSFtXnpTmd3ExGypDaXJohWnBlujIZ0yDek+x
 eIXRWlDbIEnxB1M02T4cPPAngX+tkL9SPrDeZc4EssOndsnMFfct8Wpo/aSkxAHQbBjmyeG
 jkJy+54ZA8rw1I8VT4Pr16379I4BunuanaJWTshGJR8DUBRxzpuWAsJTmqmVGMgJCPvK4po
 cgi0+WSVg/W9jbeqI3/FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o1pIy9amqnc=:nY1dezg9Z5AWrIHEYAiTHI
 5P4IDpl6galEWXfrhndlWeGJLBNZ4kDHbomxKy8E675g9gaQH+C+qDi9CuJhL6/Ewe0DeFtQn
 l/TPyVCfOlIadmzrIwwvRLqjn7lPW9d9awzU4G0ICAwhogtLSFKnafBRQxcaPUZunFyZxy36J
 CQw+GUdoa5br3wG82+ierZABF6bBWRII+8V3xHP0neJjvWrS4Kxsw8qy1Vk4ia1rqcF6Ushuv
 iV6ugBeeJbZNoHcCNa5iP2BdNsJBn1FBUv6hGFEm/iNrF/IalXtYTFJQBU5WCNzEbfHslwVgt
 IZxfYczCvhjHfsEGoUD0OCw+0pUQ+wanCOvaIjrg3J5NQiUk+wpPd1AUHTagD22kZifMWQZ6i
 YOnFI3Zxq1zVsSzVpLNdfY1LHbaPZCNUHtdTl09Cak5AibTjim5dH3jF6zk4z3bqS7yMIPtHc
 JECA51M8OtU8JLpoANOS9eFz6Fn3SnEloZoYm2pmSPAB2KZXrMOgMjZhXOI5Cr9QUxYK+ePx+
 JEoY9TmOQD8Kw1uOz9dVwbqIKEsMETJrVozBtbqJOsiJUTu7GK+prahRmQD+5uj8yF9SVYp0e
 lAFOwGyX+mq+SUaAGLhmHZp18qvA4tfs1nq12cP0WQxgrdjMoOEQAQvZeT3WwX4c5JVvpYzlv
 jvdfrDvIOHZs3/O1q1P09e0KFp6S6v4vss8buyh2UTJT6BA5K6rX6U1XCQT3xbfOJHsY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 4:01 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 3edb65f4e8fd ("nds32: Remove the architecture") removes the config
> ATCPIT100_TIMER and its corresponding source file timer-atcpit100.c, but it
> misses to remove the corresponding line in the clocksource Makefile.
>
> So, remove this left-over of this driver removal in the Makefile now.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Arnd, please pick this minor clean-up to your nds32 architecture removal.

Thanks for catching this!

I had actually fixed it up locally after noticiing the same thing, but failed to
push my updated commit because it required a force-push.

I have now pushed my earlier branch, which also contains an updated
changelog text.

         Arnd
