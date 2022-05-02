Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3744516C11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383777AbiEBIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379416AbiEBIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:35:19 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B7717E34;
        Mon,  2 May 2022 01:31:50 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id m203so6292695vke.13;
        Mon, 02 May 2022 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5HWI4254BBHShrpKw5neUtGGx1uLsGyO5ZwXQexHpYA=;
        b=pOeF7MCxIVNJKO2BmcvmZk79K6BrKVWiOC2WjtLlhKS6ZDXaK/Wt+kWEFSQdWRfdGL
         s+zReY7JFsow1XbegAVwSCyYWaLAZ8+9LRVGXOyM4BXPPDl9I37fuI6WNrRtpyQwBS+K
         PT0j8fbkCuHfWOJiXOYragv0OjQnpWJ/r+/b/CQMWbwX1HpoPIHfovKtSWzT/ypICC1O
         Yn2kG2SzwZ+Pvg1IGU3zF9axza8wGl8FGrt7krjwLiukh0SMELT9h3Bv7tSpw9eKldsx
         XKgyygXtAAJABCBku769+m8uCT1pZixCV9Wl3c4O8Avp8QEShevUPW57ZauD2hb8BSfn
         MrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5HWI4254BBHShrpKw5neUtGGx1uLsGyO5ZwXQexHpYA=;
        b=PBFFbI1p0rfOgVRRNla3D0I4d4Fxaru4QN0CCgFO+xIlIjFknkjCdDUb7WoTaSd8pd
         ATMNNrcG+NO53BmXEJmudL+eIrXgKKhMPpPIx3AYICmcdvbUBORfTNbChDqHPY4hkOu0
         AJ9ffjPM6o9qHF/fpB6bc7jHFdlI0uEaUwhBSJJDhZCBm8Qg0em95MXkLX5fcDxtqueM
         uxu4G67qU/3cTVfS+Bvia64JiyOnoKa+Fi3faoNm4g/i8/bZPRgfUyxXq9vZdV8nP8hp
         Qj3vcLnPM9O8t7ujzcq/p0/U6SV5gvnKccsfyJY9kmLxoBINFOlURxscEsiyiWZZeAUx
         h4HA==
X-Gm-Message-State: AOAM5319Fi8kRj9yZvwMvo+j5P9vXyAT2KBgqLE5XcV7jHG6B5YNr1gn
        Se+FL3dlw5N9PztJn3is+Mds0wWGfIe3nYmhBO4=
X-Google-Smtp-Source: ABdhPJzsnMpCsc5i6aZSLB6vvRl55FU/ENMWobvYgDjzcrAZmugbx+OEEZmj9mp9E4pNt2gwTtgOWLN61E+ktyrBBb8=
X-Received: by 2002:a1f:2944:0:b0:34e:249b:5773 with SMTP id
 p65-20020a1f2944000000b0034e249b5773mr2875414vkp.18.1651480309611; Mon, 02
 May 2022 01:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com>
 <CAHp75VcoXu=0yvxmTwGAzexV_MgACXg-Cufkigt_kCEvbnwq_Q@mail.gmail.com>
 <20220501180303.75a0d0a5@jic23-huawei> <CAN8YU5PYkQhqrGP8qUK6BgVWVWWECQvYGrSiREU7P5r4kFxVjA@mail.gmail.com>
 <CAHp75VcFZYyU0ap8WSBCTTpsUtDmC6TqURLOpAOKxYNtbLHAOg@mail.gmail.com>
In-Reply-To: <CAHp75VcFZYyU0ap8WSBCTTpsUtDmC6TqURLOpAOKxYNtbLHAOg@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 2 May 2022 10:31:38 +0200
Message-ID: <CAN8YU5Peo8vi0MUqP2hSkKFyO=uAxx_Ad3aXRKBr3zzncS8RPQ@mail.gmail.com>
Subject: Re: [v5 00/14] Add support for Bosch BNO055 IMU
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno lun 2 mag 2022 alle ore 09:48 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>

[ .. ]

> > BTW I have also gone through some kernel-robot reports; they also
> > state "If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>". I'd say that it would
> > be OK to add this tag to a patch that just fixes what is reported, but
> > I'm unsure whether it is appropriate to add this tag to the patches in
> > my series, because they add the code and the fix at once. Any advice
> > here?
>
> For this we specifically amended the kernel documentation recently.
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
>
> "The tag is intended for bugs; please do not use it to credit feature requests."

Well, no any feature request to credit here; a bug and its fix are
involved. Sounds more like a "yes" so far.. But it wouldn't be clear
what the robot did report indeed (squashed bugs and fixes).. Maybe a
"thank" in the cover letter also to it would suffice?

> --
> With Best Regards,
> Andy Shevchenko
