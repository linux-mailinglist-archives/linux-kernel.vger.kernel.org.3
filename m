Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55552FA47
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiEUJWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiEUJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:22:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A11562C0;
        Sat, 21 May 2022 02:22:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g184so9638295pgc.1;
        Sat, 21 May 2022 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eVwXSEcM8+RBhdBEqFU8SHdsjcjqQ0piyTZmYlpvgv8=;
        b=FrbzxtqI3XnSH1ZKqSIHEUFu3S3YmFm91+WFgC24lWj/eX6XmO4c9aXP4IOCuGxKPN
         FOHIGN0QJsOenvchZOmLM+nhVXKkLGkp9kji1nPPPbntW953AlYuTXixLYCcuF6GenFk
         ZA8qqGWzu/9XlfskmIE4opoqhHH81b25NXtmDVL0CNiEclIrevx85xHTAs4tn0R9UU5R
         Drt9oOKh1b4i9hKDK6isYcavVtqkHI+umn/nHJdlgxaIAG3j3AlRDLQiKsFVDPINX3NX
         Lzcdl5ybSSw9LhaR7eAH99Eq++PSd+mcyon0oyt2IFEl80OkIS/cNtArkKjJXehHq46D
         7SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eVwXSEcM8+RBhdBEqFU8SHdsjcjqQ0piyTZmYlpvgv8=;
        b=ocwKHj6j9/8he0J90aaXBZ6pDM+NtPGXeN6eN6Zi9GvalYuQYVMwQMTf3pOAIhE4h5
         Dfz9NGczYPoCJA7Q3rkFJPWRsMOaDsWRTyoqT9DrIJ75QpZwnY4UcEkG4+NKIkY+c26E
         cDucqkh6wZWGU3mJYNz6IRqZy1fvOvb9zdEbYUaxgAOvskOCzYLrh3OG+OAJbKNkiU5b
         bV3a/vdHzdEymhjDKlszg2GeTPcR+nQ2erUSPVSZQfoHFSWjdBJLvFSFks1ck0CjkZKC
         ojtub28Vz1K8M8aad8rP7H0qj9emo/E8i11O9q7DxWTTzCrn7zPL5yDdv5I9NBVheKgn
         7J4Q==
X-Gm-Message-State: AOAM533e5jLA8gZKjNAHoUWKFg3Bc9XizU5kj2FDbFDOHvSyVCUp+2mS
        CrpQuQLi0GDEodrr7IY5vzQ=
X-Google-Smtp-Source: ABdhPJwPjKksW38Ww2pukzKZutD2as5QPONASQrrXNAUvBkhwf1IVt0HFlydQXEHCRXBlEphR7RApQ==
X-Received: by 2002:a05:6a00:1784:b0:50d:d8cb:7a4f with SMTP id s4-20020a056a00178400b0050dd8cb7a4fmr14004963pfg.23.1653124931472;
        Sat, 21 May 2022 02:22:11 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k21-20020a170902761500b0015e8d4eb2a9sm1122482pll.243.2022.05.21.02.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 02:22:10 -0700 (PDT)
Message-ID: <0846c96d-62fa-555f-b0ab-1f5ec33fd5fb@gmail.com>
Date:   Sat, 21 May 2022 18:22:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arm64: Unify vertical spacing in HWCAPS
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <4752814a-091c-9dd5-762c-6fd1a476c4bb@gmail.com>
 <e3921517-f903-3ad5-afa4-d7959051e5dd@suse.cz> <YoieFI7hdJPJW5qy@debian.me>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <YoieFI7hdJPJW5qy@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc: arm64 maintainers]
Hi Martin,

