Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD8510B89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355565AbiDZVyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiDZVyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:54:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F86B090;
        Tue, 26 Apr 2022 14:50:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n134so322237iod.5;
        Tue, 26 Apr 2022 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFhxvEKDcp+p+Jf+hKy1k48Hi9OxmwmKYCtCg5xjO34=;
        b=gydrhvbAvrmqKWEOGZZ8swyxUk51TMy97z+ch9gcoqXwDrzYplo4Epen7SIvfGzz59
         nDHV5uh8XlqtG+R8ZtPYwJy4GUovL3xazdKha7BX37OyJLvpZRBcaPWWarlNpZEfbiAP
         OzxIRxf8drhYUHAdTDzWmpGLUYrUeNAgjF50CDCj2+v9midPumJaqO3SqVAVj21b4tUp
         WDWZfhp2jhAdSftAxleMYBI/CEnBqHs0piSQqtpnZlrExVD74nYRzFDlFmF0C3GshutT
         DFF6UtxN44M86ztGCclbnNR0uGY6G2Vixz/pTRonGE8f1maV+XTsQxA1O/L3RiUfZ98I
         9tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFhxvEKDcp+p+Jf+hKy1k48Hi9OxmwmKYCtCg5xjO34=;
        b=SC+BmXZ16blBsrUxJDIvIYqHwmovCjKKSZ6lLYL+jtwzPxlst39+3CeygfNmQBlYLE
         Y0EBUBM/mbmTsuGbBRiCkUSPkW+iMc99YGONb2MQRz/40+tZvyeC95WRd9ZfLrDwJk2l
         YzVUphxtqxGXRHnGbQPo74ok0KG7xzsNwgywr6EfuN/QuyI8qA6F0DJSl+fXADtULpAm
         K4ylB5oBpYl5/PpIpMnG28EmhfUiBx2C1X+e5OWq6356j+z6AJ3LPPQKAOuOLNXNRMKn
         TXii2f73sb5EP0QdjVTJDZgitLSTWiWMIxqCQGiDR1DIh+gSBNoru0e6wb7Mzk0JdvMn
         Fo6w==
X-Gm-Message-State: AOAM5336Fixc6T1a/E5KLsAUrLb3mbCg2Bt23hFOyAMcAA4AywG+wR//
        HDFJwp6XLJDxaYMJ6ro4zVCg8I5w4/8H4pNFGpc=
X-Google-Smtp-Source: ABdhPJyXTZIbcS6XsIYv3OXNhY52CgrTfa8TJPzROLHZ8RTWQROxLwBpdNsY0++kqjAOKD7RQlqZLNduWZXtwuILONY=
X-Received: by 2002:a05:6e02:1888:b0:2c8:713f:dcff with SMTP id
 o8-20020a056e02188800b002c8713fdcffmr8897423ilu.289.1651009858991; Tue, 26
 Apr 2022 14:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-4-eugene.shalygin@gmail.com> <20220426152418.GA3344789@roeck-us.net>
In-Reply-To: <20220426152418.GA3344789@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 26 Apr 2022 23:50:47 +0200
Message-ID: <CAB95QARiSNaMU=Z3ZpvgRYfr+XyYiFtfXXV-e4aZU60FUfDcEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hwmon: (asus-ec-sensors) add support for board families
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

> > +enum board_family {
> > +     family_amd_500_series,
>
> The default enum value is 0. This means that specifying nothing
> for .family matches in the structure below always matches the first
> enum, which doesn't make much sense and might cause trouble in the
> future. I would suggest to explicitly select a value != 0 as first
> entry, such as
>
> enum board_family {
>         family_amd_500_series = 1,
>         ...
> };
>
> to avoid that problem.

Thank you, added family_unknown member ( = 0) instead, to simplify
adding new members (I want this enum to be alphabetically sorted).

Eugene
