Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC96D4731D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhLMQ3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:29:30 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:52313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbhLMQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:29:29 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MjSsm-1mGZgr14Ze-00kwpa; Mon, 13 Dec 2021 17:29:27 +0100
Received: by mail-wr1-f49.google.com with SMTP id d9so28056714wrw.4;
        Mon, 13 Dec 2021 08:29:27 -0800 (PST)
X-Gm-Message-State: AOAM531Ca8WbXmEC3X5+Gk6phsD8/fDdYRtWq+gv5+tt3wlW3QMMeJOJ
        IiPNesHz+nwvuFThKO0TynJrP1XAY0anJH6biKo=
X-Google-Smtp-Source: ABdhPJwG1WZRcYp8Ayblot4FmiUPU2o8ulqLJOd1oO3UWNGAmNWkt5SFVqDLLkyRFkJ8yFRh7CcmrgtDmB9Gegd1GTQ=
X-Received: by 2002:a5d:6902:: with SMTP id t2mr32606385wru.317.1639412966819;
 Mon, 13 Dec 2021 08:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20211202095255.165797-1-herve.codina@bootlin.com> <20211202095255.165797-6-herve.codina@bootlin.com>
In-Reply-To: <20211202095255.165797-6-herve.codina@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Dec 2021 17:29:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3YGOS5Bp+vFCfsGOUsEfwgJoNxJAGVXZv=QQ73k6Eoqg@mail.gmail.com>
Message-ID: <CAK8P3a3YGOS5Bp+vFCfsGOUsEfwgJoNxJAGVXZv=QQ73k6Eoqg@mail.gmail.com>
Subject: Re: [PATCH 5/6] irq: spear-shirq: Add support for IRQ 0..6
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:e3ERfVT4qvgVJEOlaq1pwRqLt4LMTejSVgO4fMysyj9rQGn+sNO
 kamvpalerDq0yXv3gJWm0jwSVP5/oUS4/0NME6tbd42ggJd88ApSOFXxNxpSaekfAPtrlsq
 Wzh1xDCCr6F1qB24lxfj7F7g9ETLPmyqvXMWdoSYExWnka2cVv1dftUTvQNfNq1qCASvogo
 jVHWwW/imPXuA6CKuFabg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:27OdtThCVsU=:K9RwuHi/utt0kMOq3qmu+2
 HMEUUZw78vmml7wtCKa7Zr15szYHhJjTM9tayjHTypaVi4hoIYwPHxVHOfz4zLnuG1neNbC8E
 GHC2AfW3rPaJIafG9C1QySFz4SB+0tkMhomU1dfD6JXTRAPDnA3OlMmGCdjeiQdEJQ47FkYdf
 p38zAIfpxltWJdfg2P76zJKfDg9xsCWKMOyCf63S3E7fXp1W4Acbq+1m9hZl+GY1ogn0SMqZG
 qAXeorzfUSC74Vl1/P9SgqZbU/Zk97HeoeKFI4miP4KF5hWj6uS23zvUGHSCzq7MNlfXrL32T
 p7Ve9D86b9DvUNaVRT2MkKSLUSeZkBOKN5WP78TcFkRdoM54sV4mnEsbxGbfTQNWJWi89SX5P
 +FvlBq0RVlcP31o9mb0VmF07bwclVNr4z68mvEIso47YXtxio8eKgkUp/AFQirq508+9EylAT
 csE4O+ISpJ0v3nNp/QM/+p/O+B+vXxbJuTShqIBPIEK/iXSP+O25D5LSFfmshPmti279PNzcg
 ur6/ViNm7kjTb0IVcr3DZEypP2paJI0Ij7OLXONmsafMilG8uMgGoi4q/CiT79TPRwC1BjcGE
 +Mq2q6VwxAeQSo5HGSIYye5gqZZ6kHrul2OtZrAiOZMkfDvdVR0pdbYIeL56cxp9TVrdF0YvW
 7pC/kgGLa3zVvlnoF4TkvedaJaQjPqUOTne7mEXlWfUVja5AV0ePfRzNSePB5lHzYAJbAc/lx
 vLVBiHOhpUbpp4yH58uXgNpHpkICh0CueQkQOFzGqOG0QzVibD+eksSWDYLHZ3Dp3OE/KcW6p
 Ojs0P4nlPo7mrNfULExfVU9yQDUZaVgs5rlNFvYw7Ovewt5VnY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 10:52 AM Herve Codina <herve.codina@bootlin.com> wrote:
>
> IRQ 0..7 are not supported by the driver for SPEAr320 SOC family.
>
> IRQ 0 is not reserved in SPEAr320 SOC (assigned to GPIOINT).
> Furthermore, in SPEAr320s SOC variant, IRQ 0..6 are assigned
> as follow:
>   IRQ 6 - NGPIO_INTR: Combined status of edge programmable
>                       interrupts from GPIO ports
>   IRQ 5 - TX_OR_INTR: I2S interrupt on Transmit FIFO overrun
>   IRQ 4 - TX_EMP_INTR: I2S interrupt on Transmit FIFO empty
>   IRQ 3 - RX_OR_INTR: I2S interrupt on Receive FIFO overrun
>   IRQ 2 - RX_DA_INTR: I2S interrupt on data available in Receive FIFO
>   IRQ 1 - Reserved
>   IRQ 0 - GPIO_INTR: Legacy interrupt from GPIO ports
>
> Add support for these IRQs in SPEAr320 SOC family.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I took patches 4 and 6 into the soc tree now.

       Arnd
