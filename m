Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADBF53C6DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbiFCIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbiFCIUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:20:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392CD1AF2F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:20:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso6742982pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4NXs0gM6EmWNl9SZtPfrcFL6Z+go5/snO+sCnoTH3o=;
        b=OJVPOaSK5wJTmLCMhuJyeLXIlXkwAYg5vYpjvrV87ZVWAzh4cSaT6wr/ggQuS7LBKj
         SFRu4wk1Waz92BT/Utiz2+hcY/6cI2Y5mYyu+smntCrAfKCi9HxZvtWN04I8wznOrCyw
         7am54LTnDKZ6O7A3JPJeUzkc9ydHffkYzx3oS6+dLE1ooMYoIQ3fDv3QGR8W+q5WUz2+
         B8tJpbVoJBIblSD8uTt0lDqlgKnVtErwPVBrwXmtZf1eHzs0cv0f/F+96gFGmqdcPE9l
         ka+PNtLZZaRI/9ZNyZ5TkClEnZPWZCi5bSOP9R9Xoml/NUGVTVHsfwEkon7Es14bu+yS
         IqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4NXs0gM6EmWNl9SZtPfrcFL6Z+go5/snO+sCnoTH3o=;
        b=2M4iLN6B/73E/CujYA5ll9y6lSW6UXzRWuM3FOhqIZNUis3U1QW+YTVqgHn+1uibT3
         XJFjPKklmZoGyiNrDBDAPJOG9eUxKDIVwdwlasDalGWgSSNj+fEj2O3wlmpk5f85iN/V
         CRdrHWMw7wloZI5JDhzUsmw2Cqpt59xZEUYlMR1Gwln5jcNl0zBQlOM2324HCWGeS+5h
         JJTZ/ec+74zwgnViUaWE5RUlOxxH8KdV7lCDpz2WJPvQnFv8D8Z9AzhLPe8eCkSWP5Jh
         TiCxPd4CWTnxgC0UXJR3IPUny8sIBvxJYEFxMNo2LPWltsBha35KVY7K1kC0REtw4RBf
         Y91g==
X-Gm-Message-State: AOAM53290kZaM0yMxQvazJmzOAT/Va/DCJR0ZZY5RbcPzhe8lzhCTWpw
        rtOQEsrn/2HX/1sNnwhuJtYgRbbgboyIwcForhXS+g==
X-Google-Smtp-Source: ABdhPJwvMSX7bJ0sMwvdFp20lychh+sXCuA4C/mut7/HEWAGVctaQxnXeAwtCZxAMkeOUv+YHq4v2qAr7hpIJA5Njmw=
X-Received: by 2002:a17:903:130d:b0:164:17f5:9de5 with SMTP id
 iy13-20020a170903130d00b0016417f59de5mr9406413plb.132.1654244433615; Fri, 03
 Jun 2022 01:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220521124745.8747-1-roger@norberthealth.com>
 <a728cf17-4866-1151-0740-56b06257c917@infradead.org> <CAO_iFwrHcSWJm17fL-Q83DZ5i1xr+_dkEjh5Yt3Hxso0VtnzZw@mail.gmail.com>
 <47a68855-4547-49dd-d7eb-8ef83630552c@infradead.org> <Ypjwh5f6ByoZl5YE@zx2c4.com>
In-Reply-To: <Ypjwh5f6ByoZl5YE@zx2c4.com>
From:   Roger Knecht <roger@norberthealth.com>
Date:   Fri, 3 Jun 2022 10:20:22 +0200
Message-ID: <CAO_iFwrAm-bqRgkD+1QSW8JwjV+Whp_BfNz9Bv1-9XOwy2poFw@mail.gmail.com>
Subject: Re: [PATCH v5] crc-itu-t: Fix typo in CRC ITU-T polynom comment
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Ivo van Doorn <IvDoorn@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        Kristian Hoegsberg <krh@redhat.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 7:17 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Thu, Jun 02, 2022 at 09:31:24AM -0700, Randy Dunlap wrote:
> > Yes, Andrew can merge it.
> > Or possibly Jason (also Cc-ed).
>
> Sure, I can take this.
>
> Jason

Great, thanks Jason
