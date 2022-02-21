Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72D4BE2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380997AbiBUQpK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Feb 2022 11:45:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381033AbiBUQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:45:07 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1221E1B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:44:40 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2d6923bca1aso135674927b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+WSKItCbGDEisKpqSZnlzvd5r0lw33xDPbmmN1wsPHQ=;
        b=5JuP4j96A2p51SwQOZM/SzeiVzJXHAqjKHLUM2cbLplPlc/9jnVY1YD8jx3YAyaNzK
         HAVjTKWtd9MDnSKZKIs9W5/D8c8HxsmAQ2DrH20h/6Y75ZyabzpFoQKRMYRGrMKKZpmh
         d0si/HgNbAFkVuJCV1Uv25M+Lq1fK+pOjgLk1t6z5vjDxscDHePgGd7ui29VVsIinSAe
         Np65Y79R3kWJT77ZEDPih/xFY/xMI5Kp+o28kdIHt0+0xJxTq8t7W7clUKKNBOr5LdVQ
         Qi1TIxmDLbwJB1mxKPR9sB3auudtr+bM6q1GXxQJEzQziiTMI6sHH5bw17PLgWEKQaQs
         eHrA==
X-Gm-Message-State: AOAM532R6B5M5s6Mjz9jQIVEWGbte3IkPolqeSxn5HnJowEtaqbEpg8X
        BFzCcl/Y5YW+R3D6ZGBvOBd+eTfmZeNIwOQ85jY=
X-Google-Smtp-Source: ABdhPJyXDKguhBCnYVs+wL9YEjjcJmLAL6u9xG7BS1ctCsfHRryxBHfBNyrVyU59qzkwS3SppcL0M8QPFNI++YhSmm4=
X-Received: by 2002:a81:1cd8:0:b0:2d6:b74b:5b55 with SMTP id
 c207-20020a811cd8000000b002d6b74b5b55mr17187262ywc.149.1645461879453; Mon, 21
 Feb 2022 08:44:39 -0800 (PST)
MIME-Version: 1.0
References: <CAGsy+6s36Vf+n9cMbis2a=A4=dUNvsbda7K7rszHikq_HGOAtA@mail.gmail.com>
 <CAJZ5v0iNLXVAR8fG-gjnRP4BSwReL1sZ9XiLHvO+YVKFJFjGOQ@mail.gmail.com> <VSXN7R.644PDRMKJL992@crapouillou.net>
In-Reply-To: <VSXN7R.644PDRMKJL992@crapouillou.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 17:44:28 +0100
Message-ID: <CAJZ5v0gb4Dra_NTQjcP8T7Cqy6ejRUV3MgcKC0RPSL_0kqTsuA@mail.gmail.com>
Subject: Re: Error when compiling kernel module - Re: More power management
 updates for v5.17-rc1
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        eh kernel <ehkernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 5:29 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rafael,
>
> Le lun., févr. 21 2022 at 17:18:51 +0100, Rafael J. Wysocki
> <rafael@kernel.org> a écrit :
> > On Mon, Feb 21, 2022 at 1:15 PM eh kernel <ehkernel@gmail.com> wrote:
> >>
> >>  Hi Rafael,
> >>
> >>  I now get an error when compiling the kernel module (out-of-tree)
> >> with the new PM macros.
> >>
> >>  /home/ubuntu/pressure/bmp280-core.c:1163:28: error: expected
> >> ‘)’ before ‘(’ token
> >>   1163 |      bmp280_runtime_resume, NULL);
> >
> > Which of the macros has triggered this error?
>
> I think the bug was introduced by 23a133c1ba67 ("iio:adc:ab8500: Switch
> from CONFIG_PM guards to pm_ptr() etc")
>
> The macro takes 4 arguments and its first parameter should be the
> dev_pm_ops name, so "ab8500_gpadc_pm_ops".
>
> It slipped during review.

I see.

Can you fix this, please?
