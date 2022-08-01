Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72DE58682D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiHALfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHALf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:35:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21901186DE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:35:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy29so19727529ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hr7aEVDfPA3dYafjUV8hGRFyRDiv7hTNOFhknOQL4qo=;
        b=QXIcOzFMphH/aKPBRA3u4zzR+WbNW/9qCVgwX2WNuvFK9d5l+bHewJUlTh+f+qB6qY
         s7G8CvTLKDGcXKp4TqXEt3mpi8wxw3j/PAt4uvJIIjQCjyRqOfJzbb8K3GMbARk9SN8x
         jDtywyjzU6zGv+jojrMeq8zWN3/QqLMZMSXDOmkzKiDKBig3u8f8/COoMg4YuXs8bTll
         egDF4PQV0CFgRjGkrTAEk8JQACAVLh2tIWGru82gsj4pOZfYslq+/Y1pxtor2sQJMAuO
         zNB/Kq19cNGMYD+Doc2kQOldUynXQiVL7RnrS8lEr4jBO27BFB6L8J3hd/wz31MT8r25
         5b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hr7aEVDfPA3dYafjUV8hGRFyRDiv7hTNOFhknOQL4qo=;
        b=DUSPYn85HGtnYlPGFYY5ML3oex3e/N9ONTE5aclMuhwLx4Phh+E4/w87ugjpEIdIAd
         NGSt+nuNWO+SBw7cB4L6cc4GOT3w+Ft8m3UdV8QyNZcTuDg3nJKwx/rnI1+vz1BVX5mN
         YNgokqEaDid6XuQ5dBHvtc/T5gakj6Hx+Gi/TZhqfDuwFj86gy6I3IeLhbhsVbX3fTRw
         +MOcduYGGcDp/VKT8ZlesNuN5kCHRvqRq/CqgE45yzkqW6CJzo+0iQP7QCY+BN4ssVii
         xEOg5HGCii5YV+J/z0e8+s8RvlhsWNRwQzgDx2ecG8npOGEvN+ZAFVv5v+FWbQ9NJH2C
         +Zrw==
X-Gm-Message-State: AJIora+9wIhBhJ9ZisjOtjlyB6JN2yqrHHqyla188BBc6DsXic65ezVS
        TMBbnBsLnq8kDqPOxKkMr665oUaDe0BPd87jH+g=
X-Google-Smtp-Source: AGRyM1v/7IXHbkGZ8oYvXt89Es/sM84ol9pG6Ro+QNxlUMBkm4U2aa3aIygS5GmB2Jtv1Uxv/+UBn87PXCqP7PvBO2Y=
X-Received: by 2002:a17:907:9706:b0:72b:4b0d:86a2 with SMTP id
 jg6-20020a170907970600b0072b4b0d86a2mr11793826ejc.242.1659353723699; Mon, 01
 Aug 2022 04:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
 <9b9abdf0-7cd5-df51-adbf-2225291f0dd2@redhat.com> <CAHp75VduSG=BerPJo9phXJKWa-yu_uXbP+ifkax=3FUTE7et+Q@mail.gmail.com>
 <CAHp75VcmuVcA_heURNh96zBDtpeNvx0t9buDOxnWNoea2G1uDg@mail.gmail.com>
 <98f1509a-2386-7c8f-cf53-cdb93990aa74@redhat.com> <CAHp75VcYENL-LqJPzL4mY-cDkZ89m2MM=yRbs+_c4SjHMMvJ5g@mail.gmail.com>
 <76186bb4-63ac-857f-f9f6-d020ca44c380@redhat.com>
In-Reply-To: <76186bb4-63ac-857f-f9f6-d020ca44c380@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 13:34:47 +0200
Message-ID: <CAHp75VeN8iSog6J5Trh6WZfPm39=1H674JVX8g+P8aiyEH8bHg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mfd: intel_soc_pmic: Fix an error handling path
 in intel_soc_pmic_i2c_probe()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 12:53 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 8/1/22 12:38, Andy Shevchenko wrote:
> > On Mon, Aug 1, 2022 at 11:52 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >> On 8/1/22 11:29, Andy Shevchenko wrote:
> >>> On Mon, Aug 1, 2022 at 11:14 AM Andy Shevchenko
> >>> <andy.shevchenko@gmail.com> wrote:
> >>>> On Mon, Aug 1, 2022 at 10:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>> On 7/31/22 22:12, Andy Shevchenko wrote:
> >
> > ...
> >
> >>>>> Note alternatively we could just move the pwm_add_table() to just before the "return 0",
> >>>>> there is no strict ordering between adding the mfd devices and the pwm_add_table()
> >>>>> (the pwm device only becomes available after the pwm-driver has bound to the mfd
> >>>>> instantiated platform device which happens later).
> >>>
> >>> Just to be sure... How is it guaranteed that that happens later?
> >>
> >> Ah you are right, it could happen immediately if the driver is builtin and
> >> has already registered (if the PWM driver is a module, as it is on Fedora,
> >> then the driver will only bind once the module is loaded).
> >>
> >> Regardless there are no ordering guarantees between the probe() function of
> >> intel_soc_pmic and the consumer of the PWM device, so the consumer must
> >> be prepared to deal with the lookup not being present yet when its probe()
> >> function runs (*).
> >
> > Would be nice to have, but isn't it the issue with all lookup tables
> > so far, e.g. consumers of GPIO ones are also affected the very same
> > way?
> >
> >> *) ATM this is actually an unsolved problem and this works only because the PMIC
> >> drivers are builtin and i915, which consumes the PWM for backlight control
> >> is a module. Swapping the order does not impact this.
> >
> > Even so, I think we can't change order right now because the issue is
> > much broader.
>
> Ok, lets go with the original v2 1/10 patch then. In that case, you
> may add my:

Will do.

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> to the original v2 1/10 patch.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
