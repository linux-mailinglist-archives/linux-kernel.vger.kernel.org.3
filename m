Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4983E4A4084
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiAaKyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiAaKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:54:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A67BC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:54:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y15so25917364lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FYJ06Pn7KdIiknGNcxtZYxSkpOlwX2UUSY/42OtNl5A=;
        b=jMMmsemMapD2tIaSffSat5gYTv8s4J+w0YvPP2UBc6Ytt1qnFobM7q5OSEx32iXLWu
         6t3Z4qTmPfwOquKxVX1EXBgcIl6wasFvV1X6t0lmgRKpdkGExFByg/0ZGikvDu1bm5W1
         fHXO7elszUKu6TOU4VUrvvfBoXqr6WBYpyr4UCWQ5AK5alT2boOAWNLCcww24BEY0QdV
         WTOMm419FWz2/PE3/8Ev/fMmI/xFDj3Y87m3qB94rkm+uLTGnzbc/ldsbYbRMNlKaVr2
         RT2AT4vh63mB3Bmw8V/Slfv0gF9klPA1EmosgUanJ9d1oEA6L+SsFIFLeu5tu7WbtIl5
         ujHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FYJ06Pn7KdIiknGNcxtZYxSkpOlwX2UUSY/42OtNl5A=;
        b=RJolb/d5icWLp1YZ40yTVARMGugzXMP7s7WtrcmFLmVv8cCqSMjecSqr8oAYHwb3pB
         30KykF8/2aa8XhHEGdhN/IP9lDtBO5JomwAxNjvpYLJdrXltOak/A2TTcvk7cMUw2FhD
         esDpte+17fxk6wfz2CdvbvglihJ5POhGsdx8//CIl91u5wXX9mPHdZFj8wTGheAdA9Vr
         hWzBIpWeErTs2HRWISn1JRJZVW1yNxmgcC9GOPiJcFe2dTKHEtZBMpqMnUVI4uxI3g93
         W7CvS59R/umZCQUFf+83ETmPkJ60E6bTEsp0J2FYb1+A56BtObyVVpsY3OcFIVcmjrIV
         R1AA==
X-Gm-Message-State: AOAM530/5EgF489TymwDo2kNDA18Q4addsWqZa46k13NRcE5wY1Atr9x
        zXR8idvqTgMDUEqNK3LHFpijmArBzm8=
X-Google-Smtp-Source: ABdhPJy7mc/yKZIsj3pfPwCe5VRNQ6hQQWY691137WaoP7WTsYK5IgdWchGjbtuarNRsNzKk7lPb1A==
X-Received: by 2002:a05:6512:1599:: with SMTP id bp25mr15166616lfb.678.1643626462679;
        Mon, 31 Jan 2022 02:54:22 -0800 (PST)
Received: from [192.168.50.104] (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id i18sm3610720lfv.257.2022.01.31.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 02:54:22 -0800 (PST)
Message-ID: <51a1719144b57f3c17252832d0cd97ca8ff17293.camel@gmail.com>
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 11:54:21 +0100
In-Reply-To: <Yfa4WMeauvmgkQ9H@kernel.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
         <YfKngOPLeI3rQOn3@casper.infradead.org>
         <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
         <Yfa4WMeauvmgkQ9H@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sun, 2022-01-30 at 18:10 +0200, Mike Rapoport wrote:
> On Fri, Jan 28, 2022 at 12:21:59PM +0100, Karolina Drobnik wrote:
> > On Thu, 2022-01-27 at 14:09 +0000, Matthew Wilcox wrote:
> > > On Thu, Jan 27, 2022 at 02:21:25PM +0100, Karolina Drobnik wrote:
> > > > Add a dummy io.h header.
> > > 
> > > Rather begs the question of what memblock.c needs from
> > > linux/io.h.
> > > 
> > > Wouldn't it be better to:
> > > 
> > > +++ b/mm/memblock.c
> > > @@ -18,7 +18,6 @@
> > >  #include <linux/memblock.h>
> > > 
> > >  #include <asm/sections.h>
> > > -#include <linux/io.h>
> > > 
> > >  #include "internal.h"
> > > 
> > 
> > That was something I considered in the very beginning, but didn't
> > have
> > a chance to verify it works for all architectures. I can take a
> > look
> > after I'm finished with other v2 changes.
> > 
> > > (allmodconfig on x86-64 builds fine with this; I have not done an
> > > extended sweep of other arches / build options).
> 
> I did a sweep for defconfigs for all arches and all were fine.

Thanks for doing the sweep, it's very helpful.

> Karolina, please send the formal patch. Let's see how kbuild bot
> reacts.

OK, will send something later today.


All the best,
Karolina

