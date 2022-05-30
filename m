Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACDE537FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiE3N7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbiE3NvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:51:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416184A27
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:35:48 -0700 (PDT)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfZDK-1nK8wk15ZI-00g16a for <linux-kernel@vger.kernel.org>; Mon, 30 May
 2022 15:35:46 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2fee010f509so109981217b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:35:46 -0700 (PDT)
X-Gm-Message-State: AOAM530hDCIMXA2LTXs8jCJlLJAMpT/BAumIE6ARmkF3mgOZ1NZHH2lY
        3CY5HmMC1Q92ZDFrF15EL0XPtM10UmvUh2ZDNxc=
X-Google-Smtp-Source: ABdhPJxqcrHm9DJ9xalPcS1XKzKpoD6pOtVW3V1SFSsljiXnSICipI3F6JSFJRR63xqJBfk3V3It/sMFGGDe8RlARWQ=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr59829800ywk.209.1653917745100; Mon, 30
 May 2022 06:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
 <YpIR67FMtTGCwARZ@debian> <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
 <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
 <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com>
 <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
 <87a6aztli2.fsf@intel.com> <877d63tleq.fsf@intel.com> <CAK8P3a0-S77QLR1dK3NT6ot7JTAD5AdojAZJr-Xi112-v5EOdw@mail.gmail.com>
 <87czfvrwsv.fsf@intel.com>
In-Reply-To: <87czfvrwsv.fsf@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 May 2022 15:35:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0HNOCOSx9UONw6gf1UUU8J4iAOmMFP8-DtJ3O7XAACsQ@mail.gmail.com>
Message-ID: <CAK8P3a0HNOCOSx9UONw6gf1UUU8J4iAOmMFP8-DtJ3O7XAACsQ@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rzsa03eeqIQ8apQAiT85cbcZDekwnj75JYrCwH/bTgWY4EtRZZd
 QnZet8BsjNcEXzS6LvwNytFO9wCsF3+QkNHS8TG0KJOsdGheUWFgLXNdrS8n3P0ph0tSF/d
 JIt7vvZITIH/tZ5+YKtH4z6NIlEzzhdnlS13C/+TfTmLS07qzyD1I/VoBiqN5cHOsm63myU
 Jbr23fWS0yWignE+XUP5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6cTD7p23yU=:DEyHDjNBFwqbW/1LsGKpfs
 EFFD9OOc/9tUAwS8yS/2Ome7csgZWNM4MA1aeOJbeplnDOvlcQv13vyviYdqJdeZ5qzhdpFMJ
 XOQ424P+MrItrmZRNCjeeuShG3akBpuRE8ubROsrfdSxdhSWsOqjVmMB2GMicp+azm8WBxoMK
 keNhpRkL9X+q2W5j5Ax0h1ykhaWU8oBSSuUCWOn6mB1l+SkQBKqvmEwMnwJJSS2s9AWE6T6WY
 h7krffX7M1/PIFnrmqWL8ynFHzWVk8dPLKnCd1qKaBsCk1JmvhmEuMN9vC+D1dulgDmSagQw0
 fprzmoq0hdpnWB0g3aXL4Ua6sRE2Gp0kBAeEaXAoIfmkMw01BsEYzQN1T3YXWsVyWA2H04a7t
 SG1a12u3inP6v9Iu7l7AMyPmdpbdVUD4+XgTIS6fiJHJopPZNyYrMrQdy2OMmUWDd/oPuxUFv
 J2r+JhfdOIInJj4n0s9wRGeAVtKMd0IMA6Bt/iQTp+wVfvFAaVhTxePFvkGtlJ4knR03OFY4X
 thUDH4tOX4udPpmW6QaojbncmaDlWyqBoLNLObLoNmTWD6PzHaXCNxVySfwpRicB9k9FD+O1m
 s3C8gA9BjZG8bF8DbH00xHjAQ1skef0Xq48HHAHsuBMQGAuHXEpZhidX+iI3Rk+zhUI13Awoh
 oUCGX4egpkRgt0pKrrlST9jhCKOpULbZ92T3k8zQ2E/HwR5c7frcvIZLVKu42vRN40Xk0jh5e
 acSwI3BgU6P3noLDOLi2VFbTPE5tgjlRXI2robRAvCDEhG8KOdVrmtZuCEOGyfhwQpqhoDQth
 MqAIZU3GtbeHayav0opkJiVcIgzjCeNZicWo5SZ44v7+/1qvtqqBOdqSHMRd6h4JqGySvmajh
 bAbONdkfU5wFds0ZNdOQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 3:10 PM Jani Nikula <jani.nikula@intel.com> wrote:
> >
> > I think in general, most __packed annotations we have in the kernel are
> > completely pointless because they do not change the structure layout on
> > any architecture but instead just make member access slower on
>
> Please explain.
>
> They are used quite a bit for parsing blob data, or
> serialization/deserialization, like in the EDID case at hand. Try
> removing __attribute__((packed)) from include/drm/drm_edid.h and see the
> sizeof(struct edid) on any architecture.

The annotations for edid are completely correct and necessary. However
other driver authors just slap __packed annotations on any structure
even if the layout is not fixed at all like:

struct my_driver_priv {
       struct device dev;
       u8 causes_misalignment;
       spinlock_t lock;
       atomic_t counter;
} __packed; /* this annotation is harmful because it breaks the atomics */

or if the annotation does not change the layout like

struct my_dma_descriptor {
     __le64 address;
     __le64 length;
} __packed; /* does not change layout but makes access slow on some
architectures */

       Arnd
