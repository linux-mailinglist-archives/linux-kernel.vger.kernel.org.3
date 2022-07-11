Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1145701EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiGKMVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiGKMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:21:20 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E16237DD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:21:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f73so8371873yba.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pUxrxpUjUFmLyDY1V3CLpLLNDP18yhbWZiMIrY81H5w=;
        b=SwJWULW2UYS5nEUkB1Cob6FGI6aQytZXpEsqXW8W+LHXHOe7MAd1hc6xOfgSY/vfWO
         tAMNZVzSf6QEvXL14yHwwWx6dTdhDQI667Nj9SFRUe9qOsA0ILvk8MT9LmhV2JAXwX5d
         Jv7n4ntciIuR6aF/aYZp0AJmQiClt6q1Rtb6rZUH077pn73NAl9/vacboLq6C2G8Oxyv
         E2aSuKX7XJDNavS0gTtVA3ExJ6gz7g3yAX3ijfzNJlA8bHqvnNXWz4jp88KArf9ki8/7
         AmgxBqizt656+MeKfxXMYHuye6QbU01/4ukdIPvjrJJQXL+/RcCOYnhS0sMpuL1NPcXX
         SeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pUxrxpUjUFmLyDY1V3CLpLLNDP18yhbWZiMIrY81H5w=;
        b=iDsXSHg9jmU/SpTGgrGnvVuDsGLQQAK41uJ3VCFvRtC3qxGu36Dw75jhBnPXVHL4GF
         ne4OXRb0/qiaVfdBP97EsIOSOsaKc0y2KpmmG6Jv9dz0bolwDUNNWiaYmELCOQakS5Lp
         JxufQSqCeuLC8d6jFqYMpifaMvpgV9EtBYAEl7crIFbmHsbLyBVttp5cT18JJ8usFvZs
         T1b3kbAC+c2Zv6gxKBZYQyvgtueqJHXYJBuUfbQ1G11la2DZniuOka0zxyfjdXTfdQT0
         0bLPyKyP+QPffqWWjQlvkU+6CpTCBB10of1fYIUHNhh75N9SdpmjG0JcnwMhtN+uhBrW
         FX/Q==
X-Gm-Message-State: AJIora+CZkJILzBPKk3dsa1K9peAdWOZbsgLGmMaP7sWHmSu5dJ+pZ5k
        0kf0JzRLHz2lvwGoLDj75yQNJosO7ZRMQB6bA5bRgg==
X-Google-Smtp-Source: AGRyM1tqEYOmvyScyatWwsrIE6YA5aA/tithH+KVOt3I+PnDl3LACHGSx/w5iqX6VeZ0ThP+lVoZlMjZdNgaVNmLqCE=
X-Received: by 2002:a25:e00f:0:b0:66e:2aa9:82b1 with SMTP id
 x15-20020a25e00f000000b0066e2aa982b1mr16643367ybg.626.1657542078246; Mon, 11
 Jul 2022 05:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220706112828.27278-1-pali@kernel.org> <20220706162111.GA145516-robh@kernel.org>
 <20220706162335.2eewgf7l3xghdjtr@pali> <CACRpkdYncdsVW8LysQ3--rOF-KUF6dkkPyX4tg4e10vn2K+8FQ@mail.gmail.com>
 <20220711121006.kjk44rubi5gpqycj@pali>
In-Reply-To: <20220711121006.kjk44rubi5gpqycj@pali>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 14:21:07 +0200
Message-ID: <CACRpkdYQvqB7FzfQ4Yf2m-QFz_6inEFvMs_NjJmRg3BeA-O6Wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add value property
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 2:10 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Monday 11 July 2022 14:06:50 Linus Walleij wrote:
> > On Wed, Jul 6, 2022 at 6:23 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > On Wednesday 06 July 2022 10:21:11 Rob Herring wrote:
> > > > On Wed, Jul 06, 2022 at 01:28:27PM +0200, Pali Roh=C3=A1r wrote:
> > > > > Allow to define inverted logic (0 - enable LED, 1 - disable LED) =
via value
> > > > > property. This property name is already used by other syscon driv=
ers, e.g.
> > > > > syscon-reboot.
> > > >
> > > > Yes, but those are potentially multi-bit values. This is a single b=
it
> > > > value, and the only value that's ever needed is 0. Why not just use
> > > > 'active-low' here?
> > >
> > > Just because to have uniform definitions across more syscon nodes.
> >
> > But what happens if he mask and value don't line up?
> >
> > mask =3D 0x10;
> > value =3D 0x08;
>
> Same what would happen in other drivers, no?
>
> Only those value bits are take into account which are also sets in the ma=
sk.

Two wrongs does not make one right. I.e. just because this bad
pattern is used in other syscon drivers we do not need to repeat their
mistakes. Also, in this case we can only specify one bit due to the
way the enum is designed, other drivers may specify multiple bits.

This also becomes a bit confusing:

+    enum:
+      [ 0x0,

What you do is add 0 at the beginning of the enum but that represent
a low bit of any from 0-31. I just get confused, active-low is crystal clea=
r.

Yours,
Linus Walleij
