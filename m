Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D194EBBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiC3HgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbiC3HgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:36:13 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E4B21BC63
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:34:24 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6F62F40005;
        Wed, 30 Mar 2022 07:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648625663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xPfgkZOladdR15a2MCEBT2OjHxKiQBCr7V4GEPMOqvk=;
        b=U8eQk5w0WGhtwLRrHpCp6JCQUXsSbioy5hz+rAXIEeHtF0TA6YOOBeHZmp9QGww1Hy9dkP
        7me1P2rZjd2pPSPTsAVdkITS0xHSgYmJRDnpPFHeQ2m3/UycwmDWBanRJpUboTz/mCGNvh
        8BLdR2T0nQtDzLZmm0+FJdRlFZPs/aRJwSURDKM/CEn7fbiTEJEN39X/jn63hYU8LUZEk8
        65TkfTkog5/rVgERANVqI2KWw4AyejfouMUb0uJ2pnNimGg2Ljs8jcUfd25WQvtY58dQvk
        wrJIqkbuplWEKpatpSeEctHp0H0g9154m6c0hCDqamHWG+6HwxDUdqtdr9jfZw==
Date:   Wed, 30 Mar 2022 09:34:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Create a proper header for the saved mtdoops.
Message-ID: <20220330093421.35de104d@xps13>
In-Reply-To: <20220329225328.396209-1-jmeurin@google.com>
References: <20220329225328.396209-1-jmeurin@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Marc,

jmeurin@google.com wrote on Tue, 29 Mar 2022 15:53:28 -0700:

> Avoid a panic if the header size changes.
> Add a timestamp to the oops header.
>=20
> Tested:
> Triggered panic saved correctly:
> xxd -l 0x20 -s 0x0000 /dev/mtdblock1
> 00000000: 0100 0000 005e 005d 935d 4117 c5bf df16  .....^.].]A.....
> 00000010: 3c36 3e5b 2020 3133 392e 3938 3039 3533  <6>[  139.980953

Your previous patchset was not applied because I requested several
changes, yet you seem not to have taken them into account. For the
record:

	Can you please send a v2 with:
	- Your two patches in the same series (formatted with
	  git-format-patch to get the dependency/order right)
	- In the other commit, drop the reference pointing to (I
	  believe) a commit hash that is local to your tree only.
	- Use the right prefix ("mtd: mtdoops:").

If you are fixing something different then create another patch in this
series, but please keep you changes atomic and well separated, include
a changelog and use proper subject prefixes.

Thanks,
Miqu=C3=A8l

