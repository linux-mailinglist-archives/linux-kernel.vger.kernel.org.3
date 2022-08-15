Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAD592EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiHOMdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHOMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:32:59 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C46545
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:32:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 185C85FD05;
        Mon, 15 Aug 2022 15:32:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660566776;
        bh=z3GwWFdDU/4zDdB9yMOJ9Zyr3+xdRvGE68Qe8Uy9QYM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=YTzY75QiP9C0oQVSQU8FawhkviqP7ptmkex8uzqn8elr9tqMV5vHQ/LLVRJv/80EA
         H2vIN9RmmWBNM1wNIXxiM8t8M7SD5RBGHv3csTyZlE6uuFDk1Ex6kPu1fackjzkG1O
         ckhtehaq//soRcjek3SUcX/Zk/bSF1TkzB3KXzDf/36bEA1Al+yWJwzLMo06j9fE1u
         qHC8dViEHkTS8F2CbrJOYhWR8BTkKv4QERxpTe+hBr0CqHV/ggOjBvxpLOT0VXMxkb
         p+Qmg2U7i71E/p3kC/qOC9dbOJRzRxDQUNtuxFuVgb8k57FpJwkWFJMLNLdN6MYLaa
         cRpL3PcS739QA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 Aug 2022 15:32:54 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] zsmalloc: zs_object_copy: add clarifying comment
Thread-Topic: [PATCH v1 1/2] zsmalloc: zs_object_copy: add clarifying comment
Thread-Index: AQHYrZhN9rSILS75Fk6VO/msHKj5a62vFreAgACiEIA=
Date:   Mon, 15 Aug 2022 12:32:03 +0000
Message-ID: <20220815123249.tls7lsykendsfxts@CAB-WSD-0003100.sigma.sbrf.ru>
References: <20220811153755.16102-1-avromanov@sberdevices.ru>
 <20220811153755.16102-2-avromanov@sberdevices.ru>
 <Yvm0//iPcvbW1M55@google.com>
In-Reply-To: <Yvm0//iPcvbW1M55@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76ECBCEBE8AB1541B0F52BDFDE212327@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/15 08:42:00 #20120161
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sergey.

On Mon, Aug 15, 2022 at 11:52:47AM +0900, Sergey Senozhatsky wrote:
> On (22/08/11 18:37), Alexey Romanov wrote:
> > @@ -1564,6 +1564,12 @@ static void zs_object_copy(struct size_class *cl=
ass, unsigned long dst,
> >  		d_off +=3D size;
> >  		d_size -=3D size;
> > =20
> > +		/* Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic() calls
> > +		 * must occurs in reverse order of calls to kmap_atomic().
> > +		 * So, to call kunmap_atomic(s_addr) we should first call kunmap_ato=
mic(d_addr).
> > +		 * For more details see:
> > +		 * https://lore.kernel.org/linux-mm/5512421D.4000603@samsung.com/
> > +		 */
>=20
> I'd drop the link part, Emails are not documentation, kmap_atomic
> is documented in Documentation/mm/highmem

I'll fix it in v2 patchset, but Andrew has already merged v1 patchset
into the mm-unstable branch.

--=20
Thank you,
Alexey=
