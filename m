Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CEC578278
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGRMi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiGRMi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:38:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06268114A;
        Mon, 18 Jul 2022 05:38:54 -0700 (PDT)
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNc1T-1ntovv2yxn-00P1WF; Mon, 18 Jul 2022 14:38:52 +0200
Received: by mail-yb1-f174.google.com with SMTP id 7so2914603ybw.0;
        Mon, 18 Jul 2022 05:38:52 -0700 (PDT)
X-Gm-Message-State: AJIora+3xLD7Itae2Iu7y/Mdau8z5Eev6nHweUCFBfXOvq5nPSbDwlOd
        nzx20I48jbQ1Z9544pFHv1JbRjqpB3cyMNvmojA=
X-Google-Smtp-Source: AGRyM1vapzEEu9ZgtaQdXwX9VGqTMMz6TeDMtqM5iGxSTzqDTPUtrnc1sKE6GzccxBqi3a9VkzSGFyDHhzu6VdFIHj4=
X-Received: by 2002:a25:73d1:0:b0:66e:aee4:feb3 with SMTP id
 o200-20020a2573d1000000b0066eaee4feb3mr27671458ybc.452.1658147931121; Mon, 18
 Jul 2022 05:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220718122922.9396-1-tmaimon77@gmail.com> <20220718122922.9396-2-tmaimon77@gmail.com>
In-Reply-To: <20220718122922.9396-2-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jul 2022 14:38:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2PM9pe5tN=N7BMdkwZZKNv9Wa+CEFCyQT_6Ur=O7P5pQ@mail.gmail.com>
Message-ID: <CAK8P3a2PM9pe5tN=N7BMdkwZZKNv9Wa+CEFCyQT_6Ur=O7P5pQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] usb: host: npcm7xx: remove USB EHCI host reset sequence
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Lindgren <tony@atomide.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jzFFZAGA31mTn/ohHcD0qj2/ahk4rft7ENCPnT0XV9jC0VzFpLG
 AvHIDX2uMKsBOzF+49GWSsFHdpdFciDJmgCa6V5/UMMfd32AQSMDvXerDnbrbVH5CRWa6r4
 slnxXWaer9eF0/0P52cHRQ5TsrURXmTSZsbwejmTTMQxJNEUtNb7x1sxO5dou22so0ocyT3
 qcID7HcqyOBuEyVsvdcow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QX8kOfZzZto=:0RyCtvTDmBX08Hg1bkdFzY
 gN4pAl/+k+6IXBLANU8dKMkH6FOCaOnL4xIILrWc43TYTdRtiu4ixK3b8xym2YHF2HjMH1dK7
 F2eTgCX+NIUCUYbR9DClbvxa0023wapPcGf0mKPfcj8XEl6smrUWCWzyhXsDo+OEJ+UgRxAqA
 jwTMX8ccV+qXyScA+dW6qz0CE/TqU8xF2ed0zTeJGaBecZXwZnjKbiuVscZPi3gtzUmPv2Acr
 q+v/kD/4fJg3KFmNlpWfAbvnPApHQBYbE0RIO+Ed+9sZDuNqcOgl9X1Q1AyPRjIx6HroPUYjO
 lv0Ah2xKyURBttHixj+Gp+oRh8CXg9Rr9a0dxeJ12IBAlmJyS9b5DxSgK3vIjLWG/49B99r9h
 jXgVFNAJ0x8AhrwNjdS7xkOg6fdT4/gaGloOd477/2W6Cnk+NPWlrdkE3oiNVP05U6Ch7ASd4
 +qVLBAwRsm/cb4u7JR7TIMNIz6uXKuRaeIz1nhlkYTd/pNIyiwqLSj/mbcEOpadtaA35J3+NL
 FRdMOeMHmBfXiRNoLRiknQgXK/G/zFW89rS6ZT1pSA4guPHZIF24nmE3LOdfIiPme230+Z53y
 ncwiHwic6TwEXceixqirDSa6weWMlbh16xrlwTzY9TVBoTsSTr+PScHYunto9kSXe1QS3dn8N
 xUn6jVbcn67YG4lVarMe7idF5lTBTXohrTLABrVBNE7XFwzmQn4xvPAXxh3MvKfY/3hsfZ9xn
 468/rs1RHXqdW9P8QkepKX0elqB89VGw3PPNsEdTjLjFf69D14qsd4hZBZA/G8j1uW1RUzb2O
 4D4nxvIyiHHdWTXhlFp+sFFCqCrATYTTB4S+OXEpEi92tZFLj+XSBc5ZU5CSUUaSZwN4VlONQ
 aYuOQvnTvuYZ/ffnxn2VyR0ZCurOWuIcKibeNfXlM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 2:29 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
>  config USB_EHCI_HCD_NPCM7XX
>         tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
> -       depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
> +       depends on (USB_EHCI_HCD && ARCH_NPCM7XX && RESET_NPCM) || COMPILE_TEST
>         default y if (USB_EHCI_HCD && ARCH_NPCM7XX)
>         help
>           Enables support for the on-chip EHCI controller on

I would leave out this Kconfig change, there is really no need to enforce
this specific dependency.  It is expected that a device driver has dependencies
on several other subsystems (irqchip, reset, pinctrl, clock, ....) and will only
work if the required drivers are also built for the same kernel.

Also, forcing the USB driver to be a loadable module when the reset driver
is a module (rather than built-in) does not guarantee that they are initialized
in the correct order. If only the USB driver is built-in and the reset driver is
a module, or both are loadable modules and USB gets loaded first, then
the probe() function should notice this and return -EPROBE_DEFER so
it will be retried after the reset driver is successfully loaded.

        Arnd
