Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05904511D79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiD0SXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiD0SXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:23:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318B55482
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:19:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so5008754eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKLrlWDdze4fALIExihCdax2sj1CA1dAjWvhqA4fcdE=;
        b=OC7XubjWFESQ3nHL9PAiwh8ORcR785icOv4rLY6pciNqk/sYywA5nLX3pKo95l8He9
         Xl6BMozv7995amYQgYI7A0fqrSxPwV9JZKYHgcNkYqfef56mnu4mg5vFZ/MCTd7h6+AJ
         WQyIsM8WMl6uQPIF5u0d13artTaNxxbh0xG5WvnJ9XCNw22EeCnZJ4mZXk+6l8bPa/jB
         HCPH3/sigfwTr30iUY13Y5IALbLE7sk1I7qC0YwjQmYNq/AJ/IJUCk9RZHiuCWxBd6Hj
         cJOoSj38FHEWrA3oj8zi8Hh+M9a0qovM5Zb7sQvu3ifm3vFlslsuSd+YORDH1vtHfHz2
         fCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKLrlWDdze4fALIExihCdax2sj1CA1dAjWvhqA4fcdE=;
        b=mAD/2LvubR8HcpSfcDnGGQ1OqNvlxBtergkNJLTcXHQyB9+3bdKFOFSCOFpZlt6Y5P
         /JAdsB+2IRqOebASeqODexVkmMWWIJv+LXjNCFNw79DGf4+kCD6tflQ7Pr31c9XS+oEg
         DitYrlHeyHrHqJGw6cYB7KA5+0CbeUdHizhp2lHRE+2SWVTVkfJZqQUddaUoPmpEOtz7
         kPFXJZaEBYCb6n7Ry/vFAoNp+ERFT54aLzwzDU6eZGoVsiI9cFl52iGJRqe7x8N3/gIq
         vSNpAZun6OrYh+X0KmEWJNqAIQ9h2BwPEzUnlZ9hzJWtLo7EAFK4fM0dW+reUgEYZl/+
         7iZA==
X-Gm-Message-State: AOAM531kFjCuqEXhRGHHn4Bf3BODW2JHMASbcKgsAtQ26W51JVVd+IEq
        4jjnwjrYHSRWGXkutGtKK0BMicBd8uC33t17Mz4=
X-Google-Smtp-Source: ABdhPJyy501pwbeKqbIz9m0A3mZwUkZ4p0dBCZtARyEklGkg3Z72LhIFKi76QqCiO8NAJnNPRmjRwlISESyWvcE0UiA=
X-Received: by 2002:a17:906:3ce9:b0:6ef:a8aa:ab46 with SMTP id
 d9-20020a1709063ce900b006efa8aaab46mr27288500ejh.579.1651083595490; Wed, 27
 Apr 2022 11:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Ymldp7E3j29iVlMN@smile.fi.intel.com> <20220427103901.7567e7058dcaa3068056b2ed@linux-foundation.org>
 <CAHp75VesfSdiR8naGLAfLCJ4mvMarXSQ+6PEoQcgMfgMpBSkNQ@mail.gmail.com>
In-Reply-To: <CAHp75VesfSdiR8naGLAfLCJ4mvMarXSQ+6PEoQcgMfgMpBSkNQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 20:19:19 +0200
Message-ID: <CAHp75Vf+=2jF8p8FFJTLWAKwy7gLPfcNYNUWz8y2pU9rdVFseA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to kstrtobool()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>
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

On Wed, Apr 27, 2022 at 8:17 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Apr 27, 2022 at 8:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:

...

> (It might be better to check the second character as well to be sure
> we avoid typos like 'talse' and 'frue', anyone to comment?)

Note that T and F on the keyboard are quite close to each other, so
there is non-zero probability of the above mentioned typo(s).

-- 
With Best Regards,
Andy Shevchenko
