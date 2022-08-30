Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843925A6B48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiH3Rw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiH3RwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:52:05 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE7A6165
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:48:37 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id t15-20020a4a96cf000000b0044e0142ec24so834713ooi.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QOHQdT3OVUHpaukm+t85KBAiboEat0T162RdVG0MMRc=;
        b=ic2UsMvdh43Vh89r7gu68/5vS8Gc7ct2j4Rov7GrexcQ9s16/wXTD1ymMp1y6SR3aV
         Jh2sexQ5LADumerYJDxpJk0EJ1AiZ07QkeB0n6zBSGwAqDJGm1oQ20+7KRjGiYxY65VP
         0hcbTfHGfgIbtrWpk7s6DgceZhnxQc8Z/b2b/KDIdabS2V/wIYca0xqNKhksoli2+BJj
         ZINYb9N1UkQ418SNClE0gKC2YGQfAl8IvArpO5hk9t6Az5FYaP1sxl/UMPJZcIHVoO27
         GiDt6a72zGXNlCEyx0Dejn0NzQbRW9luawE9d9riQwmoNMDdCdkIwdslQEMyt6W1yNq1
         buww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QOHQdT3OVUHpaukm+t85KBAiboEat0T162RdVG0MMRc=;
        b=afqbxBsG4Jupw+pX7Uj1r8ur7nM0w/OJlqnzkN16Nnyd8iF3yb4sbchYBRpK6TMmjX
         Ec/ACaI7h3ahVILWuBTAnT0vctR3lE/uAEMFTnFrDen5mGaxQ+8zmglwd56A3ooTQBkP
         khBPt6+4SBAvsv0Ks6GS1S03AV2owpHRI/xpEMD8bSu+XN2z/Vvw/+VoRyOmKuIjl3eb
         AGGPAa/NkkwFNF4pjuoqcjcmt4u/bvXmLYPi1su8H1SyNwhJni2X8gGHIoYY2v15jl00
         oYF3LHWI7Dl+LcrYsheGIIpp4/7gRdaA1Zm3iDZ6W9O+IZMkm3pYEUT1ago2c+aqH0p5
         71dw==
X-Gm-Message-State: ACgBeo0M9aQwCqGEsOz2TA1NrVqB16raCYTrr82N5zbmMHbWNhxFX4Fp
        tk+OmEBR75hYPuMQ2kBsHxyNsYArMlbIFQ3nNSQfpnhSAnutCg==
X-Google-Smtp-Source: AA6agR5myCVhW84r+QnDSTVy/jqy/jK/lcmeHgeFWiCsfy/GwPMSD184FpXqLE+yTKCnYkkikETTKuY42+Rb2QyDVOg=
X-Received: by 2002:a0d:fd05:0:b0:329:3836:53ac with SMTP id
 n5-20020a0dfd05000000b00329383653acmr15412080ywf.455.1661880907756; Tue, 30
 Aug 2022 10:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
 <Yw3cs6wb4PvnDN/7@shell.armlinux.org.uk> <b120e94b-4b43-6d8a-a136-41417cb250cc@huawei.com>
 <Yw3hfGV4DYyJ0Gno@shell.armlinux.org.uk> <2452e7b0-d4fd-2e27-a336-bf87b85a8d50@huawei.com>
 <Yw3oR6WhM0O5LQX5@shell.armlinux.org.uk>
In-Reply-To: <Yw3oR6WhM0O5LQX5@shell.armlinux.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Aug 2022 10:34:31 -0700
Message-ID: <CAGETcx_GB-r+H96hWHfoKSZjK9hodqe-+FWh6rve0E09pz0nXA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in amba_probe()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 3:36 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Aug 30, 2022 at 06:31:14PM +0800, Leizhen (ThunderTown) wrote:
> > On 2022/8/30 18:07, Russell King (Oracle) wrote:
> > > For an amba driver, drv->bus will always be pointing at amba_bustype.
> > > That always has a "match" operation. Therefore, the default of '1'
> > > above will *never* be used for an AMBA driver.
> > >
> > > If drv->bus does not point at amba_bustype, then amba_probe() will
> > > not be called for "drv".
> > >
> > > Therefore, amba_match() must always be called before amba_probe().
> >
> > Oh, I was careless. I think it's drv->match. But the processing flow
> > will continue to go to "dev->bus->probe".
> >
> > __driver_attach():
> >         ret = driver_match_device(drv, dev);
> >         if (ret == 0) {
> >                 /* no match */
> >                 return 0;
> >         } else if (ret == -EPROBE_DEFER) {               <------no return in this branch
> >                 dev_dbg(dev, "Device match requests probe deferral\n");
> >                 dev->can_match = true;
> >                 driver_deferred_probe_add(dev);
> >         } else if (ret < 0) {
> >                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> >                 return ret;
> >         } /* ret > 0 means positive match */
> >
> >         ... ...
> >         driver_probe_device(drv, dev);
> >              ......
> >                   dev->bus->probe
>
> And that makes no sense, is an already known issue, and there is a patch
> to fix it:
>
> https://lore.kernel.org/all/20220817184026.3468620-1-isaacmanjarres@google.com/

Russell,

Thanks for discussing this further and pointing out the other fix. I
assumed Leizhen was talking about an instance of
device_driver_attach() which allows probe to be called without match.
Thankfully that function is used only by some specific
frameworks/buses types. I did a cursory check and I don't see any
intersection with we amba.

-Saravana
P.S: I hate that function exists, as it just throws a wrench in the
whole driver core design and adds corner cases to a lot of generic
driver core design.
