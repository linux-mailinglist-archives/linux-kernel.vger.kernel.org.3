Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D658C7FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbiHHL44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiHHL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:56:53 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E4F69
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:56:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i24so6181648qkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=I/75TpkbZ6XDpv6/wNFc3lTFUiVKALHDquCwrMLnaDg=;
        b=LkxwQXboTqVXtqWNcaU9mIdQs1h7wEf6onGFowGEjNdr1uWV3v2aLlQxkwupS5F5p8
         /Zd1qzI6Zo0IWhEagP9egYnYox/EgRWic1fk9/2N6o3p11Ij7+UFpr+vKVOKDh7V9cJO
         7Lqn+zLrm/+4KbH/St8FOr/99X7Sh0o0eEctWhyL0LTduyKF8Ob07vf7jt0HBg2sLvTW
         tE/qxq8vW9kpF3yu1AzxnU3DRc8WBIXrLtJvpx/VHkgyCBlEIfIohnJCrmIXW2h3VoHW
         NidJxm/MksjQ92cS00waw1SDorJZyPAAhOqWJ2BymZ8guBUxV9lNdg8u2AyX+wgbtynJ
         FJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=I/75TpkbZ6XDpv6/wNFc3lTFUiVKALHDquCwrMLnaDg=;
        b=YYkCb7WAbIQw0yr8VVlVGUiFJ6Eo7Pg9Wd9bBUKaTD/eTXrmM+8tEnk2FLAcCuGRz5
         fS70EWTBoqNwPiTo7c1QBP91DZZLL5s2ppQrQPoHe1Z/BNONjMBLjyMK9NY0WfD00DfN
         guvS6t2+eLV80gx+Nc7dO2Pv0sXQYmQ0c8uGMOTNZ8P1wUTOBwIXfAqGMakgktI5pGWM
         G/QgwD7B2r4HqgkUxCO1WFEWUSmVDLzNWbyNUx8oHJSuy5A41SqroHZISxXz7CfkOnqH
         DiUz6XO15FJEI1u7pui5hTd3Vn3pBZqhXxfh3EXKDA1ExtZbmAE3Ag9NFUiIuBVhflY0
         TxPQ==
X-Gm-Message-State: ACgBeo1KHbzNl4LORI3PgwTeoVrFn5+Li1SvSOE0tDbs2oylndCi0G1c
        N/GnuDbEWDqQrPFfMRtaXYP2W1PCxzrKp4DiyM4=
X-Google-Smtp-Source: AA6agR7l7SyhLJhFUqkhgLLjruicp7s9CaETdvHkbgHmQb1oPhIFXfXHuviv3BKsL26xqgPcj2Cgxpfd5oVD617UVQM=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr13636315qko.383.1659959811664; Mon, 08
 Aug 2022 04:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220807145247.46107-1-paul@crapouillou.net> <20220807145247.46107-12-paul@crapouillou.net>
 <CAHp75Vf1jfgshfw1ymXu9AHrNy1SUmVRDvDLUYbYKFSrhQq44A@mail.gmail.com> <RO59GR.D1GGMPYPNKQG2@crapouillou.net>
In-Reply-To: <RO59GR.D1GGMPYPNKQG2@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:56:14 +0200
Message-ID: <CAHp75VdJaJdpvGp5v-5r77RWpkGnx06J0x=Dmeyt=R8JGBDgYQ@mail.gmail.com>
Subject: Re: [PATCH 11/28] mfd: intel_soc_pmic: Remove #ifdef guards for PM
 related functions
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 7, 2022 at 5:58 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le dim., ao=C3=BBt 7 2022 at 17:50:32 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Sun, Aug 7, 2022 at 4:53 PM Paul Cercueil <paul@crapouillou.net>
> > wrote:

...

> >>  The advantage is then that these functions are now always compiled
> >
> > is that
>
> I think that what I wrote is proper English.

Okay, Google just shows 100x times less the above form in comparison
to one w/o "then".

> >>  independently of any Kconfig option, and thanks to that bugs and
> >>  regressions are easier to catch.

...

> > 3. The PMIC core actually is Crystal Cove driver and I have a pending
> > series for that and I guess you know about it. Have you seen what have
> > been done there?
>
> No, I didn't know. I guess Lee can skip my patch 11/28 then.

I probably memorized the name of a guy, who sent a patch against this
driver a week ago or so, wrongly. Sorry for that.

--=20
With Best Regards,
Andy Shevchenko
