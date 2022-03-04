Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D168B4CD7B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiCDPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCDPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:25:00 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4CB13CEC8;
        Fri,  4 Mar 2022 07:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646407266;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=iydpsxlqKvojZxVmQ+MKhSxoSNJSi4/DgREzlOtxnDw=;
    b=kPuasbmu2U9a6yMquE2iIjluL4PJuVX7Je3Y+inB7TkcN/OwrU9aGMv0y5OHwUvQ5X
    N1ZMoowNU27ZWZZCPTPVioa/ZsLHS+hC/0KE46lWsERaLbbqV8zLf5+Inv1ct9vyUn7E
    Vr8pPj/f/BgjIru+NLCIALZdSWXKmCj/CJ7u3Sm4yqdmsF+/vc8WYwj+sWq7wHIZXV4+
    /moilriNtV7tdN0bhGYYmwHdSc4vw3QzEbIyTOf0sAgBsZHMJ7zrDP/FKyFbZav+SnKp
    +kwQC1gq48hf294QzuIQAsdx8EUWt+3ryLBxFGStI610o/GLhXJIAbuZOD//mHDwvNi+
    7Nkw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3i8QUWw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey24FL66sy
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 4 Mar 2022 16:21:06 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [BUG]: musb broken since v5.17-rc1 on gta04 (omap3 / dm3730) -
 cf081d009c44 ("usb: musb: Set the DT node on the child device")
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <Yg9XNBlOtwBamDm/@atomide.com>
Date:   Fri, 4 Mar 2022 16:21:05 +0100
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <129B01FB-DF3E-47E6-9B50-020CC347C00A@goldelico.com>
References: <F24D461D-8103-456E-AD28-1AA9D5C2AA3D@goldelico.com>
 <D26EF7C8-5264-456F-88FC-1B55AB83AAED@goldelico.com>
 <Yg9XNBlOtwBamDm/@atomide.com>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rub,
any news on this bug?

> Am 18.02.2022 um 09:22 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [220215 06:40]:
>> Hi Rob or Tony,
>> any insights or fixes?
>>=20
>> At the moment we have simply reverted cf081d009c44 in the Letux =
distro kernels.
>=20
> Yeah this probably should be reverted unless Rob has better solution
> available.

BR and thanks,
Nikolaus

