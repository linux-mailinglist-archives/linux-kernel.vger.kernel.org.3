Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A5583EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiG1MdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiG1MdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:33:09 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B16AA24
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659011588;
        bh=wgUEdEUzAPkvfx+LCe0/REt2EPrTetdCcJc+ofCUePo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ta3w8Y0tsDh7SjVXyZkq8ly40U3v+6/wAmEnbmhOFfL6VAXQ/9B0DH7GNKJdPb3ME
         ygaVx6vI9YFG2YNuQrze2kHHEsILgyvg0YvYwzWaohrBh5Z4CBxzx1lLKAcLO3I3FB
         i73En8jDwYBrKbR+EZt2q16Ov27kat4EdFX7PezA=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 3F4FC66A59;
        Thu, 28 Jul 2022 08:33:07 -0400 (EDT)
Message-ID: <55786176319d210319d7c1b296568db14f76267e.camel@xry111.site>
Subject: Re: [PATCH 2/4] LoongArch: Support R_LARCH_SOP_PUSH_GPREL
 relocation type in kernel module
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Thu, 28 Jul 2022 20:33:05 +0800
In-Reply-To: <CAAhV-H4vurz+-jwJm4SCQeaChLkXhrPFginpzNpYX6HkcD_xqA@mail.gmail.com>
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
         <81c67c5f4c5f20fa5e6862f260884c61cafcaf93.camel@xry111.site>
         <CAAhV-H4vurz+-jwJm4SCQeaChLkXhrPFginpzNpYX6HkcD_xqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-28 at 20:30 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> Missing V2 in the title?

Yes :(.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
