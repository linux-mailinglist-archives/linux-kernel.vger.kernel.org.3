Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864EA58D47C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiHIHXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHIHXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:23:14 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2920F42;
        Tue,  9 Aug 2022 00:23:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 073375C009F;
        Tue,  9 Aug 2022 03:23:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Aug 2022 03:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660029793; x=1660116193; bh=nZPmJ38iMk
        A9F/DNRP7+JJkHOxUCxiMBuOOh1O2xtCs=; b=Kbr9rmWj6RAndqGkWiuT5jjX5I
        YtgmUw2UG6NVVPc9fAIZ7KqwYjlvVuqJnkyPdu9JV78GDFENhIQORXmVhbh0Y4Mx
        DA3CsaX3hMaPGM8+MvrHPAQ8M9e0WiS+iarv/xcc4irvr9ZNREjEh33H93ab2pm3
        abv35lSrAAD69wM2y6Pvp370q+WlmPiKNKwdx3BLoRx7LYPA6oRMk39fOIpuzN+j
        x3zbAV06ZL7Ip1WGLHX/bk+d9X4GZA8NaJfr6R1WXxHfRP/kB/1dNUUlWG/3Dezg
        a96eJxoBwGyqRTMcrHPYngCx2n5LcuyY+enrThPEVf2XaC+ewiZIiVM8KBWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660029793; x=1660116193; bh=nZPmJ38iMkA9F/DNRP7+JJkHOxUC
        xiMBuOOh1O2xtCs=; b=yhg6IQ4Hm5Zyo/7RIbHj0tKDZ/F2KlJz6YWl8wdao/2y
        ffvyvpM70cZVH2PTbfYnLWAN86lA0kP3/brU0mSGyJtGE/uv+mJiTu0lJZs8KukJ
        glEkpS7lIvVlFEgtGtqSsyKM3Y+/PFQzVM9/BknxloAk31eyXSIOqhAJ0mNP2hea
        CP/04/ZtyqEgbqmZe5q3bcZZjPnP/+S6pB2NUXt8tTPw6by1ToIoCF7b5WTdHilQ
        XnXh11IauLyyVVVfAvh/C7w0Sif/Nn2TwXwYAtX+waz4B8qxgkHeIuE/14Y7HjCJ
        Mk8uti/0GPud+FnuVQHb3dlI0cgg9JMoTZt8sC0xQQ==
X-ME-Sender: <xms:YAvyYliYxFwU2Da9H5E9wIpTh_xpCkh-32SglGcOE6ECxHpPTi9rPw>
    <xme:YAvyYqAJqimIqiEj-OIsTCublwW4vdkTuOkex65O-Vt82BacsHuzxJUdgb2II9YP8
    oe0CCr1U2ZtPItNzto>
X-ME-Received: <xmr:YAvyYlEx7BhDmgbbxRs3ZjNuMwekq3lrJVMVE0g6yMfzGtfov94Ye5xsfEABQAfHC43Hlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:YAvyYqQxb8q5VwOYW_yJ8enEprzVvnwHYtlsyMsRjGRFfggVIL7l5w>
    <xmx:YAvyYiw_ZU-60KRswA_2lxzE8Damn6ANwYjc-tCysIz9FMTseo0t9w>
    <xmx:YAvyYg4KVKqHEAUoIJyiYa8BQJIcFcyamhbq1TC4Rlxg8wYelHBY2w>
    <xmx:YQvyYt-FcFB2Sv4r2KIKmWlXuPU_RjnbSCx5U9tw3bqGAjwJqU-1uw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 03:23:07 -0400 (EDT)
Date:   Tue, 09 Aug 2022 19:22:54 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 2/2] asus-wmi: Add support for ROG X13 tablet mode
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <667CGR.TI5EUKB68MWN2@ljones.dev>
In-Reply-To: <CAHp75Vda5KX5pVrNeueQEODoEy405eTb9SYJtts-Lm9jMNocHQ@mail.gmail.com>
References: <20220808031132.10075-1-luke@ljones.dev>
        <20220808031132.10075-3-luke@ljones.dev>
        <CAHp75VcjTG=fFBjjHRYT2+ARfE-VHWKJ9aV8sF4JtRVo7Ke2vQ@mail.gmail.com>
        <F8WBGR.2I3OK4ERR79N3@ljones.dev>
        <CAHp75Vda5KX5pVrNeueQEODoEy405eTb9SYJtts-Lm9jMNocHQ@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Aug 9 2022 at 09:12:37 +0200, Andy Shevchenko 
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 9, 2022 at 5:26 AM Luke Jones <luke@ljones.dev> wrote:
> 
> ...
> 
>>  >>  +                       pr_err("This device has lid-flip-rog 
>> quirk
>>  >> but got ENODEV checking it. This is a bug.");
>>  >
>>  > dev_err() ?
>> 
>>  Okay, changed here and in previous patch to match it.
>> 
>>  So that I'm clearer on dev_err(), this doesn't do something like 
>> exit
>>  the module does it? It's just a more detailed error print?
> 
> Yes, it's more specific when the user sees it. The pr_err() is global
> and anonymous (you can only point to the driver, and not the instance
> of the device bound to it), while dev_err() is device specific and the
> user will immediately see which device instance is failing. Yet it's
> not a problem for this particular driver, because I don't believe one
> may have two, but it's a good coding practice in general.
> 
> (Note the last sentence: "good coding practice")
> 
> ...
> 
>>  >>  +static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi
>>  >> *asus)
>>  >>  +{
>>  >>  +       int result = asus_wmi_get_devstate_simple(asus,
>>  >> ASUS_WMI_DEVID_LID_FLIP_ROG);
>>  >>  +
>>  >>  +       if (result >= 0) {
>>  >
>>  > First of all, it's better to decouple assignment and definition, 
>> and
>>  > move assignment closer to its user. This is usual pattern.
>> 
>>  I don't fully understand why you would want the separation given how
>>  short these two blocks are (I'll change in this and previous patch 
>> of
>>  course, I just don't personally understand it).
> 
> See above, "good coding practice". Why?
> 
> Imagine your code to be in hypothetical v5.10:
> 
>   int x = foo(param1, param2, ...);
> 
>   if (x)
>     return Y;
> 
> 
> Now, at v5.12 somebody adds a new feature which touches your code:
> 
>   int x = foo(param1, param2, ...);
>   struct bar *baz;
> 
>   if (we_have_such_feature_disabled)
>     return Z;
> 
>   if (x)
>     return Y;
> 
>   baz = ...
> 
> And then somebody else in v5.13 does another feature:
> 
>   int x = foo(param1, param2, ...);
>   struct bar *baz;
> 
>   if (we_have_such_feature_disabled)
>     return Z;
> 
>   /* parameter 1 can be NULL, check it */
>   if (!param1)
>     return -EINVAL;
> 
>   if (x)
>     return Y;
> 
>   baz = ...
> 
> Do you see now an issue? If you emulate this as a sequence of Git
> changes the last one is easily missing subtle detail. That's why "good
> coding practice".
> 
> --
> With Best Regards,
> Andy Shevchenko

That's a great example! Thanks mate, really appreciate it.



