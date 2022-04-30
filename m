Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B311D515B12
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382325AbiD3Hvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiD3Hvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:51:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3B0BF47;
        Sat, 30 Apr 2022 00:48:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 66B8E5C0118;
        Sat, 30 Apr 2022 03:48:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 30 Apr 2022 03:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651304894; x=
        1651391294; bh=ZFpADMpNUy2riU4+N7JTWxLSuEp4zLRopZiAue0Sesg=; b=F
        5lrgzGcuMx9mm60H01rA02mgRiyjGEBznrdLP+7DEcGxzkKrEVmiGO6Rfkb9TbPd
        RNkVkck9BWGiLhmhs/nysWJdbZ+phTZ+pgVKoJ8o9bz4EbKSQ4wyxi87nl5ndt8v
        eTQLIqdUqV1YdG/esSlrFEup2B8uT678ZunOuzoOTq6SilK6IO7TegkeNTgsdYxL
        LfW/33m2bHQS5Xvg/JHAsUQwj/xdfqSKcjTALUqiuEcJCz7mSv2VXN5GTcxnEOT6
        cdzBpTzphV93/3VFkxvrLZYPU+GCnPAE3jkgT1IkiiOLn4XGUlhEMstusZKwXVlY
        rR5Jyef7bofb8kS6GTmSA==
X-ME-Sender: <xms:velsYlBw3Xt7nn5a_BDYeEKDz9DanKYo3V_BJGs3yvyd-YR9PSak-g>
    <xme:velsYjjO5uFDCmt4bGUcgWqe4GhdgAGjCDEXZK_8UErxUR6TagYHh-fFfO72ff1lX
    VPBgRAkSRXIDLBC1N0>
X-ME-Received: <xmr:velsYgl2jC98YL9hNRTFGjC2RX4AwpyKvu1tLe5AmjvKBsnaX_qnimi5goHy9V69EMZUGuzhlQsYIUcDgMAO5SOVC_1lUuC1mYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteeh
    geelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:velsYvzDCVSwQqVHOs_snB2kZpuH-9-ri8QbNnzga4LwDvbVvzoJqQ>
    <xmx:velsYqSe0P5ei0BuPcIzQZh1R7Hjor0p7SDqIbYPfONFON5SadOnvw>
    <xmx:velsYiaAceUm1vNUAoi9uaPoaAhgloYAX2OpiAoIWGBN3rp0EGxwSA>
    <xmx:vulsYtHyWD-AXIRk0WcCds9ejukXBUHsrL4c5ma87oi5UnsEdOrZtg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Apr 2022 03:48:10 -0400 (EDT)
Date:   Sat, 30 Apr 2022 17:48:06 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Wan Jiabing <wanjiabing@vivo.com>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@inria.fr
Subject: Re: [PATCH] scsi: elx: efct: remove unnecessary memset in efct_io
In-Reply-To: <794191df-e745-c591-bf1d-37945f96e73a@wanadoo.fr>
Message-ID: <eab847fe-8d17-1a38-b55e-e68a2f6a1829@linux-m68k.org>
References: <20220318145230.1031-1-wanjiabing@vivo.com> <794191df-e745-c591-bf1d-37945f96e73a@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-987175101-1651304886=:14454"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-987175101-1651304886=:14454
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 30 Apr 2022, Christophe JAILLET wrote:

> Le 18/03/2022 =C3=A0 15:52, Wan Jiabing a =C3=A9crit=C2=A0:
> > io->sgl is allocated by kzalloc(). The memory is set to zero.
> > It is unnecessary to call memset again.
> >=20
>=20
> Hi,
>=20
> Nitpick: this kzalloc() should be a kcalloc() to avoid an open-coded
> multiplication when computing the size to allocate.
>=20

Seems like kcalloc() conversion could be a separate patch. Perhaps it=20
could be done everywhere using a coccinelle script.
---1463811774-987175101-1651304886=:14454--
