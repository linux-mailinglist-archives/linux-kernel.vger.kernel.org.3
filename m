Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBC4BFDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiBVP4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBVP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:56:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51D5D655
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:55:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u20so25721982lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEpM0l8RPBE+aTAe3Uft8SyL6/gEsgm1pJ818FjUDds=;
        b=dExvEXM8pER9YVnCtI5Lzn0OOPSgtm44ezIW80QG5zlCANJ/keZGvEKFlYtm+DAxA9
         jwH3HtQpCQlNYFo1yWGKwR2lZjMIQmjpNwGQO6qOjeIvsCYgd4jtVWyGNl418vA2Ij5O
         0NLA+dvX2SenBLgBFE16eti+PeQIIPwS3jzULs7IxP4o9hzxV/9aQtervAcCc31kJkz2
         XQ5oGDLUk7h4IAotGVjkg9vc6XCL07KBmNqQM8ThWmoC2Ht3hdbpnN39+mLuVmwObXuA
         gIQVCCD557qlWKn79t2yBuYNFiiOVjnOXGuRXg9MPOdFG/ALykbZNJMB9uDM3sQHCMTa
         FrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEpM0l8RPBE+aTAe3Uft8SyL6/gEsgm1pJ818FjUDds=;
        b=NIzyM6Q34Ec52UpuoCsIZMZJmDk3UDF/twjyWNG9qIuyDH4VJBjAm7idtYjWJ9baDL
         I6QDtb6V9SEC43d7EnlUsYjjIT4v68Rzao7owm6Wyqs19WvPj54PrKGUE5IW4rzyrORI
         qD/BFVwHZibVLia330r8HUDXplZzLy6PO1lG4E+FaldMBdOTv74eqVyDt4kMthx98xJB
         PgWJ6BNW+Lbza039McvBlzijiUOuzp+MvOCPKfVXN0VlYFoxSREDK0RtVbjZnnVWS62S
         /vh3bJihXcHCWAOhkQeEnU85y75QVvuQ5Yc2Y6jNTFSw7oLTSPl4USZJAIr2XGMT7n0Q
         lSFw==
X-Gm-Message-State: AOAM5327mGpwSmon5tX8Wa0fDl8y98o3Ed64n0ENJeh9XqA6lDFe6XoV
        rTByyGzMqcBenRwk6GP6jfuUte8oz+d1n4dILDYDfg==
X-Google-Smtp-Source: ABdhPJwPvMoG8GPN6SgbInhJ1ejmjActyS59kzL8HwsAPsdjpY6732byv4aBacE/Re92DjlW1tQcqUbybAP4xljBxTc=
X-Received: by 2002:a05:6512:3604:b0:443:5d4b:3760 with SMTP id
 f4-20020a056512360400b004435d4b3760mr17164644lfs.358.1645545342953; Tue, 22
 Feb 2022 07:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-3-daniel.lezcano@linaro.org> <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
 <e44b9c4b-2ac4-4ea4-c771-bde13943af5f@linaro.org> <CAPDyKFr8Ycr2cbiD5MM9FSPc1qea+Yp9=cottcGAo7HmFR9Eaw@mail.gmail.com>
 <cfbaefa5-fc7b-bd0f-e4ed-8f046de2a7cf@linaro.org> <CAPDyKFoWq+i09Ts_+SAz9ctC2a7-cqC71buDmvb-LZFTVSH+DQ@mail.gmail.com>
 <41214f23-ddb1-f60c-5e2a-96ba161cf727@linaro.org>
In-Reply-To: <41214f23-ddb1-f60c-5e2a-96ba161cf727@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Feb 2022 16:55:06 +0100
Message-ID: <CAPDyKFqo1vhhW994NsnWonTWW34qcSMU5xaBZyV76Njtr0ST4w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 at 14:18, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 17/02/2022 16:45, Ulf Hansson wrote:
>
> [ ... ]
>
> > Does ops->release() also resets the "dtpm" pointer to NULL? If not,
> > it's good practice that it should, right?
> >
> > In that case, we would be calling "kfree(NULL);" the second time,
> > which is perfectly fine.
>
> So you suggest to replace:
>
> if (ops->release)
>         ops->release(dtpm);
> else
>         kfree(dtpm);
>
> By:
>
> if (ops->release) {
>         ops->release(dtpm);
>         dtpm = NULL;
> }
>

I don't have a strong opinion how to code this.

What I was trying to point out was that if ->ops->release() frees the
memory it could/should also reset the pointer to NULL.

And if that is already done, the kfree below is harmless and there
would be nothing to "fix".

> kfree(dtpm);
>
> ?

Kind regards
Uffe
