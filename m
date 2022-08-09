Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06D558DB0C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbiHIPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiHIPXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:23:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2B2101E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:23:44 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s11so2021636qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=A5REIXPZhx2QvQynwWaByU5xDx6beRgsM1q7t3M3QIc=;
        b=A2SxNph/DNpdrT9d3hveZB91fLfSAP4PkBx0flA7BTnis9Ybo6vd5+lOioDg+TZ0Ri
         UQXG2pBoHeTKCKeD415ZXXB5GWUv7NxTfeZNIK9crwiLoYhbiKX+JToa4SGqgAXWIIJc
         g26La4rUgq/xtdJNAyy0KfalOqEaD5+d4Llx1bemL99Oqk+5WARcSBiZDEI0t+vXFF04
         jFDPS6JycPQH4FYLHi944/szEz5e5Sz73adaax9pmd/4AH9NYDw9PgbxO3i4T//u0t8/
         PZ1ZBAlmtXlQsjMITCrfaxckXef1/o+lKmNcU/N7gmO39+qBPOFN05XmP4w56jgPRU1o
         V3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=A5REIXPZhx2QvQynwWaByU5xDx6beRgsM1q7t3M3QIc=;
        b=AKFe8qTgAPs4p/N40p7BUnWTbKg5Z7kxcDbnMDnFJ6EzAu98D9G240eRos+yzZDz27
         8TIRJ5pU3GnA8wS8JLDTopuF1yJHHssvIZkI0Ht8zkMwjMA7cKtenbLBZJHhLXmN4bDz
         j37zfPpGOvTL0+kZh8u/jK++HRpbvK3n6qRvWlXIa9+F5xLKMF+91ndhoEY3vYaZ7Ouv
         39yx0wwuGocHny2vMrS3BfoIWKo1kbvrFRSsABhuydxmQqeJq0hTW0Po3nLv4PxrADj3
         qyZtA0DsaH6aZUQFkIcX7Pjnpz7Nlr8TOsZOw68qOhD+RI2LrYF8mb7yaWS3URSecEPV
         QPZQ==
X-Gm-Message-State: ACgBeo2pNhNhm4pQHK+z/CHh6UEu68bkOyQsQh48+zjp9Y1Rz6HHXuzD
        mzuGAhTbKNWdKGqU5Eg0qBHkWKQJbeWDr+owWZ4=
X-Google-Smtp-Source: AA6agR5loxxYmWvOgY8IXER/onlN3o9Ts+lZi/Bv9dxls1CXuWv+Mw2vX/HgD4wWr4V10pqteJ/VYouRIQsN8BxPWUM=
X-Received: by 2002:ac8:7f88:0:b0:342:e9dc:ee77 with SMTP id
 z8-20020ac87f88000000b00342e9dcee77mr14870523qtj.384.1660058623938; Tue, 09
 Aug 2022 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com> <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com> <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com> <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
 <c19ed4a6-6a96-b4a4-0f5a-7ca1dba925d1@intel.com> <YsnoH64cKCT7gndw@smile.fi.intel.com>
 <2c6a4a61-e6c8-0487-8d29-dc3fbb90bbe2@intel.com> <Ys2EFtNVL8ZALQ5Q@smile.fi.intel.com>
 <acbaf339-2fd9-5b19-06e8-62e66c324dc6@intel.com>
In-Reply-To: <acbaf339-2fd9-5b19-06e8-62e66c324dc6@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 17:23:06 +0200
Message-ID: <CAHp75VcVEEUYf2YZLVMby_v4fNpA0upAB+YkWwrPxqV9R+-YZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Tue, Aug 9, 2022 at 11:55 AM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
> On 2022-07-12 4:24 PM, Andy Shevchenko wrote:

...

> I've spent some time analyzing possible utilization of _Generic() in
> context of get_options() but in my opinion get_range() complicates
> things enough that get_range() and get_option() would basically need a
> copy per type.

Thanks for keeping us updated.

> If Linux kernel guarantees that sizeof(int), sizeof(unsigned int),
> sizeof(s32) and sizeof(u32) are all equal (given the currently supported
> arch set), then indeed modifying get_options() may not be necessary.
> This plus shamelessly casting (u32 *) to (int *) of course.

I think as long as Linux kernel states that it requires (at least)
32-bit architecture to run, we are fine. I have heard of course about
a funny project of running Linux on 8-bit microcontrollers, but it's
such a fun niche, which by the way uses emulation without changing
actual 32-bit code, that I won't even talk about.

> What's left to do is the __user helper function. What I have in mind is:
>
> int tokenize_user_input(const char __user *from, size_t count, loff_t
> *ppos, int **tkns)
> {
>         int *ints, nints;
>         char *buf;
>         int ret;
>
>         buf = kmalloc(count + 1, GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
>
>         ret = simple_write_to_buffer(buf, count, ppos, from, count);
>         if (ret != count) {
>                 ret = (ret < 0) ? ret : -EIO;
>                 goto free_buf;
>         }
>
>         buf[count] = '\0';

I guess this may be simplified with memdup_user(). Otherwise it looks like that.

>         get_options(buf, 0, &nints);

(You don't use ppos here, so it's pointless to use
simple_write_to_buffer(), right? I have noticed this pattern in SOF
code, which might be simplified the same way as I suggested above)

>         if (!nints) {
>                 ret = -ENOENT;
>                 goto free_buf;
>         }
>
>         ints = kcalloc(nints + 1, sizeof(*ints), GFP_KERNEL);
>         if (!ints) {
>                 ret = -ENOMEM;
>                 goto free_buf;
>         }
>
>         get_options(buf, nints + 1, ints);
>         *tkns = ints;
>         ret = 0;
>
> free_buf:
>         kfree(buf);
>         return ret;
> }

...

> as a part of fs/libfs.c not lib/cmdline.c. Is such approach acceptable?

I think so.

-- 
With Best Regards,
Andy Shevchenko
