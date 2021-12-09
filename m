Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E546E5F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhLIJyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:54:50 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhLIJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:54:49 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBE3k-1mqMH70IvO-00CmWq; Thu, 09 Dec 2021 10:51:15 +0100
Received: by mail-wm1-f53.google.com with SMTP id y196so3694461wmc.3;
        Thu, 09 Dec 2021 01:51:14 -0800 (PST)
X-Gm-Message-State: AOAM532reFSc8qA5W3dqvnB43755Mk/DPeS1e5lTUURCKBMWZNvhHyh+
        Yg9zLHOycfQEpy9mIAF6RdadrrqzKKwTdjCFXfc=
X-Google-Smtp-Source: ABdhPJwsuOvM1/O8jYYNdv4ItTLWZ2lls/dbnVjnRNOupRV+K5wwYTXPPlK/3x0ieTJtdga3aOMcxHv7KRNJiPvKmwg=
X-Received: by 2002:a1c:23d4:: with SMTP id j203mr5540436wmj.35.1639043474655;
 Thu, 09 Dec 2021 01:51:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com> <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Dec 2021 10:50:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com>
Message-ID: <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Tony Huang <tony.huang@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XqlSS2Iql3zpbpcZnCD+8f101DACUu+CivcTz6dTxv7ILtzl7q6
 LadlwyDrPmHmuNkZOR5K/PDveVZlcS0JDeyesK8Ad3rhqmGcl5wU67xfRaHhHodsLy3Dsta
 wsUWzpa1R/MdjKXR6ZqwkQv4Q4S8kGshGmK9diBSN5GgPpU6pGDbkNMzT+EqU/yOBwPZAH1
 mjTS+GLFYsHHTvY7sup2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pfnCvxY2LkY=:HGkxj1fn5n+B8ZJd2oQlwi
 q1DdXZpFYUhGTPUK4XLfB4yj0VIANcnOAHrZ3ik+AfRFhR7jHqJWPIOLIBjgtfadrtVHHRDwl
 xzgGTrBO71mXuw7vhDzbi2s41s/Q2Ks1et2LiIzLvDZk3SzmeBbiDx+6Of4TW6SSKwr3XB1VJ
 DCo/Gp+QdQPOABGk6cZsr49nbtIgdoHJ23q4s/M/EjbcqPWGLizafajFdET5BYbjs2aYDHTNp
 YBx+BU2k7Ei+A59jyI3zhO42/Q/63ToJTXdQ/tNZ79uDLp7cvGq3WwqIebuaTfDGmk6flB5bo
 TCehBkZmWWGa0s+f9VuAlXTUvafyWdgfg7NjvUAH9T4K9pzUSbx2JmA54EzbVhAnVL6biOOEM
 57TfZbTUooMz/Uckb3NV6Mi6MaJ+TJRxc+I8fdxQZ1aoCOJNO+2n2XFPRR+Rr6ptNzA1c6qKp
 QwjJpuDk/0w+YAkDhgegKpf5EjWML6SXnKt9AKmux+rDEGTGqM/QH1l3uDl9ANC7jtLex9fOU
 /CVungM+4DCvrwfQbYtx3AtZyLMJlM7ArqOwH6zIpBdfwlHs+cCOFR8AMk4C2Lg48u06X8ndl
 62A9QJ7cKIqYonLFwi/J82gMWuwO//l2L42AvUDEptFHFDFun20p2tIvvdAaON9jWwNK4LLgS
 vgg6jy57PsOfJDXCpMn/OgqMDTmNzOy5rn4UAygoGt489SJCTsXGKrh2FVTueMp97nJw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 9:58 AM Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> IOP (IO Processor) embedded inside SP7021 which is used as
> Processor for I/O control, RTC wake-up and cooperation with
> CPU & PMC in power management purpose.
> The IOP core is DQ8051, so also named IOP8051,
> it supports dedicated JTAG debug pins which share with SP7021.
> In standby mode operation, the power spec reach 400uA.
>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>

Thanks for the improvements, this again looks better than the previous version.
I still have some minor comments, and there are a couple of details I have
commented on before that would need to be addressed, but let's focus
on the one main issue for now:

The driver still doesn't actually /do/ anything: you load the firmware when
the driver is loaded, and you shut it down when the driver is removed, but
otherwise there is no way to interact with the iop. You had the miscdevice
earlier, and you still register that, but there are no file_operations
associated
with it, so it still doesn't have any effect.

In the original version you had a couple of user-side interfaces, for which
Greg and I commented that they were not using the correct abstractions,
and you still list them in the changelog text as "I/O control, RTC wake-up
and cooperation with CPU & PMC in power management".

If you want to make any progress with adding the driver, I'd say you
should implement at least two of those high-level interfaces that interact
with the respective kernel subsystems in order to show that the
abstraction works.

        Arnd
