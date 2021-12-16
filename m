Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F86F477511
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhLPO4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhLPO4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:56:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75DC061574;
        Thu, 16 Dec 2021 06:56:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so87017457eda.12;
        Thu, 16 Dec 2021 06:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CU+3jsN9nB+tvQ6ZzHUH1W9fq1+j8oboXbVsBuRaIRE=;
        b=is9+IqdxP1YWCPHim3C40q1H2haV9rVwwJRAvjKfsvvdPM7C8zkYExHJCT9h/5SZ3t
         Xq3Uj+y8XSlb/OpdmjJnnpm7mGxrlqjaV84w1NU74ndzuFp2c7Hce7zt4H0ShthIhXPH
         tyrrhK+e90T6sFNvd4FN4qHyBRK+KAZRglZxxDJOpDbMYO8KoSNroIUBsClLKPyQok3h
         3JXso/c0PUuJgz1pKve2jShrRJcEGVy7FakZMs9Bx0AE4SH1Weqs7wDd4Pxej78QzZQk
         v4kCFZVCdFW1qZOGak9XZJiLkEwVThgNkQn6X55pF15W3fFaykUpwND2Bu3Xywcmk9YR
         BxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CU+3jsN9nB+tvQ6ZzHUH1W9fq1+j8oboXbVsBuRaIRE=;
        b=lk4xZPpekW9Eyjc7MDnx8F4FXm5TAdcaPF9pVHsw6/idS8q9pUQPtd3VdNC5lYvEHP
         r2OnXqvYj95vzySCLHqKmb0eJ0SZ5UkWD73/oixAiCLiQp0//h8UUxnLkAnYHDpxDiOe
         CEUpd8sj1JCTEjwHPdVUXbcB4sPpOhL+0k5FIfE5kJxUPW7Iaa4NA/Y0oukX9fb13A+J
         dKoCoN3MdzIPUTUxbztxBNkmsVvAAFvE2/LyrTO0bZvK4r+HCQ9wUu9BSjJkYpNDLJvu
         mudmsBHjcKwk/VyimAt7U1W9DenNjJHz4K1szyMeOjC3HmK6JKhO2yUGxI+MwJKiuqbB
         1SJQ==
X-Gm-Message-State: AOAM53052/EYjV6cFiwC7l9K5nhWCJGJtNpY0NUm8w7eEss799LOhlGJ
        orErqBkHkTYqSNHvVxVWMd3xQOb4Se5JnwiIA3w=
X-Google-Smtp-Source: ABdhPJx0XNVz7lRbKRdN+qt8HxJf1gHJh98DrZlaWE7MV67clAAQ/z/CHjzJPw4a8QqrP5xyh47dYogKsW5zpTXg6mI=
X-Received: by 2002:a17:907:76d4:: with SMTP id kf20mr5190415ejc.44.1639666561274;
 Thu, 16 Dec 2021 06:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20211215113023.2945-1-a.demidov@yadro.com> <0baa6133-5903-ffd8-69a0-99fb9f69665d@roeck-us.net>
 <06d7c6ee-2db5-f250-50f7-9a47e33a35b5@roeck-us.net> <c1d036c0cfa14fbb9c289f792780f003@yadro.com>
 <20211215162753.GB2906031@roeck-us.net> <CAHp75Vc646YB0FeYZrFYKHkzCQUt9Nu0bmaGO_1-5mxpQgGtLg@mail.gmail.com>
 <76b93d2e-15d2-6969-6411-7839691b8dca@roeck-us.net>
In-Reply-To: <76b93d2e-15d2-6969-6411-7839691b8dca@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Dec 2021 16:54:32 +0200
Message-ID: <CAHp75Vf0ywVK4Wvfe=naD3sk5svU=BAjR46xbGu6f-4fOSNemA@mail.gmail.com>
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>,
        Arseny Demidov <a.demidov@yadro.com>,
        Arseny Demidov <arsdemal@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 4:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 12/16/21 6:26 AM, Andy Shevchenko wrote:
> > On Wed, Dec 15, 2021 at 11:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >> On Wed, Dec 15, 2021 at 12:36:32PM +0000, Arseny Demidov wrote:
> >
> >> Please add that information to the commit description. Also,
> >> please copy Rahul Tanwar <rahul.tanwar@linux.intel.com> and
> >> Andy Shevchenko <andriy.shevchenko@intel.com> on your patch.
> >
> > I see how my name appeared here:)
> > Okay, I have no access to the datasheet, I believe Rahul is the best
> > person here to answer this question.
> >
>
> You reviewed the original patch, so I thought it would be appropriate
> to copy you on this patch.

Yes, yes, no objections to that!
Just because I have no access to the datasheet, I relied on what Rahul used.

-- 
With Best Regards,
Andy Shevchenko
