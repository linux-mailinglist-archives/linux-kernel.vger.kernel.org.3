Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493A65ACDB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiIEIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiIEIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:30:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816A4F67E;
        Mon,  5 Sep 2022 01:28:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id cu2so15623585ejb.0;
        Mon, 05 Sep 2022 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=fBxKwExxxVgmMpDYvxNQrn5B67/UQyyghykN5prSeq8=;
        b=inHbfMgTZIgBOUDJaptCo0wq+7FoQQ8NasooW79EDFVRmmAwZyvqvilU/T+4GT4dqe
         4YLAP/6G8DjULfgQmcLQuD5GXFj19UXcI7TTd0uPzrDEEQUVuevZLGDUqk1MRHMZOL8+
         tK6W622mOrorXR1Q1gLBB151bt7Ib8iHKEEE3mT5frZ8nborPY847I2nQSlHQfWVGXUy
         M+SR79FXQjGulgwNu3TCx8js4ebm1p34rdRRwg9X55rOf6hid2IKrhM3Dmo6e1Uw6Nq1
         AUvakEL5pQsTs734WAVo6m/fqJRM7QSEMxr9pIQyzTzSq4yeWpVXeoY1Ov7rZmFx22KE
         Gj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fBxKwExxxVgmMpDYvxNQrn5B67/UQyyghykN5prSeq8=;
        b=cs/vTtumrCD7ez7OtW7dw4sO7s4Tzch2LSvGsGo92JbeJx8o+NunMP7wBb9oRt2xh0
         iDf0/CtCzywo4Qc8eeYEof63QKDR1HSSrW9wUB1arlQi/wZHZT9MQWuzvJjw9+zz/vdG
         ZmkPEwSkxY8Te9BY1KtLwETxthvv8PBaZpT3F4VshToJi0BDP2FvPVQD1usZ3EGpaQIP
         o7PKad4ZR6kVZN7k7rwz/l46329hoZ8tskWmgn2kec7SKGhkRegEO4PB40wYGXTVWTWB
         5HrlqZoDTZ4Fyfd0UaaJuAIw/wKeUkfclRJhZtEbxam1F5XPTcRLNmeX5ZOw13goEHHH
         oY9g==
X-Gm-Message-State: ACgBeo1s/53czhzOSbzwkkPSa1A8Img4na3kAFTIkKwD3v3afOf4sjPb
        17+ycWj1mddQE/BV0wBl8vduZpkDSMVpFjSnBK8=
X-Google-Smtp-Source: AA6agR5Prfa9AayRAqN/Axd7Md23DbAO0HVwMolI9mDndb6iKVP7OdC4LR/QnUXC/RL1KAtpWdhKhk18CaJAaqZ5lyE=
X-Received: by 2002:a17:907:7dac:b0:739:8df9:3c16 with SMTP id
 oz44-20020a1709077dac00b007398df93c16mr34542525ejc.9.1662366508169; Mon, 05
 Sep 2022 01:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589528491.git.viresh.kumar@linaro.org> <CAJiuCceftArjKPyiEW8AnT5TtuCJFsRGGA-_8y2zG5GDTxHO4Q@mail.gmail.com>
 <CAJiuCcejjaM=+XWsmOe93idbC8TyyxLj30+Lf+5C=yv=hxT80g@mail.gmail.com>
 <CAJiuCccmVtyHbd7ZvEwmw67aesyPe=eVzSE5z_KjCC5__7brjQ@mail.gmail.com> <20220905043543.huxq7mmpclto2h7k@vireshk-i7>
In-Reply-To: <20220905043543.huxq7mmpclto2h7k@vireshk-i7>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 5 Sep 2022 10:28:16 +0200
Message-ID: <CAJiuCceTkz0c6FrGWuEb1589t6EcPoN7aC9Oe4Rxhr-4RCXU9g@mail.gmail.com>
Subject: Re: [PATCH 0/2] opp: core: add regulators enable and disable
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     k.konieczny@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Viresh,

On Mon, 5 Sept 2022 at 06:35, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-09-22, 22:35, Cl=C3=A9ment P=C3=A9ron wrote:
> > Today, I compiled my kernel without any program requiring GPU
> > computing at boot. This makes the dev_pm_opp_set_rate() to never be
> > called and so the regulator is not enabled before the regulator
> > framework switches off all the regulators that haven't been enabled.
> >
> > Unfortunately switching off the GPU regulator makes my board hang..
>
> Why does the board hang? I mean the kernel should boot fine with the
> GPU disabled, isn't it ? Or is the regulator shared with some other
> critical resource, or something else.

The regulator is dedicated to the GPU and the board could certainly
run without GPU, the issue is that the driver (here panfrost) may do
some regular access to GPU memory (I suppose).

>
> > I'm not sure what is the best approach to fix this.
> >
> > Is it required that the dev_pm_opp_set_rate() must be called one time
> > at the GPU driver init?
>
> Right now, Yes. And it looks like the right approach as well.
>
> > Panfost already calls devfreq_recommended_opp() and dev_pm_opp_put()
> > but that doesn't trigger dev_pm_opp_set_rate().
>
> Can you also point to your code ? Which file are you working on ?

The code I'm pointing is panfrost_devfreq_init() in
drivers/gpu/drm/panfrost/panfrost_devfreq.c

Regards,
Clement

>
> --
> viresh
