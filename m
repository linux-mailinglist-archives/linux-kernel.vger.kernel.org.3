Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18CE4B8AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiBPOCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:02:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiBPOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:02:47 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36975A18A;
        Wed, 16 Feb 2022 06:02:35 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id x13so2343862iop.4;
        Wed, 16 Feb 2022 06:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wq8y32ABNBZbcqylC8Ur2ZeBUVfGtdlMWNr7W/fuok0=;
        b=NE6SoPGpr45x6yjxKEkhBhvp9FeB5bldahuR0GulSBluXT91mtaSRgbLiUYkJxN24L
         Z+wvWGpZSQoaH21sVjvx0+/XyAjbaI7nZg/5JA36b64YLviIv45laphsq1Ra5tXszT6Q
         uQMMyNiff/QEtFN0LLQ448r6hlbc4NJ5IJNlAYsWjlKMZSX2s7LdTTGOqRtZ4bvQEWGB
         ie3FypWx9/28wBZpUsgZWuLVTq293EXMPw/p1NQk9izfoZZXreQHWAispnExcg/x7tlc
         q4y+EWwqyMZuaPINRpu5yoULGHLRgRaxHzuiNofbQ7Or7WEJTVbAGjnXl4dLrWUjFK8u
         F/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wq8y32ABNBZbcqylC8Ur2ZeBUVfGtdlMWNr7W/fuok0=;
        b=YSf36N//6JbQG0Wya5CDn7Io6B89aI4brWq2RklNggT/JOFUdmqP44eFn6qjjUvK81
         GHMN4JANBWSynRZgYi5B7y/f3ctUmh/N30AmHm2+BsP1F3bZ9BS/GvabU4BxaV0XkNf+
         k3axo4r2OUU79LjW4QUA1gk0pu8KKe+zBTMnWoifLkt/FhTMq0hQHqoLQ53jfLpB9F8J
         pgGrs5OxTjgFRTAh6WHT/Vst9MlQxKcKD2QB83PDxlRgZYksjWWXIuWbJRYPwdddep/I
         ta3K/fwr0JwNmm9vWl4e26BWZ47Hce/qXZSnrSTpnk8IM44RW/hC2hzGFW/3zwlPOoZU
         gXxg==
X-Gm-Message-State: AOAM531iM4Oxoc/tALeBG601g0HAhw28rg29GjEb1WFjSvUoF59770WE
        BdnUzIX9SGdFER9C4L7SuME0oOJsbPNCydeM4JDWEWtQ
X-Google-Smtp-Source: ABdhPJzp1Hz/USDGwRhjn0VfFhU46xBaQ32ZHF73wW4rv+ZAu0dtBdnrLmauty022+LdCxwMQaa9MaHMDNS58o92iR0=
X-Received: by 2002:a05:6638:3888:b0:314:32a6:90b3 with SMTP id
 b8-20020a056638388800b0031432a690b3mr1897651jav.186.1645020154542; Wed, 16
 Feb 2022 06:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-16-ojeda@kernel.org> <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
 <5d8e8c09-64ca-38cd-591d-c193d1c01c7e@gmail.com>
In-Reply-To: <5d8e8c09-64ca-38cd-591d-c193d1c01c7e@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 16 Feb 2022 15:02:23 +0100
Message-ID: <CANiq72kB2aLCPGr5nXUKeagQH0KcGjLd=1YWvBwOqV4NDBEpZA@mail.gmail.com>
Subject: Re: [PATCH v4 15/20] docs: add Rust documentation
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
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

Hi Akira,

On Wed, Feb 16, 2022 at 2:37 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> Here, the cross reference is internal to Documentation/rust/.
> In this case, a relative path works for both top and subdirectory level build.
> So you can say:
>
>     at coding-guidelines.rst.

That is quite neat -- thanks! Will definitely do.

Cheers,
Miguel
