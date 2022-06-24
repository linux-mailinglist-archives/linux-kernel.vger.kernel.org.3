Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D5559A57
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiFXN2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiFXN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:28:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7EE47380
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:28:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so2327946wmr.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=Gd55QfDzv4tOkcKv6ZabSHGL0FEPuSK9T90juIUO+zc=;
        b=BCGA35h351Jaf+cfGzozM71rulqxQsXze+AyxTGMiJVxUxSrMl/Y9ZFfBuIIWcq0yX
         FmEZ8Juhqx/DUHMleUckAUd2jvb2I/NHIACEhb6mX4+AQataDFBIfuzZ+Ut0eKd9oiDG
         xxYkSJ3jvVAtTRyWrN9DcVXLkl83WQaezIQdDTI/vg6BmQBFizY2tNKJMZkDIlw99fTw
         SJDroRWYMKCZ/j75RcBPuKHpYpjd9gY50F8iIzKkM0Ytb4EUW+NaIIT1mAm9zkueJd/e
         jLU2RJNWazy4YG7YifdvKrJglgZZzJmJHpfpEhyiWQ+dV77l56WUlLWEuF3S9taUNmjL
         RUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=Gd55QfDzv4tOkcKv6ZabSHGL0FEPuSK9T90juIUO+zc=;
        b=AtEhs/z3nTxHNduCWhbav5wTEU70nxgjiZRqJYLw4Da7BwF6oh+bgd51nxMVYxouNH
         SLv6jHyongO5+4pEU8uMZFlbz0Rz87SdGRFDpKcMwF7eGQIPnRBwxEeTB3PYYoy4qbTU
         0yWjSrholCPRlpLfUTQK27iuJg3REP86kax2jYA5mJPiG/fveIBZUS3FZ4ugSumpaAnb
         5Nm7id3dbLwIfzGUkMT35SbGaaVUaoQ7IIA6QZ/MhsC4M6W4GWAuqXvNgzM6EOq/oSG2
         YukRWVzdbp6E2BnAQd5nPt1h6t7Ed4lKx6BF5V9GbInP9xnF/vODzFUskoqrQ3ts/r20
         pnGQ==
X-Gm-Message-State: AJIora+yQKx5auGlWb9p6hM5ANvUMp1RiXqBtRNtUfflI3izXMVEABVb
        PQOJDHErV5p61DOLNKG7sX+WU6btQlo=
X-Google-Smtp-Source: AGRyM1sHvdVItzUrt2JZHsnrGhrRpPLAdzo0enpSeBT9VOYJxU4BIp36RCr4fgUD7lxNiTsnJOUWoQ==
X-Received: by 2002:a05:600c:3847:b0:39c:6a85:d20c with SMTP id s7-20020a05600c384700b0039c6a85d20cmr3941925wmr.129.1656077305705;
        Fri, 24 Jun 2022 06:28:25 -0700 (PDT)
Received: from localhost (92.40.168.222.threembb.co.uk. [92.40.168.222])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d6343000000b0021a36955493sm2250278wrw.74.2022.06.24.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 06:28:25 -0700 (PDT)
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
 <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
 <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
 <YrWqAqGUuy8Z0F3x@sirena.org.uk>
 <4937c0cc9dbc9d06cb626465bd37cbcf76c80a0b.camel@perches.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned
 int
Date:   Fri, 24 Jun 2022 14:05:30 +0100
In-reply-to: <4937c0cc9dbc9d06cb626465bd37cbcf76c80a0b.camel@perches.com>
Message-ID: <Z2ggoG49naOiT1BMxPbsMc2zOjAUEnha@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joe Perches <joe@perches.com> writes:

> On Fri, 2022-06-24 at 13:11 +0100, Mark Brown wrote:
>> On Thu, Jun 23, 2022 at 11:26:10PM +0200, Andy Shevchenko wrote:
>> > On Thu, Jun 23, 2022 at 11:13 PM Aidan MacDonald
>> 
>> > > Use 'unsigned int' for bitfields for consistency with most other
>> > > kernel code.
>> 
>> > There is no point to convert the fields you are about to remove.
>> 
>> > So, either don't touch them or make this patch closer to the end of the series.
>> 
>> It costs us nothing to convert them, this isn't a difficult or hard to
>> understand refactoring - the patch is fine the way it is.
>
> Modulo the defects that might be introduced if an overflow occurs.
>
> struct foo {
> 	unsigned int a:1;
> 	bool b:1;
> }
>
> Assign a non-zero int without bit 0 set to each and see if
> a and b differ.

Bool permits implicit pointer-to-bool conversions, so it isn't free
of pitfalls either. Overflow is probably more dangerous in general,
but here there's little chance of pointers or overflow getting involved.
These are const flags that describe properties of the hardware, nothing
should change them once the irq chip is created, and the vast majority
of chips are static const.
