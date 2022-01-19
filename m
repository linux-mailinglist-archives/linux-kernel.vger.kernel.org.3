Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBC4935C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351490AbiASHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:45:20 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42399 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245700AbiASHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:45:12 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mgvan-1mg0ZH2l81-00hL0Q for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022
 08:45:10 +0100
Received: by mail-wm1-f54.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so4042332wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:45:10 -0800 (PST)
X-Gm-Message-State: AOAM531dbBCanlVMAJYbrQvDvCoy2ZzZPgkv6A+ysB0fhEPlsTdcvk4a
        JymfzP1wejZYyNA3jOB6Pluzh3flM2VbzK6GI9c=
X-Google-Smtp-Source: ABdhPJyacKvJs/cpMGKfZs7foLPPZGv90A3Rb0UJJs4OpOlFFMxF6kfstoAm+J/PX+MK+DcAy8GPbxH87wXJjHSaXBc=
X-Received: by 2002:a5d:6488:: with SMTP id o8mr6666149wri.219.1642578310310;
 Tue, 18 Jan 2022 23:45:10 -0800 (PST)
MIME-Version: 1.0
References: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
 <1641980099-20315-2-git-send-email-anshuman.khandual@arm.com>
 <CAK8P3a1cDF=jEVGchU8LNBdjdtROmHHHpebOASreR=WOuZ4Z1A@mail.gmail.com>
 <00e28671-8d3a-f789-91c4-109814792a07@arm.com> <CAK8P3a2Q+iN1O6FEdUJRt=0bQu=6fkWAD3RCECfdhu4DKHq0pg@mail.gmail.com>
 <519f3b4e-e790-c051-3cb1-3fd229a3e498@arm.com>
In-Reply-To: <519f3b4e-e790-c051-3cb1-3fd229a3e498@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Jan 2022 08:44:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1t5N_vW3rcMD_e+UMy5EQDrTrE4QqPDo7nM_s1-Bf0XQ@mail.gmail.com>
Message-ID: <CAK8P3a1t5N_vW3rcMD_e+UMy5EQDrTrE4QqPDo7nM_s1-Bf0XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Add Cortex-X2 CPU part definition
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HPNtrAMsgSiYc1rC1lM4pWCGyB2YGxD6qosmU1jSNpYXrq+mw3a
 Z1f3XbwJRzODHBo/iN5F7KAJFUIAlbyG+cfB0HnkK/2fV7ovaqWtG8hyEaZ1z69W5b7uWla
 7xWSbZ6faUwg2HCN+9M1PHD/jdg2Jr3m5LRS3iBHgvSFOLKki8iczz1zNhrOiERJJXnznYJ
 4CJlPjkawl80k9AJ7Xbew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:umO5vec/4C8=:/+zB+S0NwM8CmoTeA8EkV1
 aOGWCdkZUEcmVf0kWkpQgdS8dyMNTy1TdWIwoqzsiR/JaRl/++d06U38O2VBl220Wtr57E8Fu
 R+VarlHmIMnyW1Imfho4ansLNvKmfmy4EHH1XAxUBaPrKq71QO3OlyFEqOijfJcwcRvhy/gXJ
 HF7c3HhQuwcPQRfbGZwVMxzRV8Hets5jeukQ+lhou+xxjw1wa8KqtbuIPxeprLqwo+tahlhsS
 Wt8O2o8hANY1ColXVCQeE5Br4eRaHnlBI09KR+l8o3b7ZTPRpKkYm2s59bvPt4d3w7t6EMh1y
 AwGmpnL2+laWtH5vLryhy7pKhLwhqHVRSeX5v/FbVOkNF6Cl/6HW/4SyTWyn+m1MHcV0wBcv5
 /z77fOlL/Pzmnp9sZzGfn9RnWIzVpQm7hhMJw7p248KikbpSP++vlk3SHyc4FYc47X2HabV9X
 dGxvbQSSdxvvi1WIi0zKCZ2VBtt8bHNuZyKovXmPY7yyUEVwHBHPDuG3tW9+qJ+AighBc0OLJ
 Ztio5+iM5gcolzxvtP5XxHEGSTmTOgC4KqsHpg/1HGLX/klXs2Xx54AcU/ZfnEkAXowqxczHB
 lav1vN3hJrcbAlhf0oGXOctAAhp+iZyGHxIvmVwHxI3gOy7Ni3NfTh3zc8FewQL0/OwgQj8vG
 UxzP+4yfF63yekMngIfy/MwBpPSs6/O3LlxNyoIGhTUYFNepRyXNvFr9/qZrmy0XwGvXQEaQA
 KxELzKqpq79HGUfk3dkE1lHIe+6JL1/GLqdjWCg6+7ZtA5g8ApLae6TCWe6mv+HK+YW8JU07q
 rGVDk23jimy5/jmBPp76XJdgqhPv0KK/ubjrQ58XMDP6HdVKzk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 7:44 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 1/13/22 5:17 PM, Arnd Bergmann wrote:
> >
> > It also helps me personally to have a known place to look up the names
> > by value rather than chasing through reference manuals.
>
> IIUC the purpose here would be a quick CPU ID documentation reference check ?
> I will wait for other opinions here and add the remaining in a separate patch
> probably.

The purpose would be to do what is obviously the right thing, and to avoid
more patches getting sent the next time someone needs to add a workaround
for another core that is already known.

If you can't do this without more discussion, then just use your
current version and
let the next person do it.

        Arnd
