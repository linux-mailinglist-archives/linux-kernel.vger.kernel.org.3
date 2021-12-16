Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE947747E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbhLPO2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbhLPO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:28:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72379C061574;
        Thu, 16 Dec 2021 06:28:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y13so87465271edd.13;
        Thu, 16 Dec 2021 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7N+4SfG1J4ZkC7SpJj4hi6lnQkxzgHx/+ulCn0ZunME=;
        b=nX0yOqE/vXcC6n+1R8nPN9msC85mmFuwEmRO3pndmu/s7V/fyIfGoKch8C40gr9VTa
         857ZQFH4KJa31QCpH9DaPBKQItzJ5ScR72LtBG96O3lnWWYXy2vnj2mc988WB43BXaGY
         oCzn71Bf/U5zk+rLq9g/YQQvTdGYYCggI74w0FUtLncUlZ41IT6sOk0qv7a5ykXxCyHU
         qIMcz8m2IW+Z1DQjbMMVkzHt7ragHad8bhY7bTh95LISDtYeL2ewvFrPeMcqE/tkaiVn
         ubR9Kxj4hVygGH1fWbpim4YkAFu6FIQwGwyDnZU9qcm5GCePEiC0rb0y3wVrzgDnGH3b
         GXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7N+4SfG1J4ZkC7SpJj4hi6lnQkxzgHx/+ulCn0ZunME=;
        b=ogICAVbaUUHH9ou4hJfRANFNDL5MsieDGP/ufKG54DVwFk3Kd7tGF7XNGYBdMtOl+7
         9aio8Ygcz+ZrISg/64hANlmbmtcmj1wpqUkHaI2tQWY7hMLZCxPlZH+BTDz759Ajd0Is
         49QodYltob8SOPsMLCwD4mWYDNMWl8imkHY+jJIv19EXVjm3EBwHEoT0p93tHXkXW6ak
         4LcqskSHl1/uMNjOKWb3lcRh0WsYqb91KZEM5LSYibr2QbeuQjWVJIZI7W0TwwMwIzvs
         MxFLNkw/7TuPREFnsBOjL8DDF3SGyRG1kaszy8Frz3Pby02Ub/17QRRv9lEH+xIaOIGW
         oosQ==
X-Gm-Message-State: AOAM5329prCPLO1W0Uq++qwOiNGQAc3mzGZM6ABRyhFVEeI9prWU9WyF
        jWBRAq+WxHoV/kT/KOYZYHv0w7Bj6ib5o0bkk3p+AL4ncX6o7w==
X-Google-Smtp-Source: ABdhPJwpFOMPTs1rXyGuaNC5XM+NCg+klNhSaJ9Zt/05isinQ4JZ4npThJvcP1Th/tBb1q5FnInt9JcmrhjnpQofNVI=
X-Received: by 2002:aa7:cd75:: with SMTP id ca21mr4146824edb.242.1639664881962;
 Thu, 16 Dec 2021 06:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20211215113023.2945-1-a.demidov@yadro.com> <0baa6133-5903-ffd8-69a0-99fb9f69665d@roeck-us.net>
 <06d7c6ee-2db5-f250-50f7-9a47e33a35b5@roeck-us.net> <c1d036c0cfa14fbb9c289f792780f003@yadro.com>
 <20211215162753.GB2906031@roeck-us.net>
In-Reply-To: <20211215162753.GB2906031@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Dec 2021 16:26:33 +0200
Message-ID: <CAHp75Vc646YB0FeYZrFYKHkzCQUt9Nu0bmaGO_1-5mxpQgGtLg@mail.gmail.com>
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
To:     Guenter Roeck <linux@roeck-us.net>,
        "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Arseny Demidov <a.demidov@yadro.com>,
        Arseny Demidov <arsdemal@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Dec 15, 2021 at 12:36:32PM +0000, Arseny Demidov wrote:

> Please add that information to the commit description. Also,
> please copy Rahul Tanwar <rahul.tanwar@linux.intel.com> and
> Andy Shevchenko <andriy.shevchenko@intel.com> on your patch.

I see how my name appeared here:)
Okay, I have no access to the datasheet, I believe Rahul is the best
person here to answer this question.

-- 
With Best Regards,
Andy Shevchenko
