Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8124C8EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiCAPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiCAPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:19:29 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F42838183;
        Tue,  1 Mar 2022 07:18:48 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id d3so12776416ilr.10;
        Tue, 01 Mar 2022 07:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8Q8DNujLBZv64RDwzXzGiRXS0TzCjj2UcIbSHjjXMo=;
        b=C7oWe4IdymAuUGYWkPdsMxnFP5/RPxf89JrNWL1+xlu7ieQ91pe48GFnRvo6oDMHgC
         JEGHMDIQ+UjasqmvzWM3Ae9xuj2VnD7aHFZx0TL+tE5/F/d7Y1dn6hdHwdlpTe9KdWWr
         PYRSGODJjZp07jZK+g0s5MMESiyjb8AxVbUuBY5djop0LiuDtqvq6rW51F9baEBbklFf
         fdw9xJTEFdKSjTNGEWieCLRZsIOZH/C5J0pxFJ81wd/mF44c10RT7ZZJcStAwzajoSHb
         fEowOjODXWgIWHvYkVaF6upKaX81pszY6A1bodQA9Auqag+eAH0h7Wk4iGLpC0wR1ius
         X7OQ==
X-Gm-Message-State: AOAM533S9DDMzCk5omOcULdRCyn0LndWiex0feXZvq4y2hH2HOX70qxn
        mOKL/szW3znQw5Sapa07JgWye1KOIQ6+DS15+nY=
X-Google-Smtp-Source: ABdhPJwKOQDb8cUUzdreSOSWTHAxkgWETxwmBuUwQu9AHALRfk64I7ndDtJslJ5fcr+7CGLLusKgvaJYaaKTHDkYxI0=
X-Received: by 2002:a92:cdac:0:b0:2c2:ac36:7a5b with SMTP id
 g12-20020a92cdac000000b002c2ac367a5bmr19855724ild.181.1646147927609; Tue, 01
 Mar 2022 07:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20220211161027.2516447-1-trix@redhat.com> <20220212112917.GD20866@duo.ucw.cz>
In-Reply-To: <20220212112917.GD20866@duo.ucw.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 16:18:36 +0100
Message-ID: <CAJZ5v0i1DuS6xsKAPoD5yHvYH-dPFFCNp4k71km=RiafqkK9nw@mail.gmail.com>
Subject: Re: [PATCH] PM: cleanup comments
To:     Pavel Machek <pavel@ucw.cz>, Tom Rix <trix@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 12:29 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2022-02-11 08:10:27, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > Remove the second 'the'.
> > Replace the second 'of' with 'the'.
> > Replace 'couter' with 'counter'.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied as 5.18 material, thanks!
