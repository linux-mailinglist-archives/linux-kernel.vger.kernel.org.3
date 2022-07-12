Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD357144A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiGLITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiGLITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:19:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792DA239A;
        Tue, 12 Jul 2022 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657613970;
        bh=RZ/EJL3btc+F2hOcvq6PS/02fzcVymHrhmlsl8ctjeY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZKKgHdk4YaFMgbMsNvVaXiLVHZksVveStccelbYwLSAO1e60A3khV/PVh8Fyic56X
         KSPUwZaRxPi0sQ4Sf4NJfzBa2Dq3rWeKxNuzDQP7FxyzXS/bKOHakYMaYeLaPQJ9F9
         xIMoioRu8swxC4Edn1/oCg67AVuoNgG4idDOwRFE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.185.115]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1oAu8J1HJh-000MJo; Tue, 12
 Jul 2022 10:19:30 +0200
Message-ID: <6e1095c7-5a7b-c71d-7d67-321214106126@gmx.de>
Date:   Tue, 12 Jul 2022 10:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/10] video: fbdev: atari: Miscellaneous fixes and
 cleanups
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657554353.git.geert@linux-m68k.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <cover.1657554353.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y6OTXSI/vDD0Tc+MGb9ohXJ9PmVo6065zAfD2JiW8O6WIvwH4b+
 qyV6iWgCcllYv3nDjW391uFKSwN/tSYAjMmG0DEyUgfMhp/mt8CcPUC32UsqUzmrI6NDW39
 ZjZ/YJXukVlZwLU1QQoZEjlhycryINuOzFlQD+1RIxgd8iSXwFw9iO+so/ZOoLJNdDNrIAk
 QTEiETWTcvvApQkisUssg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gaa+xL1Kbec=:MZVxjw3JJRvAEL1HmzeYQF
 utKKkEXMIWs6985XNF4x510rfnNbKU8K9TGo9ckn4IMZnUadKi6nSOdTv/ZeZSMJQB1W46mM7
 +BL3IBgDiaVdLCtMHqwNDIDnktQVZYrELG5mbVx1XMw7lwe7vxZiW1Ag2cOIyL/it9VXSx3ua
 iXXM4iV1ZaSgAASszGPJaGZnoEGjbunL7nGouTxF66/NdjXMacDg/zpNnxKv8uf6hlk9Y9PSi
 XTVMxKq+JWHp9oIvcRjk0p5B2hHtsY/x6R7BBpHnYsvjegqRiVDOqxsxWlE65miJNwvNkHQlc
 ss97i/JIrtmQ14X2LBFl532JjhFy8LPS8qBEq/FzbKRFthdhzVxbNvYbrBaj6+p0yI8umhTrp
 Te/tEn7VrBqx5zy/k8DYALlKlRXzyeADo5W2EK/0B29aBmz4hw3lmk1HkjWlF/GqWF2Z6k1vH
 sQtkCLAFVeftwSQBi3bcm6BhMwta8jU8T5SO/3fH/mXeu/dBzyMrtg14w1M4BrSvYIbyH0Num
 vwbAhdagvvStKtrpkrwHI51jfWe2seSykqJYikkmSUgVGMQNtTI1uiCzzaigfIqMHaxxKCjdV
 8E+j5joAD3CDi7vjSFkHfDZ0KLVM+cQVmvmvzCkow6K6PkGtc+9vJH4GSuDpg5iJm829R3kPZ
 Fc6UE/g8Wfs8Dvd3t322tunBsVABi1oWKm3lbvpPvAADomTfqGIN7Emar0bFTQMgPKhb44ekN
 UdMnC2jeCe+XXJnrGmIXCNPgvg+vOmP1AhzMNTSzZPMLT/jSkZB4y3wtr/bl9GKPnsrT8Lh9z
 ZWZjnFQxnbIep8AJL+YGTaN+Q7RN8snv16uhieEMbVXVQSLEfdKfVyk/RI+9ER6/mhwcmrvmX
 z7nUN+5YKBEE9e4e9cTTH7lhrdm4D3m2Bcxk6dZIha6L4UdpWKM7HMw5YXUJVU1qJGiX9T2cz
 siEmGeZe8Wnl/IYuJrt0/zj2/S/6/JqLnpvcWfk/mcHvvz5ntig9ejp5zlc3yLRZfbYqaJmdk
 Yw/C+7hdm1N71OeCS2n8tP8/TOPMlFpTwcNvIsPkRdgrBDQo83kx1UF0hXWIERyXMOMRSyWYT
 9+uXkXiv/g8KAfP5XkEFClBFJgdRlQ0t7hQKTE8XOSn/GZX5TPZYSQxPA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 17:50, Geert Uytterhoeven wrote:
> 	Hi all,
>
> This patch series contains miscellaneous fixes and cleanups for the
> Atari frame buffer device driver, which were identified while working on
> the Atari DRM driver.
>
> Most of them have been tested on ARAnyM, and should be safe to apply,

I've applied patches 1-9 to fbdev for-next git tree....

> except perhaps for the last one, which is marked RFC.

... and would like to see some thoughts/feedback from others on this one .=
..

Thanks,
Helge

>
> Thanks for your comments!
>
> Geert Uytterhoeven (10):
>   video: fbdev: atari: Simplify atafb_pan_display()
>   video: fbdev: atari: Remove bogus FB_VMODE_YWRAP flags
>   video: fbdev: atari: Fix inverse handling
>   video: fbdev: atari: Fix ext_setcolreg()
>   video: fbdev: atari: Remove unneeded casts from void *
>   video: fbdev: atari: Remove unneeded casts to void *
>   video: fbdev: atari: Fix TT High video mode vertical refresh
>   video: fbdev: atari: Fix VGA modes
>   video: fbdev: atari: Remove unused definitions and variables
>   [RFC] video: fbdev: atari: Remove backward bug-compatibility
>
>  Documentation/m68k/kernel-options.rst |   4 +-
>  drivers/video/fbdev/atafb.c           | 101 +++++++-------------------
>  2 files changed, 29 insertions(+), 76 deletions(-)
>

