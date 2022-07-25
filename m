Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9506C5804A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiGYTnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiGYTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:43:31 -0400
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 12:43:30 PDT
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463FA140E1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:43:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id E1E9237CDA30A2;
        Mon, 25 Jul 2022 14:34:11 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VnwW3Pumlutw; Mon, 25 Jul 2022 14:34:10 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 657C637CDA309F;
        Mon, 25 Jul 2022 14:34:10 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 657C637CDA309F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1658777650; bh=C6eQ56WoqflhVshYvw4eSCbTOWmWQugcnRK1KwC4InQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HUXCmnoHrk+82zDVSN5TwrZtJv5I32HBsm1W/0ygtdInl+yif0P4tia7Sd5JAJRPU
         yulkymOoGGK7dA9UI8YmyA5VSuDRN1JJjoR3zzEIZDjsweTlVG5bWsddAOn3MbNmWo
         OfLJgjUHcP5wIl4ettt6QsLNsTiDjIz4SB4rD9wA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DNoUORfc-qsk; Mon, 25 Jul 2022 14:34:10 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 3BA9737CDA309C;
        Mon, 25 Jul 2022 14:34:10 -0500 (CDT)
Date:   Mon, 25 Jul 2022 14:34:08 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx <amd-gfx@lists.freedesktop.org>, linux@roeck-us.net,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>
Message-ID: <1446417444.13111032.1658777648586.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
References: <20220725123918.1903255-1-mpe@ellerman.id.au> <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC103 (Linux)/8.5.0_GA_3042)
Thread-Topic: drm/amdgpu: Re-enable DCN for 64-bit powerpc
Thread-Index: bYJinp50nUzyW/1gBugq0G+Et27Ikw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Linus Torvalds" <torvalds@linux-foundation.org>
> To: "Michael Ellerman" <mpe@ellerman.id.au>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Alex Deucher" <alexd=
eucher@gmail.com>, "amd-gfx"
> <amd-gfx@lists.freedesktop.org>, linux@roeck-us.net, "linux-kernel" <linu=
x-kernel@vger.kernel.org>, "Dan Hor=C3=A1k"
> <dan@danny.cz>, "Timothy Pearson" <tpearson@raptorengineering.com>
> Sent: Monday, July 25, 2022 2:19:57 PM
> Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc

> On Mon, Jul 25, 2022 at 5:39 AM Michael Ellerman <mpe@ellerman.id.au> wro=
te:
>>
>> Further digging shows that the build failures only occur with compilers
>> that default to 64-bit long double.
>=20
> Where the heck do we have 'long double' things anywhere in the kernel?
>=20
> I tried to grep for it, and failed miserably. I found some constants
> that would qualify, but they were in the v4l colorspaces-details.rst
> doc file.
>=20
> Strange.

We don't, at least not that I can see.  The affected code uses standard dou=
bles.

What I'm wondering is if the compiler is getting confused between standard =
and long doubles when they are both the same bit length...
