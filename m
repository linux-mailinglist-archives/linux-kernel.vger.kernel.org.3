Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192D9510C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355844AbiDZW36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355813AbiDZW34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:29:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475777DE11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:26:47 -0700 (PDT)
Received: from mail-yw1-f177.google.com ([209.85.128.177]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXXdn-1nN66M1Ct5-00YyZH for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022
 00:26:45 +0200
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ef5380669cso198016107b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:26:45 -0700 (PDT)
X-Gm-Message-State: AOAM532DDSvd+pArRptjLpf+1PWfhxKZcxEk/EYnli7N/6GP2Z/vOw6V
        qGxok+MjMOWuWvQ98bzsBkJaLid4tPFIeVCUdkk=
X-Google-Smtp-Source: ABdhPJyC0LoJVNwBAD4ynQWDeVjHEA5B8GtrMZ9XSvaUD6FA2vbbZNGwJPehjny6QhUEkNHAItWM3zedUmoHsTkgLY8=
X-Received: by 2002:a81:2305:0:b0:2f7:dadb:2162 with SMTP id
 j5-20020a812305000000b002f7dadb2162mr13216162ywj.42.1651012004174; Tue, 26
 Apr 2022 15:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220421192132.109954-1-nick.hawkins@hpe.com> <20220421192132.109954-5-nick.hawkins@hpe.com>
 <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com>
 <CACRpkdbJ1N7VOgoBzGS+cOaErFcYiOVDeWRmhPyHA7=9W0CGhA@mail.gmail.com>
 <CAK8P3a2ie8kFYstCYr6FO6+yFw7VxyJjWYyy9b+rUHu_u0YXPg@mail.gmail.com>
 <YmhmXl5IWHmKzAyG@robh.at.kernel.org> <CAK8P3a3+TGSJgJ2-mgj+NjT3k8uuUpesLErwqZ2M_dkNqbMXXQ@mail.gmail.com>
 <CAL_JsqKqB+Fas1NOmAq+ocG8KY6ugOiZ_o6e9=5unzf5-ku5Ag@mail.gmail.com>
In-Reply-To: <CAL_JsqKqB+Fas1NOmAq+ocG8KY6ugOiZ_o6e9=5unzf5-ku5Ag@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 00:26:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15eWvt9hWx66iR-qtxYOrYHNJhpvnfqh=j+nLOfOSE8Q@mail.gmail.com>
Message-ID: <CAK8P3a15eWvt9hWx66iR-qtxYOrYHNJhpvnfqh=j+nLOfOSE8Q@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rUf6Z4Z/hx/hOzQin44sweuaJ/d4jnBc6uCunziubD4b3wkJ2bj
 RaCfD7y1YF/BsjrpNi224FhtS6EuYslcHcexoj7ThaG1WdW4nvvFTBvSq+hdv7jxhZPqV9b
 FUBvMHYegddMxhSpdsz4fSknFb2QOAMzBWG4DPrFXDM+tx62k8ZsCN6HlglD9Mw7/jFqXyk
 XvcZtkv3I8pO3Ne0hfUyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hXiK/uJ26P8=:VY+GRjYmbta64TGdOj8zuo
 CyBiUW+KxB/Fi2vldtyHITECw4NLaqxuJJTwQTb0VBwVhMFZcc0ANRw3wcXMCtcZSdm3+Qf3C
 ii/i4U3QaOfFZ53Spamn2A7yX1y1Z52ftRLBMzrsHqfczV3ZY4nK/JN9d+n+rkdYoy15lClV1
 yVpnS1PS3MUnuQXRt2J4urJB0/2txfIlT4RdCQhAXUk2y8y666fECUST5qv/jUvu/UGT+Y7Gd
 3Lb42XuaZ+l5vX9exHYdDKI1EimYgk+hDiXoyapbWDB65YHV5Wj3aGG5fN7woXDZAh5Ng4Hrv
 ZTuS10ntjDJjTTxwLRanrk4yVV9QARubrFvcCxwUq3x0jWoQLQqUo6nLcHbuncAcSE02VigBZ
 yiTFYw1wwVEr7LVMUxuJMMA+xZKKjgWn4BPzUS43GVOPxNBsaRtN8KI7LEVZOxs6vUJTAaAhB
 ZJuElLfkDQgxo5Lzttt64gc5JZZLIZ1AqdsU880MEFLlq6+RoEgAUOXgYaoDpxX2b/BnqHjAl
 5ws3+Mx5432Yfp6aTvh+ss+rd28OWKQkiHjM+uqQ2gzBMMhX3IQE2lzvfjUIraP3eBYoQl7Hx
 uDqxRLVunLfOqiIr5hI4rfij9TH8GUzlOMfSWJei9YLoslEl5Xj5uLyZF2ueg22QfFUBpwz4b
 3ui8W/MLZ2jb2eNf1rKV8hkuipWbhspfOPsKcPbijoM0HH69pQg8V8Xd0fvkk1vAfVExIyrEX
 MK0vL4QJ79iLpBW9G1xJNJ3dLLPOtOMX6Sgjol/sRfnfYTXaoUL11n/J8+Ym9NoXL+ZAhAueF
 vm4kkcgSLKfPLZIZE3Jpkf/Bh0RGpuOQS5Zlcyatpt+vdzA7qU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:04 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 26, 2022 at 4:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Apr 26, 2022 at 11:38 PM Rob Herring <robh@kernel.org> wrote:
> > > On Tue, Apr 26, 2022 at 08:00:20AM +0200, Arnd Bergmann wrote:
> > > > On Mon, Apr 25, 2022 at 10:38 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > > > There are multiple ways of doing this that we already discussed
> > > > in the thread. The easiest is probably to have a child node without
> > > > custom registers in the DT and then use the DT helpers to
> > > > populate the linux devices with the correct data.
> > >
> > > I think that's what the wdt binding is doing, but I don't like that.
> > > Maybe it's not a child node, I can't tell.
> > >
> > > Bindings should not be decided on the *current* driver split on one
> > > particular OS. This looks like 1 block, so 1 node.
> >
> > Fair enough.
> >
> > > If that doesn't work well or easy for Linux, then we should fix Linux.
> >
> > Doing a simple platform_device_create_pdata() should work fine here,
> > the only problem that might exist is if the wdt driver needs access to
> > DT properties, as we can't have both devices refer to the same of_node
> > pointer,
>
> Why not? There's even a struct device flag for that.

Ah, I forgot about ->of_node_reused, that should work then if
it needs access to properties.

        Arnd
