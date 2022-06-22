Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D2C554A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbiFVMds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiFVMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:33:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C42D1055E;
        Wed, 22 Jun 2022 05:33:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1DD7BDD;
        Wed, 22 Jun 2022 14:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655901204;
        bh=pwLY49vqQCivbqlA7ZAkrkwfDtnJLPJn+P8i52ypG4I=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=hh7D5akfSUnKrOvq6kxCeHj9vLCoOBVj9Ie15gSLyDOd6ta7qIFKhV3Rxh5qLzfpE
         QxUIqh9sXNMTcYAclIhOKEjpjAIPoC246MAsYCxRm71j8DlsbVystF/nVP8alpf8YQ
         gyDc8YAS3kcD8AaGqjBwQCun5Nyl19idibuDYX28=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com> <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com> <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org,
        =?utf-8?b?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Wed, 22 Jun 2022 13:33:21 +0100
Message-ID: <165590120140.1149771.2257818527859865760@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YongSu Yoo,

Quoting =EC=9C=A0=EC=9A=A9=EC=88=98 (2022-06-22 12:39:20)
> Dear Alls
>=20
> How is my kernel modification going ?
> Can you check my kernel modification ?
> and give me the feedback ?

Your patch needs to be sent inline, not as an attachement. It has a
wrong mime type or such so I haven't even been able to open it yet.


There should be helpful information in:
 https://www.kernel.org/doc/html/latest/process/submitting-patches.html

--
Kieran

>=20
> 2022=EB=85=84 6=EC=9B=94 1=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:54, =
=EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
> >
> > Dear Alls
> >
> > Can you check the Below E-mail ?
> > Can you share how is the below patch going ?
> >
> > ---------- Forwarded message ---------
> > =EB=B3=B4=EB=82=B8=EC=82=AC=EB=9E=8C: =EC=9C=A0=EC=9A=A9=EC=88=98 <yong=
suyoo0215@gmail.com>
> > Date: 2022=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=
=84 3:36
> > Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
> > To: <mchehab@kernel.org>
> > Cc: <0215yys@hanmail.net>, <yongsu.yoo@lge.com>, =EC=9C=A0=EC=9A=A9=EC=
=88=98 <yongsuyoo0215@gmail.com>
> >
> >
> > Dear Mauro Carvalho Chehab
> > My name is YongSu Yoo
> >
> > I found an incorrect logic at the function of dvb_ringbuffer_pkt_next in
> > /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c.
> > I correct the bug like the attached file (
> > 0001-media-dvb_ringbuffer-Fix-a-bug-in-dvb_ringbuffer.c.patch ).
> > Please check the attached file.
> >
> > Thank you
