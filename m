Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5EE51177B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiD0M2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiD0M2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:28:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD23A1AD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:25:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g6so3100438ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umXYVD04U8kB6up3Hq3d8f7zqDE6PdNJnaxLabPQIXk=;
        b=R3hej2D/HjTHESciZlHNJ5mp9jmZQBWIzwepOAqZuCbnyJAGJ69vXomweJnzUiBFGe
         ffM9HRlZmxYgt3n4/oVxU65CL0GizyEwGRjzRje8OzGTtlWi2N8eoTGea7gwqkue/oTr
         t0/GMH4aOhkRnYPnuZvs8YPUfceDCUUm+/bcqxRyRUWNf7MdvjsWRahPbA0S4xWqDVxs
         oZe4BCJVdXOvOlBXMRR+lcYM+yoWWUxWvjdtNF3Omfi5SFCA8LiSf2udhZgk7E6lYpqB
         sduY6Q5gAxe5DC/TeqKk6nB6xvGdX8JWFowPrV7FdTg4ZcRM3e7pQIucb75wr91GbG3W
         bX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umXYVD04U8kB6up3Hq3d8f7zqDE6PdNJnaxLabPQIXk=;
        b=gioRyMZ3K4J62HI6k9YC9H6FlVuRIBu/hhb++M1Liy+eQmTIbWrbLjnvOxfYv6LIy9
         bJS/iL/XqMZXSFe+1ZQ3X8/TfL9R+pia1zPaEoMUvG0pkW22B3YBDz+4ipz4KljiXPTL
         CRe+k+zaamQYyviqAde3t+wJwRhPM7GZNZ+joO5IuxPwvS2eidGy69zsekgoyh4HjVBB
         a7+oVwHBboJrn+LBSYPcJR8cZhUukzqAvMu+NlX1soA/nXCus0ehLXBuQz8zrzucMXEf
         +vHWbQfHJDBpSvugLWf/UFDDlPfJcupfN2n4JNq8TMdTWv81DhqLaPPaC5JOihM87MNs
         O52w==
X-Gm-Message-State: AOAM5329Z1YYKrpmA7O9CkTvPT7K26ywEPwytuqDmoNaWBN5/CWEXAFy
        Yal/vKmx935J31Nj+jkd5R2ZNkpQqbf8nB8xnqQ=
X-Google-Smtp-Source: ABdhPJyGULnAQQCy4CkeSzY2AuWpgjImq9ua1w6pHhwayjgNZgiOZVA8967ZCRMYAJ2ie/iIcarByTRaXkPWb2GRcCg=
X-Received: by 2002:a17:906:3799:b0:6ec:d25:3afe with SMTP id
 n25-20020a170906379900b006ec0d253afemr26414725ejc.44.1651062326257; Wed, 27
 Apr 2022 05:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241643030.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHp75VdHnvv6FH1BKcs8WgGF3nJpj77TsrmsQGBSpsAQU_S-bw@mail.gmail.com>
 <alpine.LRH.2.02.2204260759540.2737@file01.intranet.prod.int.rdu2.redhat.com>
 <YmfxaB1j65p8dOyj@smile.fi.intel.com> <alpine.LRH.2.02.2204261128220.5129@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204261128220.5129@file01.intranet.prod.int.rdu2.redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 14:24:50 +0200
Message-ID: <CAHp75Vc8kb+dpT_i93No+0_==tLuYKxu9t1Nnv1KRomRc+Ke1w@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: fix access beyond string end
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
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

On Tue, Apr 26, 2022 at 5:29 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> On Tue, 26 Apr 2022, Andy Shevchenko wrote:
> > On Tue, Apr 26, 2022 at 08:07:44AM -0400, Mikulas Patocka wrote:
> > > On Tue, 26 Apr 2022, Andy Shevchenko wrote:
> > > > On Sun, Apr 24, 2022 at 10:48 PM Mikulas Patocka <mpatocka@redhat.com> wrote:

...

> > Still shadows error codes.
> >
> > > +                   return -EINVAL;
> >
> > >                     return -EINVAL;
>
> What do you mean? What's wrong with "return -EINVAL"?

The actual error code is returned by hex_to_bin(). What is the point
of shadowing it with the explicit value?

-- 
With Best Regards,
Andy Shevchenko
