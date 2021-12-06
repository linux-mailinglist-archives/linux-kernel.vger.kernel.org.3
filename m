Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4394694B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbhLFLFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:05:35 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:59339 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbhLFLFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:05:34 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAflI-1mj97s1F84-00B2wa; Mon, 06 Dec 2021 12:02:04 +0100
Received: by mail-wr1-f49.google.com with SMTP id u17so14221254wrt.3;
        Mon, 06 Dec 2021 03:02:03 -0800 (PST)
X-Gm-Message-State: AOAM532hvAxzs5RJeA+zDFzFBAxEQ7L+IXbwGXf+Fnh9lwP07R8EMI/r
        xdZEppRzO8yOYdc7xekYjC22W+OwKf5Ml7oOqGg=
X-Google-Smtp-Source: ABdhPJxij9pHL6GCrc+5tN6y1Ofw1k9UkkfiqxtBlBPZU0XC/yyTS444cMrSSQAnh0TTwApceQCGYi84YXzBmAR63d4=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr43602115wru.287.1638788523694;
 Mon, 06 Dec 2021 03:02:03 -0800 (PST)
MIME-Version: 1.0
References: <202112061844.RuSQXzxk-lkp@intel.com>
In-Reply-To: <202112061844.RuSQXzxk-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 12:01:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0wboR0evmNGL_VEsNNdLd9x_v8k3APH70t5gfu9D=A6w@mail.gmail.com>
Message-ID: <CAK8P3a0wboR0evmNGL_VEsNNdLd9x_v8k3APH70t5gfu9D=A6w@mail.gmail.com>
Subject: Re: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0+vHEvUgSzc7ExAhFFRrGaoFH6AXyFEk5MNZz6vET8xF+Ixxt2Q
 wcgTMTgTbq8As0Uv6zMh+cTTslJMb69zfgsGdMonOyJ2rDY8664vOvuXZJSe9oC6rdhttSU
 OArtbgYkiBtPIZx/3mmahmZW0tXQ7rVYXl4DzVrhlJmmVT3S4wegfcevTp0YHuEwc/U5EZB
 HXD0BQUNY9lWDFeCk1+wQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DVIC12MCnCQ=:08QAqHXBaY+IEJta+lXeL+
 hdsdlYxazWaUfSyms9dkNWLpMJoSUnqS/rTFtIyYZd490Z9s7h29sxALHA9kQHOal4FywQNqY
 639/IDzqoDt2u7ow0eL71r2iYWB8ks3zvdpw2shm28V7phsFQF3xzJmnGDVoxnDEP1/h4ZqVw
 JJzSjw0z9cU08+v/h3BxxEf3ozlmJYS8VyDuMWbymj0/UFzME+atM8VYqwwiES7ZIkZSz4+Nx
 qDTCN3WE6vaCKglU/BrU9cBhbE0JX0yuuRV5a+PtJTdtujKYP/bXlQedHG5RfsQpVEexSaQ+o
 YKI1KOg7LObyBsrF5DtovxwwGG0JZW7KmVkCawd1aryD7I8gzM693s2TMwo2GWC+rWO6bWh3n
 dizotXIPM60PiJ3ttMiC1uPT7VvIRdqhLC5YQ3vh4JQXiipEFOUO+ixJv9V+UqD0JTQoJMUxB
 1ob0gf7JK2cosCWsaoGt3OTzmY0dewj30A7EP0bTbnqoqKg6/0R+bPbzZk/VFdI4kzLYngU+b
 6cRIhBGcrlkx/AlKeXmy7IKEFKSTDMVvS+Sl396A8YzRioxhc6D5IEhONDrIawnJTQLx4qddy
 Vff+FKFjxmjoDSRvgCHmJlfVaqWHrUOZq8dCXnLP7bzKq7YgiOioPvy2nSFQBK0zhKwRhpouK
 aPPcyLrgE7KMripM+sowXaa6zAp+mYfFNNev2j4pXInCCdXun1gUuC5z+R23F2/ClT6OKqjDH
 2eHndq1XDw2Od+dSYpQME3MrNfW0S004TEPcfZCAM3kgMQCvtWYXTd0PAurse9chPwxYIAjQA
 9UJ54fQpxNqF8u7GDCzF2H1Cm5PkIOtARE3cEDG8TZVTzjRnqs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:30 AM kernel test robot <lkp@intel.com> wrote:
> First bad commit (maybe != root cause):
> commit: 570a82b9c36f76a5959b5e47900629b0d413931d media: i2c: select V4L2_ASYNC where needed

Right, that is clearly unrelated.

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!

lz4 was recently updated, and apparently now does a 32-bit division. I
assume this
is the decompressor, as arch/mips had similar problems.

The possible fixes are:

- disable lz4 compressed kernels on xtensa
- change lz4 to not perform any division
- change the xtensa decompressor to include the divsi3 helper code from the
  main kernel, see fbf3bce45821 ("MIPS: boot/compressed/: add __ashldi3 to
  target for ZSTD compression")

        Arnd
