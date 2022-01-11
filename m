Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64FF48B736
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbiAKTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346557AbiAKTTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:19:49 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE8AC061201;
        Tue, 11 Jan 2022 11:18:22 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e8so36091ilm.13;
        Tue, 11 Jan 2022 11:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjmViiIBre3Or1MpUA0C99w6YePtgf2gP2ZSnyWyE3o=;
        b=AP1fc59Vkj1I/G06/1HC4PEXXUIDoxAWst8d2ysF1zSa34JQnuUPJJOTK8Eq8atiRb
         ZFPGJcjtDRpNCLOwDM2vHnWI7E/5HreM3GwGSdQX+Lbp+JBOBM2E7oQ6gx1J7pOKdQ1B
         1WRAIH4TS2FvYTuJPuk+suMxn3az2DWE5ZgHCvXCb+7peolxoiz8KCiVZX20mi735KxX
         WK6AtqBV4wPQhUwj90mGDSII7nF4lTfgUrPjLE+kTfVliPqVT3HdDJaAJA1ca2J8zKCG
         iFalmcMG5UfsyM0NgoIiv1V2OyJsa0QXkMdZo+kiTHXMmBSZ6NrsS+BXrqLQ0iZCOeph
         4qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjmViiIBre3Or1MpUA0C99w6YePtgf2gP2ZSnyWyE3o=;
        b=QiQSHdWceoGEne0TdbKel/hkE2Tb0ccCwykw1QBGM3H5BQUCdTKy8a1ZLdXSHsZLRx
         zh1bkBH2ve6S1QHMW4MyCCJVUwFTnaj1lCU+ylkrL/lm515y+gzDgeMqYUnSKMH21rOk
         s4M/yNRTynaowSFBoHAF7/YISIlJRTbAmcxIdQ5kosXJg9jGoeaId7VKrARSdBYABFUS
         N8wp7TKEEmuUjzL2j+PrZu3dPFzGDvKlaCycZ0+Nn4eW0hlPoBL6epWQ7xuiuMeARCVo
         FJKH3MckXMp7AILivW7wMP9/42zfiW2H324A38D8n/9sdcjOP0AfDPZ2J1vdqY6Rkd4q
         l2dg==
X-Gm-Message-State: AOAM5309hxqgZ4y3Exfykl7lnPXrm4AIwf2jKBxDvNOQPhO8o7F+akQO
        Itu5fMtSUecj1Dk3c4ZKgSGKEHXYD6HVgfn+ICs=
X-Google-Smtp-Source: ABdhPJwSdhQyKPvc4HjAwuZlim8TG/NSju7MtylKfE0hXQtQyfSKCwH86iWlgikX1Em8ozt+YEMiX9MRVdc3tXsAhhk=
X-Received: by 2002:a05:6e02:1a08:: with SMTP id s8mr3277389ild.164.1641928701627;
 Tue, 11 Jan 2022 11:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
 <20220111160900.1150050-2-eugene.shalygin@gmail.com> <805dd382-262c-36f0-fcf5-5776223040c8@roeck-us.net>
 <CAB95QATsy2ACgyxWLy2PM2peqoYDEa_j96VNSHBG6GMd+x3LzQ@mail.gmail.com>
 <050ee3ed-4c30-afb9-d7ce-898d634284be@roeck-us.net> <CAB95QATb_En0KqXRktY99q8UXmosCftMrekpFiAKrAocwFEKmg@mail.gmail.com>
 <b5753e72-fe0d-1102-64cb-49de242184bb@roeck-us.net>
In-Reply-To: <b5753e72-fe0d-1102-64cb-49de242184bb@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 11 Jan 2022 20:18:10 +0100
Message-ID: <CAB95QAQk=fqVtqWGzoe57=G=sOvFXvjfo9s43z7grVTce8qyMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No need to resend because of this; I can drop it myself. No,
> I don't have any further comments at this point, but I would
> like to see (test/review) feedback by others before applying
> the series.

Great! Thank you!

Regards,
Eugene