On 2022/05/21 17:08,
Bagas Sanjaya wrote:
> On Fri, May 20, 2022 at 04:01:33PM +0200, Martin Li=C5=A1ka wrote:
>> Promote headings by removing intermediate blank lines.
>>
>> Signed-off-by: Martin Liska <mliska@suse.cz>
>> ---
>>  Documentation/arm64/elf_hwcaps.rst | 23 -----------------------
>>  1 file changed, 23 deletions(-)
>>
>> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/=
elf_hwcaps.rst
>> index a8f30963e550..1e79044f51a2 100644
>> --- a/Documentation/arm64/elf_hwcaps.rst
>> +++ b/Documentation/arm64/elf_hwcaps.rst
>> @@ -171,96 +171,73 @@ HWCAP_PACG
>>      Documentation/arm64/pointer-authentication.rst.
>> =20
>>  HWCAP2_DCPODP
>> -
>>      Functionality implied by ID_AA64ISAR1_EL1.DPB =3D=3D 0b0010.
>> =20
>>  HWCAP2_SVE2
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.SVEVer =3D=3D 0b0001.
>> =20
>>  HWCAP2_SVEAES
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.AES =3D=3D 0b0001.
>> =20
>>  HWCAP2_SVEPMULL
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.AES =3D=3D 0b0010.
>> =20
>>  HWCAP2_SVEBITPERM
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.BitPerm =3D=3D 0b0001.
>> =20
>>  HWCAP2_SVESHA3
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.SHA3 =3D=3D 0b0001.
>> =20
>>  HWCAP2_SVESM4
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.SM4 =3D=3D 0b0001.
>> =20
>>  HWCAP2_FLAGM2
>> -
>>      Functionality implied by ID_AA64ISAR0_EL1.TS =3D=3D 0b0010.
>> =20
>>  HWCAP2_FRINT
>> -
>>      Functionality implied by ID_AA64ISAR1_EL1.FRINTTS =3D=3D 0b0001.
>> =20
>>  HWCAP2_SVEI8MM
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.I8MM =3D=3D 0b0001.
>> =20
>>  HWCAP2_SVEF32MM
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.F32MM =3D=3D 0b0001.
>> =20
>>  HWCAP2_SVEF64MM
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.F64MM =3D=3D 0b0001.
>> =20
>>  HWCAP2_SVEBF16
>> -
>>      Functionality implied by ID_AA64ZFR0_EL1.BF16 =3D=3D 0b0001.
>> =20
>>  HWCAP2_I8MM
>> -
>>      Functionality implied by ID_AA64ISAR1_EL1.I8MM =3D=3D 0b0001.
>> =20
>>  HWCAP2_BF16
>> -
>>      Functionality implied by ID_AA64ISAR1_EL1.BF16 =3D=3D 0b0001.
>> =20
>>  HWCAP2_DGH
>> -
>>      Functionality implied by ID_AA64ISAR1_EL1.DGH =3D=3D 0b0001.
>> =20
>>  HWCAP2_RNG
>> -
>>      Functionality implied by ID_AA64ISAR0_EL1.RNDR =3D=3D 0b0001.
>> =20
>>  HWCAP2_BTI
>> -
>>      Functionality implied by ID_AA64PFR0_EL1.BT =3D=3D 0b0001.
>> =20
>>  HWCAP2_MTE
>> -
>>      Functionality implied by ID_AA64PFR1_EL1.MTE =3D=3D 0b0010, as de=
scribed
>>      by Documentation/arm64/memory-tagging-extension.rst.
>> =20
>>  HWCAP2_ECV
>> -
>>      Functionality implied by ID_AA64MMFR0_EL1.ECV =3D=3D 0b0001.
>> =20
>>  HWCAP2_AFP
>> -
>>      Functionality implied by ID_AA64MFR1_EL1.AFP =3D=3D 0b0001.
>> =20
>>  HWCAP2_RPRES
>> -
>>      Functionality implied by ID_AA64ISAR2_EL1.RPRES =3D=3D 0b0001.
>> =20
>>  HWCAP2_MTE3
>> -
>>      Functionality implied by ID_AA64PFR1_EL1.MTE =3D=3D 0b0011, as de=
scribed
>>      by Documentation/arm64/memory-tagging-extension.rst.
>> =20
>> --=20
>> 2.36.1
>>
>=20
> Hi,
>=20
> Sorry for misunderstanding of this topic on my reply at [1].
>=20
> After applying this patch and doing htmldocs build, I see the HTML
> diff below.

Hey Bagas, please don't speak in HTML diffs.
Let's talk about ReST formatting.

So, the earlier part of the lists read:

----
HWCAP_FP
    Functionality implied by ID_AA64PFR0_EL1.FP =3D=3D 0b0000.

HWCAP_ASIMD
    Functionality implied by ID_AA64PFR0_EL1.AdvSIMD =3D=3D 0b0000.

HWCAP_EVTSTRM
    The generic timer is configured to generate events at a frequency of
    approximately 10KHz.
[...]
-----

I see that what Martin wants is the consistency of the format of the list=
s.
I think the change is quite reasonable.

The list construct is called "Definition lists" in ReST. See:
https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#defini=
tion-lists

This construct makes the defined terms be rendered in bolder
face.  On the other hand, similar looking existing lists:

----
HWCAP2_DCPODP

    Functionality implied by ID_AA64ISAR1_EL1.DPB =3D=3D 0b0010.

HWCAP2_SVE2

    Functionality implied by ID_AA64ZFR0_EL1.SVEVer =3D=3D 0b0001.

[...]
----

are not recognized as "Definition lists" and rendered differently.
Actually speaking, they are not in any list format.

So my suggestion of the title would be:

  "docs/arm64: elf_hwcaps: Unify HWCAP lists as description lists"

[...]
> Also, when submitting next iterations of your patch series, don't forge=
t
> to pass -v <number> to git-format-patch(1) so that the patch subject
> prefix contains the correct version numbers. I gave that advice because=

> I don't see that this patch is sent as v2 of [2].
>=20
> CCing Akira to help reviewing.
>=20
> [1]: https://lore.kernel.org/linux-doc/4752814a-091c-9dd5-762c-6fd1a476=
c4bb@gmail.com/
> [2]: https://lore.kernel.org/linux-doc/b95b3128-f010-dcba-1f6a-1a85dd2d=
20a5@suse.cz/
>=20

Yeah, please post the next version as a v3.

Also, please note that this document belongs to the ARM64 PORT
(AARCH64 ARCHITECTURE) subsystem.
So please consult the entry in MAINTAINERS and prepare a
patch against its tree at:

T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

and CC to the maintainers and the list of the subsystem.

        Thanks, Akira
