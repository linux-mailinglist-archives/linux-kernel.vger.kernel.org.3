Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2D4ECC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbiC3SoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351029AbiC3Snb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:43:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406A517D4;
        Wed, 30 Mar 2022 11:40:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 10so18904126qtz.11;
        Wed, 30 Mar 2022 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to;
        bh=oMpu/Uq8rY8eahUeZAHaEp88VMX4giAOIULlZrq+voY=;
        b=oSkpS7AgyvzgbEOaTfVisfi6SR1JA+3VhGV/3mAr2g1PNwOJVuh4nLXbxdbXA0MIcp
         2sA2laLpD5zPKizoxQwKD3afztwqs9b295kKfrxBw/x7SKuB537Ll4WAhOl3eAOEpjYR
         OWL3Pqk6i1HPu69vtJObtjMkeXVO8o3BTvsTkVNsquya+u2p6DtIc7nOdpOM7+VrHqGh
         2egO2EJzr4rb/MEmOeteGY9nTD/eZAayt8TIfIpEgAsqvKhdXUDTFFh4pOKrRjBn3hNq
         7ETAvyKiyHjrPpplkl20VIJK0Ly7P2U8eqfe9ycYjWdJMjLu6Y3b7vpjXcTuhEvcvgl5
         HiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to;
        bh=oMpu/Uq8rY8eahUeZAHaEp88VMX4giAOIULlZrq+voY=;
        b=JT+a4tTd9zBNEH7aZR4ayI9TxzH1aLdgwUxkKYbeoxXV4qiWwPmf4rzIf3JhhuH/+G
         C8uhqivtPd1WhSTh35FE+T1kYnJfmORIChK0VIvxcrfFty0YmVEJFqy5eDmpgdRpmfZB
         9lk7kaMMBb4yCvfz4jNsn70Z1jEwzVnhDCgZDlTxTdx32q7Ks0bF/Ys9SwGPPi3jpWIA
         n2slPnroItkfaAFTiSEJuoVUec+2v+Uo7NUVvZqq51UzIvl39mYL8AJ59Ixzk2jLV2IQ
         v7/+W7VksJTZ51mtg/zntHBsDR/eqND8htCsfBXUR+t9LsdymKEavcSgWVrBnEa3EEa8
         K3pQ==
X-Gm-Message-State: AOAM531ueNObnmztfe3jqavf0KdWP3cTBcctTayvyfxBc1p/xigusclG
        Hxzslj65itpzfK6k9RqDTKX9D2j/bqGBoPR8
X-Google-Smtp-Source: ABdhPJxIAzQxSCHhvGF3MVeIe6kjzdo5jaBsBnVe9sXN2B2N4eOqVg7AIG9XMIMSr8E3Xlc5SUvl1w==
X-Received: by 2002:a05:622a:5cc:b0:2e1:ecc9:5a2a with SMTP id d12-20020a05622a05cc00b002e1ecc95a2amr893670qtb.554.1648665603802;
        Wed, 30 Mar 2022 11:40:03 -0700 (PDT)
Received: from [192.168.1.115] (cable-217-24.sssnet.com. [24.140.217.24])
        by smtp.gmail.com with ESMTPSA id d11-20020a05620a166b00b0067e380258e7sm11026242qko.73.2022.03.30.11.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 11:40:03 -0700 (PDT)
Message-ID: <e55edf6f-2aac-87a5-c0f8-363a536b9f92@gmail.com>
Date:   Wed, 30 Mar 2022 14:40:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
 <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com>
From:   Ben Westover <kwestover.kw@gmail.com>
Subject: Re: [PATCH] riscv: Set SRCARCH to riscv if ARCH is riscv64 or riscv32
In-Reply-To: <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CNumU1QqguCijxQIViP4s0gy"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CNumU1QqguCijxQIViP4s0gy
Content-Type: multipart/mixed; boundary="------------I9woVjAhPvnj4Iqbm0KgwoD0";
 protected-headers="v1"
From: Ben Westover <kwestover.kw@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <e55edf6f-2aac-87a5-c0f8-363a536b9f92@gmail.com>
Subject: Re: [PATCH] riscv: Set SRCARCH to riscv if ARCH is riscv64 or riscv32
References: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
 <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com>
In-Reply-To: <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com>

--------------I9woVjAhPvnj4Iqbm0KgwoD0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Masahiro,

On 3/30/22 11:31 AM, Masahiro Yamada wrote:
> On Wed, Mar 30, 2022 at 11:34 PM Ben Westover <kwestover.kw@gmail.com> =
wrote:
>>
>> When riscv64 or riscv32 are used as the value for ARCH during compilat=
ion, like
>> in tools that get the ARCH value from uname, set SRCARCH to riscv inst=
ead of
>> failing because the riscv64 and riscv32 targets don't exist.
>=20
> Can you refer to the code that really needs this?
Some software like DKMS compiles out-of-tree modules by running `uname -m=
`and
using that for the ARCH value. Without this patch, that compilation fails=
 because
uname shows either riscv64 or riscv32 while riscv should be used.
This code already exists for sparc and parisc, as well as x86 of course.

Thanks,
--
Ben Westover

--------------I9woVjAhPvnj4Iqbm0KgwoD0--

--------------CNumU1QqguCijxQIViP4s0gy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEOGnacqRhdU6eNmtFwxHF9U6JtpgFAmJEpAEFAwAAAAAACgkQwxHF9U6JtphI
FQ//eBXMorXQ1ynRB84bL3yXZA7QvEoZagpg10OmqZiMoAOetYtmHt5/JSLJNDZZzV1UkI2rmFvu
V7mgnY5gRTHVexIO/JmGt21iLpTW/ZXljz1hLoyHxWlAeySHlXgRTGyCzJOJlri89WVKqmjV4ZFy
OdVP+0WbgCWAo3npLcn8yYEkzXhTIoXSZghiwnfWlWfWryn3TjPkBxi5ncpNDLr2u1Imp0Ps8YVp
dwd5/o2apPCIJ++vVXs12z/YMvORjBk+iLuQkB42SN3tbaBcZKcK3Fbyqyde9WBre/hHx12vwPNa
1So3POhnM4xRLxSXEqGQhn1JYA4QlbUTFUNHhSjRvOykMZmtih6owc/J8CCa+9xHpWcn/whN6FCq
J4MEIWmkospWONCQsbEb/gkpTtDLuYla0T2gkCJ233D4pTXejQvmDDFCYkyQzrcSpprWXaMrKzNR
BwF4zTWDOQeEQbJlxIssWATiXLAYYJ6PT3yddfTkzNOI3cqDSM2LeBMtUkUQvr63eU/OlzH0ClQi
RJfpUU3ZNBcM5tR2jJ6HaDlP08Dkwegcq6VRfGt0VNvfBHe9T6kYszssQWMEU4c+PlvSh0ETR1Y1
sduLfQdTcVgTtLV1ZUMkttnblnII6CT6J90B+d8sahlMMXSM+vQSX3ytrENMmzkXn2ZkzvFDWjDw
bYQ=
=jQFd
-----END PGP SIGNATURE-----

--------------CNumU1QqguCijxQIViP4s0gy--
