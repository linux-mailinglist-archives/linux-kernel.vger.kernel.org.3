Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1304E2613
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347178AbiCUMJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiCUMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:09:38 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4E14003
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:08:12 -0700 (PDT)
Received: from [127.0.0.1] (unknown [90.59.133.218])
        (Authenticated sender: eric.valette@free.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 589AF13F8A7;
        Mon, 21 Mar 2022 13:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1647864490;
        bh=xXEkKhP21j6z3maIS8t4Sjhtp6NJrateRL7U0XZ9/V8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Xaw0Xqk+UU939Tv2bOs7/Hca8R7E5RZtlT3zPkxnGDBqBN4y8m6IMwQ8c8kWSaEPX
         DqwgRGIIDvwYsN8XxC3tlong7FPxyVk9x/j16ADm4Jf3MccTgFFCVRlrckl5yiUiod
         7c0EpRy+4wR8jFsMKFbVFgzlcD9HDATJjlaI8qd4sapoyXC21kWC+VY19n61+p9WBq
         +34ld9Wtw7uuE84DIZoSAaNa7yBUQFPT37j3b0KaZ1kprb59Y3FLEC5S/WE49Z16Dx
         EUwR9W/d2v3oSGdbIVc+SYxwHFryUm0ZQZQnIXYgyQZq0/8ke+t6ZWU8DKcHCZm4aB
         EvLEZ2cdHsDWg==
Date:   Mon, 21 Mar 2022 12:07:51 +0000 (UTC)
From:   =?UTF-8?Q?=C3=89ric_Valette?= <eric.valette@free.fr>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Dominique Dumont <dod@debian.org>,
        Sasha Levin <sashal@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        1005005@bugs.debian.org, Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Message-ID: <ba7faa48-68a5-41f9-9192-f843e17c5a07@free.fr>
In-Reply-To: <61c2b2ce-d749-3723-ad27-f40e1c49d967@leemhuis.info>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan> <CADnq5_MfR99OhjumQESCO7Oq+JVOHOVgyVQHX4FpGFDnPu6CyQ@mail.gmail.com> <5164225.DI6hChFYCN@ylum> <c62d4ba9-2214-ca7d-ee78-ee19a9bf51e6@free.fr> <CADnq5_MWqz7-XhOS4zfuzi3=_nKa72iYaO0BcKNcVDwEvZ+YHw@mail.gmail.com> <61c2b2ce-d749-3723-ad27-f40e1c49d967@leemhuis.info>
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the
 asic in suspend (v2)") on suspend?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <ba7faa48-68a5-41f9-9192-f843e17c5a07@free.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My problem has never been fixed. The proposed patch has been applied to 5.1=
5. I do not remerber which version 28 maybe.

I still have =C3=A0 RIP in pm_suspend. Did not test the Last two 15 version=
s.

I can leave with 5.10 est using own compiled kernels.

Thanks for asking.

21 mars 2022 09:58:01 Thorsten Leemhuis <regressions@leemhuis.info>:

> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
>=20
> Dominique/Salvatore/Eric, what's the status of this regression?
> According to the debian bug tracker the problem is solved with 5.16 and
> 5.17, but was 5.15 ever fixed?
>=20
> Ciao, Thorsten
>=20
> On 21.02.22 15:16, Alex Deucher wrote:
>> On Mon, Feb 21, 2022 at 3:29 AM Eric Valette <eric.valette@free.fr> wrot=
e:
>>>=20
>>> On 20/02/2022 16:48, Dominique Dumont wrote:
>>>> On Monday, 14 February 2022 22:52:27 CET Alex Deucher wrote:
>>>>> Does the system actually suspend?
>>>>=20
>>>> Not really. The screens looks like it's going to suspend, but it does =
come
>>>> back after 10s or so. The light mounted in the middle of the power but=
ton does
>>>> not switch off.
>>>=20
>>>=20
>>> As I have a very similar problem and also commented on the original
>>> debian bug report
>>> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1005005), I will a=
dd
>>> some information here on another amd only laptop (renoir AMD Ryzen 7
>>> 4800H with Radeon Graphics + Radeon RX 5500/5500M / Pro 5500M).
>>>=20
>>> For me the suspend works once, but after the first resume (I do know
>>> know if it is in the suspend path or the resume path I see a RIP in the
>>> dmesg (see aditional info in debian bug))=C2=A0 and later suspend do no=
t
>>> work: It only go to the kde login screen.
>>>=20
>>> I was unable due to network connectivity to do a full bisect but tested
>>> with the patch I had on my laptop:
>>>=20
>>> 5.10.101 works, 5.10 from debian works
>>> 5.11 works
>>> 5.12 works
>>> 5.13 suspend works but when resuming the PC is dead I have to reboot
>>> 5.14 seems to work but looking at dmesg it is full of RIP messages at
>>> various places.
>>> 5.15.24 is a described 5.15 from debian is behaving identically
>>> 5.16 from debian is behaving identically.
>>>=20
>>>>> Is this system S0i3 or regular S3?
>>>=20
>>> For me it is real S3.
>>>=20
>>> The proposed patch is intended for INTEl + intel gpu + amdgpu but I hav=
e
>>> dual amd GPU.
>>=20
>> It doesn't really matter what the platform is, it could still
>> potentially help on your system, it depends on the bios implementation
>> for your platform and how it handles suspend. You can try the patch,
>> but I don't think you are hitting the same issue.=C2=A0 I bisect would b=
e
>> helpful in your case.
>>=20
>> Alex
