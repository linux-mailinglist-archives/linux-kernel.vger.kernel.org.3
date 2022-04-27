Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57857511D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbiD0QGV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Apr 2022 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbiD0QDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:03:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28955291FD4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:00:13 -0700 (PDT)
Received: from mail-yw1-f176.google.com ([209.85.128.176]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhDEq-1oO2yc3jve-00eJTj for <linux-kernel@vger.kernel.org>; Wed, 27 Apr
 2022 17:59:33 +0200
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f16645872fso24044307b3.4;
        Wed, 27 Apr 2022 08:59:32 -0700 (PDT)
X-Gm-Message-State: AOAM530zVO8LeX1h8HIQRV0fp2If6i2g9LCpsw1LUT37jPLz/QRiZKmM
        AuedKsdJodkcVh4ia6OwQHbTl0pmgiJ6Yca8DlI=
X-Google-Smtp-Source: ABdhPJzLjeye9A9OWhShH76hys3ishcYLuK3veH+wxcTEvEyq9x/yk6faCk7GM7cQVbAcpTgBWV2wb3Zfj0ajrT/jKo=
X-Received: by 2002:a81:9213:0:b0:2f6:eaae:d22f with SMTP id
 j19-20020a819213000000b002f6eaaed22fmr25858625ywg.249.1651075171676; Wed, 27
 Apr 2022 08:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644824638.git.quic_saipraka@quicinc.com> <9c7ff199d826b60e019c0eeeb6aa280abfdb9a82.1644824638.git.quic_saipraka@quicinc.com>
In-Reply-To: <9c7ff199d826b60e019c0eeeb6aa280abfdb9a82.1644824638.git.quic_saipraka@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 17:59:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_Ea2Szn61D-t--52V-zk+B-sq2mi5YbfMbTim7M9ZAQ@mail.gmail.com>
Message-ID: <CAK8P3a3_Ea2Szn61D-t--52V-zk+B-sq2mi5YbfMbTim7M9ZAQ@mail.gmail.com>
Subject: Re: [PATCHv10 4/6] drm/meson: Fix overflow implicit truncation warnings
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        quic_psodagud@quicinc.com, gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:JNeg52fHtEqelo16dAcn1Vtflrzc43MU8QX9pr//JGOAsEvcUUZ
 wEOvlxRgd5OA5vg06KRyALn/TtZeFIvL1i53rkiIx4hAz//EkI3/Bx+hMxtzJ1xIiXUgk8a
 6PSkw3k5V1Lfoa6EmMZ8XnvKisARJGTUhxGX+YnhyPWSLJPvYE12jgHqm9pG2SfX6oYbCdr
 OvvuqwxfB3OdW24P+XK6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y9KGMoLJJWg=:5eJvyXeWYLg2M7ABpj+EsB
 Or+r+qHNg1RziXROIe5ZMdQX4Cktt4iSl1+AJTnsMxgwJkukznW2gN1CQGQfZYKm0Ua382Rv6
 Tmx+kdmgCMngab8VYcjbyH9B7O1E7SPPNBFJNjl0QNthHH7IxM0S1J8/LlPEqvneVfPBeGsDl
 J6rfRGtVigftiJQ7lxw0EO2za6192Xu2zIYiyTGJCHWAbwaLcVZgnbgLQFwEt7n+0baQBcD1e
 5t0swPZAssJSJ9WE5ecN+nnuFLdvfDjdkd9gJHujWOg0eZEI4orMq7JAg1LVg/cFDOR5KxG4d
 jZvjhae46nq2ExkduMwOxhtDoY11LlF21kO9aRsTZ1JnZcXiRw9UZe2kzg3Ub40S9y2yyXOY/
 IHmAMXu0GgN7Y6uoVGhpbQQT6Y3nXUQwjztHhLWXNILf1MclmyHGCPvfUV7vqe5KOMrxSteE7
 /wvIKj312yWgBI0MmP6mkgBIxiF4cUbdYyNB6Rtgnh+WS3+VPrGDwyrmUnBAjfX6vnfJvoHtt
 tGOvyt5yKFc27uDIGyOsnGnp2rDyW24e1fuwag/x5zkk+ZptQQavr4QE2bwHmrJ7yjnbEgPML
 14OT2vxFJ5sZapxnNfelgca6wn/JZ9DhLsjkYWq0nWwe8GHU8Wv7TsOGiY728zaEAW6bq4rBq
 2TaU1IlMPjX5BCYKU68OBQYoWH8K/9Gs3UMJe5dWdLGh13QbB14AKkJxdYF3xJWi8ubbB0uNR
 8u7iv3KQtTgmklOlpvkmZlf84fLi8kMUKbDnhj/u3JVhGKGks6vga+18JEaJKsREUyVVsscYD
 y4BHbwNOl+2M3ZBiIlheasF+VHa4mcfX6tBGIS1S+a77umYXiE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 7:07 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> Fix -Woverflow warnings for drm/meson driver which is a result
> of moving arm64 custom MMIO accessor macros to asm-generic function
> implementations giving a bonus type-checking now and uncovering these
> overflow warnings.
>
> drivers/gpu/drm/meson/meson_viu.c: In function ‘meson_viu_init’:
> drivers/gpu/drm/meson/meson_registers.h:1826:48: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>  #define  VIU_OSD_BLEND_REORDER(dest, src)      ((src) << (dest * 4))
>                                                 ^
> drivers/gpu/drm/meson/meson_viu.c:472:18: note: in expansion of macro ‘VIU_OSD_BLEND_REORDER’
>    writel_relaxed(VIU_OSD_BLEND_REORDER(0, 1) |
>                   ^~~~~~~~~~~~~~~~~~~~~
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

It took me a bit to understand why we got the warning in the first place, but I
should have just read the patch description, it's all there....
