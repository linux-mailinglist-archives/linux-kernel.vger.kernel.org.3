Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807AD493DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356056AbiASQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:07:12 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:49947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356042AbiASQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:07:11 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MG9wg-1n4fZZ2hdk-00GWUC; Wed, 19 Jan 2022 17:07:09 +0100
Received: by mail-ot1-f44.google.com with SMTP id z25-20020a0568301db900b005946f536d85so3689564oti.9;
        Wed, 19 Jan 2022 08:07:09 -0800 (PST)
X-Gm-Message-State: AOAM531RENRBXb+eCsIFf+VVS2A5Ql/ca7uPr5SbIOekT+LTSo92dK1j
        qkFCdIwCq03BeI85i+LrHfTBLd1+/Ya6jOPmoSk=
X-Google-Smtp-Source: ABdhPJwYmjzUwr3LqMDlVmKxu2P94HWVRZ2m5aOzrrEpILDroO2fGK4U5w+vgoOvlKMup1bpupuBPszbhpm3gtVSmXc=
X-Received: by 2002:a05:6830:2095:: with SMTP id y21mr22337764otq.368.1642608428193;
 Wed, 19 Jan 2022 08:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com> <CAPLW+4n-1H5Yu3wQaus-UJ_VW_TjHrNUHaPCGCMURXg8EqxjyA@mail.gmail.com>
In-Reply-To: <CAPLW+4n-1H5Yu3wQaus-UJ_VW_TjHrNUHaPCGCMURXg8EqxjyA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Jan 2022 17:06:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ou-ZdrXN0MHQoJ+gGbvhXT-e2qt96_f9M8VwrdX0pAg@mail.gmail.com>
Message-ID: <CAK8P3a1ou-ZdrXN0MHQoJ+gGbvhXT-e2qt96_f9M8VwrdX0pAg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KKOZjnLuk3iTkOcRT6hWTWdg/xJkfcBwxDwv+rrf5J9WdII/9Fn
 LtchAOPQiM2ThFjFtCuY64ANMoz9G2Ye3JPrm1ty9Nv/9cI2Ps3sV67CbL15TjK/NWlpAHs
 FKBkkA659YwJJ8x2D6bfokSDi4Be+kJuoclNsGFOWhuM0lYcgMbPOin5QdTax0yDF5O6gY1
 Xy9j8T3ARUWQm1gNAecdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mk32gY16VnQ=:mE8AcpLw0STQToxkReeUBG
 tVAXcVX8HyJa6P0NhHPnMTn8C9Y70WU43fDSyuaDH1StVK3+hj6IE8MuYurfQKmDLjRQs+JZN
 /qWfnmjzzYLiLy7nXyfnBpJEyMymRXnU3GFLT8pncKVP7fZYjAJz/KRWXSo3FtwKpJAUDE8Aj
 n28JIrVMR0DbJT6FxWVBFtgUhO7AieOWTpI5cCfQsvZarmlBMFKqUojRxDxhg0Bpia6QOAvry
 IrjP4Skx4IZbE+w64lNsKlo/9IgL5NHmzIVZDtOH7HkFVtrJr6MGdoffAcLDMJqQh+Pc3d/A6
 FFcK9c8z/Cmt5t2fkpwZyre6H+QEbn7WjeaEgG1ef0WLbVW8iOxRluHLedhwFei4HGJ2ZfTsW
 yZNUZwuSycb8D+6YHMeeYzottpO+f27qu90aYGg5R3r7B/dOLQSvuhl0MT7FNOMRZhtpjntGZ
 uHterVa8LeeLA8e462C1p+z81vMq+frdGdT6cqWtarbasS7ZJbXTrpCnumPmfsReVBVe681Qh
 YiTktbuaZzx6ZK/IuFySYCvGSygJ6RYvG+qfR7QLJ9K8wlihYZD/4LsSdVCOnDAaKoiK4nroJ
 Gfy25bJJHJ2NO37ye5Yy9OSBbGYPLlxgtE/l4wyZffIYji6vVdcndBxlI7qSKI0l+YvcHfDfg
 APlNl+E57VsgIGegYhU2GtjxArwxn0yfW4qYQd6N9TJTiSihlU7iLDOAAVW4tqXecBZI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 4:11 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> On Mon, 27 Dec 2021 at 13:30, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
>
> Hi Olof, Arnd,
>
> Just want to check if it's possible for those patches to be applied in
> v5.17? Sorry for the noise, but that's important to me.

I can see that Olof merged merged this into the "arm/late" branch in
the soc tree,
so I assume he still plans to send it in the next few days.

With the timing over Christmas, I sent out the large bulk of the
contents (anything
I merged before Dec 23) last year, and Linus already merged it, the rest ended
up in the "late" branch.

As usual, there is no guarantee that late changes make it in, but I have seen
no indication of any problems so far.

      Arnd
