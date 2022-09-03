Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3B5ABE97
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 12:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiICKte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiICKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:49:30 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC34E6B
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1662202165;
        bh=8I2CCom6GzLdMkmqYuc6ZCbm5jRcJA32i6ToxSl5Zkg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g5DNxviT7XZuksCX+3hFQNGEDISb+9Nr+bXh2GWC+RI87IcV6c0kwnpV3xVnVeUcn
         K7NAxY9hGbkY/LEcEA+xeTma50VvqksF7tWiwIbnhm5KJge35asDjQMenIjmdoXVNt
         dywTOcPpJCZd6uf8GaBMTRUJQk2fdcfkwwVL5Pog=
Received: from [IPv6:240e:358:1104:1500:dc73:854d:832e:4] (unknown [IPv6:240e:358:1104:1500:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 10E1065907;
        Sat,  3 Sep 2022 06:49:20 -0400 (EDT)
Message-ID: <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Sat, 03 Sep 2022 18:49:14 +0800
In-Reply-To: <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
         <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
         <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
         <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
         <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
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

On Sat, 2022-09-03 at 09:57 +0800, Youling Tang wrote:
> > > Unlike (pre-r6) MIPS, LoongArch has a complete support for PIC, and
> > > currently LoongArch toolchain always produces PIC (except, if -Wa,-ml=
a-
> > > {local,global}-with-abs or la.abs macros are used explicitly).
> > >=20
> > > So would it be easier to review and correct the uses of "la.abs" in t=
he
> > > code, and make the main kernel image a real PIE?=C2=A0 Then we can lo=
ad it
> > > everywhere w/o any need to do relocation at load time.
>=20
> At the beginning I also wanted to make the main kernel image a real PIE
> and tried it, some of the "la.abs" can be modified, but I encountered
> difficulties in modifying the=C2=A0 exception handling code part, the ker=
nel
> will not=C2=A0 boot after modification :(, I will continue to work hard t=
ry.

I just tried the same thing and get the same result :(.  Will spend
several hours reading the LoongArch manual about exception...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
