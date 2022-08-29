Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874895A4FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiH2O5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2O5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:57:10 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F9C83F21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661785027;
        bh=ABmTO9KwdpcoA1TtXvJlEjXSZv6SnPCmITt1SmlzwMY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P4JCSkXEBTwbM8BM6ABEIjpk0LmaFLhRYoK5ROoxwlCcgbDYDrFx9FlpIdAogPzUS
         rXeWYNP8um+HlUb4ENe+wMmybYRRdqeOiv2pypgpKu9ueV1OFIMXHs81ZQFk5UQOQp
         jwa6YPaA3FjUXwt81jiCc73p3YSeX5Ar/b7mW4q0=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 3F039667A7;
        Mon, 29 Aug 2022 10:57:06 -0400 (EDT)
Message-ID: <e0629567084ae5c1bab880b34b417256ea23f604.camel@xry111.site>
Subject: Re: [PATCH v6 0/6] LoongArch: Support toolchain with new relocation
 types
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Mon, 29 Aug 2022 22:57:04 +0800
In-Reply-To: <20220829133146.15236-1-xry111@xry111.site>
References: <20220829133146.15236-1-xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-29 at 21:31 +0800, Xi Ruoyao wrote:

> Changes from v5 to v6:
>=20
> - Restore version number.
> - Rename CONFIG_CC_HAS_EXPLICIT_RELOCS to
> CONFIG_AS_HAS_EXPLICIT_RELOCS.
> =C2=A0 It now only checks assembler.
> - No longer support "old GCC with new Binutils", so R_LARCH_ABS* is
> =C2=A0 dropped.
> =C2=A0 - "Old GCC with old Binutils" is still supported until Arnd ack.

> =C2=A0=C2=A0=C2=A0 longer support it.
^^^^
This line should be removed :(.

> =C2=A0 - "New GCC with old Binutils" is still supported as it does not
> =C2=A0=C2=A0=C2=A0 require additional code.
> - Remove "cc-option" around "-mexplicit-relocs".=C2=A0 For unsupported
> =C2=A0 "old GCC with new Binutils" combination, forcing -mexplicit-relocs
> =C2=A0 makes assembling fail, instead of silently producing unloadable
> =C2=A0 modules.
> - Move the error report for "lacking model attribute" into Makefile.
> - Squash the two patches for R_LARCH_B26 and R_LARCH_PCALA* into one.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
