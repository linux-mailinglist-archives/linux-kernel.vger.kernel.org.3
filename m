Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5846543FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiFHXMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiFHXMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:12:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FDF28729
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:12:11 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e66so20255572pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SFwkkRIoca0VU5wHAkBe1QJmYn6M6PLsLEYOYVHZHDY=;
        b=OY2VueiPIGrUFDIMTQFMKMp3/dbcbebsBYS7L8/jj9G/2vl4/uSE99vGlMbpTyy9TL
         ue3vVESCzsnhjDZdM82mxRuscebLp1Cc9WN01VV4cig6Cacq2GhthCxlTXAFvVOhtDzD
         E6fsUwI74wzsaOlwLVG0BtOIo0WmjU3jAwW5VPRYUP796jSeZ54l74PTnZxRLUX/KlZA
         1D5hFk+ZpipszmMEo2DIstDlEvvsJopym90wDnKom3anchSad6b18EZSx+c2j3iou/tv
         k10KjqlHkd49DLE9j3RjEfM7aoL6RsKCtbS+JrF07w0I/oh0V6lRhFkPjsyzDUYeZ10s
         Zv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SFwkkRIoca0VU5wHAkBe1QJmYn6M6PLsLEYOYVHZHDY=;
        b=4LzV1oP/ieIQRdEV+N6QHN8GvKVGLaJDgYHTskD+faEpjD66y1jZCwlTWREiu5bx2o
         dmFa4/X4CKlyh6QuKqkgrXN6hVsPNO439wwLOzZGHcXj5qoKLLwBs6tcY6j/ZBFHSYZk
         06dsgod2F9fEShC+2opk9s7do3BrvI3uYAVRYtMe1hYK95XPQGs4oCKsaJBHF1lnL8GZ
         /EqBlCX8qMx/SeXFUAA+66dqcLerM2/Rst5iGk40XLJdshN393tGkIivAwUSjqdRLcRP
         rMBNvwdhb+sSren14rrS58ZmK4oWlUBn0xsJz33ObZwRobK2xcSXkWqC5FkgXong8cCF
         v+Jg==
X-Gm-Message-State: AOAM533GhrmbSYVSCQSpg6zAZI21JOsXjNyXOZMS3Q321KisWsozOj31
        Q50y7Y0/B96UIq+tzQIxnwY=
X-Google-Smtp-Source: ABdhPJwabIcKTaeBbLtEr3wqAFo2DDyfpbWh8Embwrn7e7nwZYi1Rs3FKhvjt1YAUtqeBbfyHLOAXw==
X-Received: by 2002:a05:6a00:2cc:b0:51b:f1d3:e5f with SMTP id b12-20020a056a0002cc00b0051bf1d30e5fmr26012787pft.52.1654729930568;
        Wed, 08 Jun 2022 16:12:10 -0700 (PDT)
Received: from longfanaikebuke.dlink (36-236-186-165.dynamic-ip.hinet.net. [36.236.186.165])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a294d00b001e0cc5b13c6sm17170183pjf.26.2022.06.08.16.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 16:12:10 -0700 (PDT)
Date:   Thu, 9 Jun 2022 07:12:05 +0800
From:   Steven Lung <1030steven@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/pelt: Fix bracket typo
Message-ID: <YqEsxYv3Lxp5srrj@longfanaikebuke.dlink>
References: <20220608150008.57629-1-1030steven@gmail.com>
 <3193fcc9-c672-19d9-a2e2-ad67809dd20b@infradead.org>
 <F0C192DB-6043-4629-A009-DCB4BA33A9A9@gmail.com>
 <CAKfTPtCr0PiharzDecxdC1u2NnRz_qttQieH568_Q8szdVGpSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCr0PiharzDecxdC1u2NnRz_qttQieH568_Q8szdVGpSg@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 10:14:06PM +0200, Vincent Guittot wrote:
> On Wed, 8 Jun 2022 at 18:30, 龍帆軒 <1030steven@gmail.com> wrote:
> >
> >
> > Randy Dunlap <rdunlap@infradead.org> 於 2022年6月8日 下午11:33 寫道：
> >
> >
> >
> > On 6/8/22 08:00, Steven Lung wrote:
> >
> > The second bracket describing the range is inverted, this patch
> > will fix it.
> >
> > Signed-off-by: Steven Lung <1030steven@gmail.com>
> > ---
> > kernel/sched/pelt.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index 0f3107682..ed82cfba9 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
> >  * When syncing *_avg with *_sum, we must take into account the current
> >  * position in the PELT segment otherwise the remaining part of the segment
> >  * will be considered as idle time whereas it's not yet elapsed and this will
> > - * generate unwanted oscillation in the range [1002..1024[.
> >
> >
> > Is the above the same as                   range [1002..1024).
> > ?  I.e. 1002-1023 inclusive (or 1024 excluded)?
> 
> yes, 1024 was excluded from the range because we reached 1024 when
> period_contrib == 1024 but when period_contrib == 1024 we decayed and
> period_contrib becomes 0 and the load_avg went down to 1002.
> 
> Before the changes, the load_avg  for default weight was
> 1024*(LOAD_AVG_MAX-1024+period_contrib)/LOAD_AVG_MAX
> if period_contrib == 0 ie the beg of the window we've got a load_avg of 1002
> if period_contrib == 1023 ie the end of the window we've got a load of
> int(1023.97)==1023
> 
> In French, we use [1002..1024[ but english version is [1002..1024)

Seems this patch should not be applied, thank Vincent for the explanation.

> 
> >
> > + * generate unwanted oscillation in the range [1002..1024].
> >  *
> >  * The max value of *_sum varies with the position in the time segment and is
> >  * equals to :
> >
> >
> > --
> > ~Randy
> >
> >
> > In the patch that the author submitted[1] for this comment, he mentioned that the value 1024 can be obtained.
> > So I think we should use brackets instead of parenthesis.
> >
> > [1]: https://lore.kernel.org/all/20200506155301.14288-1-vincent.guittot@linaro.org/T/#u
> >
> > --
> > Steven
> >
