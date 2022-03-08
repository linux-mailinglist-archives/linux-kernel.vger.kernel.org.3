Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CB4D1AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbiCHOwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCHOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:52:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB93981B;
        Tue,  8 Mar 2022 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646751102;
        bh=5YDlD2A0oaMnEk1O2RAt7W4Fa7ktAP8bP6EdmwI+QIM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Djvv9wfEEKhFJqRJ5+C6rXGLP4vriNusK0fQU+W7akYRot/ktZMAxz7Qv8mFfZtpg
         YhJjLCWU8gHyCQoyhdhZ9ckFxJtuOWQ4wk0t9xuue6uOX3GNk09HTaIJ5guX8pGY9H
         w7FJmvobDkOaRRKCcUWrIDmMY0LhQU7L/dzfyWKs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.180.167]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1o9d9S3Eqe-00zrqY; Tue, 08
 Mar 2022 15:51:42 +0100
Message-ID: <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
Date:   Tue, 8 Mar 2022 15:51:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cSwUj8PD/hf88WFnajfY6gEX4lSFSPz8RlVRQq81FeKpYFmH9mR
 /+UGyxZaJbHeJcTFwMvqmTbo9MIR76GS7TKjEWIN2+OooiFsbqhCl+DHBihvo2cerF5xmup
 1ikhkHf36otwRhc5ItEz82tXtnIFoqLkfAXc4k37nY8T0BetMEkaIB8edaFgCR14aoHrrgn
 9Q7YALUJOvUUFF8eO+OuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NY1GdIxjQrQ=:r7wKNvSsWSG2HIiieR7yJh
 84y63mdj99HKHItNDVV16Ii9T8oTGUTHp268bgk1BIjFwvDblix34XN+LtwV3OGUXQpTJ0iG9
 9yVrzvL615BTr6yZhx40DcLYl5SB5DGqTAQGCcjJUOFPMWWegdT5YoiFVuQyFylVlTBtE7h5j
 VIXOuOOr3ON//nwQb5Dd9a4IyLiKRgmHQB3xqwuwnkbhE+qQ2tKxk4KKTugGoTxAkVS9a5Mcj
 g9uGWa36O0X1h5D3E3qgnRwqZve/72lG/tdr7HXSunAIxMNYQy6i+rRgBbbj3MIPxJrhucR1M
 1ROQO0mwJtPCEkLyikQWCTGP0ep10YUnKTgUJ4XmBxOWHFwUNNMcBXkE3XS/u0YhKu9KQMzby
 J32jYxNrYmrUFs8FmP8y+Yj2NsfQv55+ZCyq5sEhvTc7BIna/5vnvskNGA08pdgV4Yuz5XamE
 UaEB2t0q4914sVW25+VRJAsf+szd69QTaWcWxt+/oErcFZkJl2I1jZm9pFfMziEEUgBIFeCkv
 KxkJPmHaMPkLjubnEyCLYqsmwpjDdjRlpBsufLnnQjIb/qgLnciEQwgw8/v8diHlHLsMylPWq
 ouOY4RFwx2Qys/R+1gFQVxcjJADQTQor4YbsdeYGvJQGbKkL2zS4GXZdMx8WEQRmjVpkXNCQw
 o8ux9UhMrdAE3+XvRBMGuPLQsivlRh1gz6djs2fLbTv8QUHpnfHB+Rt9VF5c4UrURtU6Q6YMU
 idrpfgLRmcPyEoYBQv0LukhzueORFRgyyDxlAvxOyMndgaseer2ck75PxE1PVaZTvhUJoXeYH
 al8xUk7NYFFA9l2dKP3O56B8XmGkaREeZpanHyH5YsUFGl/bRvAlBikyUUvpfqyKQgpduCA3t
 byBX3pZyrHvKM6mdWouA7J6xNKemIWG/RHGt8gxzsyehA+M1RNhGNm1mr1hN+t48GE/bG316n
 Jpxb6uzTlakiwmYVYfhxDBEpNJ0UYNXlpz3VCrbBBoRRLna7ZRT1kFj2gS3sisi1g6U6EJw+J
 OKO2KZvW2bjswAFES9XNjJdIkwQqF37MUUw8D3gBhjaWvmGdOeuXwhBshFeMXZq9uQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thanks for testing on parisc!

On 3/8/22 12:06, Jiri Slaby wrote:
> since the "parisc: Add vDSO support" commit, I can no longer cross-build=
 a hppa kernel. I see two issues:
>
> 1) CROSS32_COMPILE detection doesn't work here, as openSUSE provides hpp=
a-suse-linux-* binaries. It's easy to overcome by "CROSS32_COMPILE=3Dhppa-=
suse-linux-"

How is it handled for other platforms like s390x?
Would it make sense to add the detection for SUSE too?

> 2) openSUSE doesn't provide any libc for hppa. So gcc doesn't provide li=
bgcc.a and the build of vDSO fails.

libgcc.a comes with the compiler, I don't think you need libc for that.
I'm currently installing opensuse to try myself though...

> So could vDSO be optional on hppa via KConfig?
The vDSO is one of the first things which is built during kernel build pro=
cess.
This is why you fail.
Making it optional doesn't make sense, because then the kernel wouldn't be=
 able
to start the user space processes.

> I used to use the cross compiler to at least compile-check the following=
 =C2=A0tty drivers:
> arch/parisc/kernel/pdc_cons.o
> drivers/tty/serial/mux.o
> drivers/tty/serial/8250/8250_gsc.o

I assume you never built a full kernel, but stopped when building those mo=
dules?
Without libgcc.a the kernel itself wouldn't have linked before either.

Helge
