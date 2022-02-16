Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4974B9021
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiBPSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:24:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbiBPSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:24:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D729F1F5C80;
        Wed, 16 Feb 2022 10:24:02 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id bn33so4659292ljb.6;
        Wed, 16 Feb 2022 10:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BS9zAD2XVBFWxic3VwORgp8dzUF13FMIDSu6Qx4V5Ek=;
        b=OVD1wZDgcZe2+pLUyaO4o7MllaPc/DWUq9UZrsIj43k4823o2K0jvmPokIGg1wjDaa
         XC5AkQOvWFEVCeSkYkefyz9+RXgQcQHbhcqbM1GBSf8YH0CwPiw6IJBWS3dzngxjimXo
         TPOitl/ievDCdOydijfH6qoNZxdPjND3oVCdGIJKs89QEKdssAmypfrRbBM2gRKGV+XI
         Id5qhV2e3y2wJr83sl9IeYFhRN+XFix6UHcyQf/MNbao+IeQff90Xs8/2v0toDHZoFdk
         ykIqJ6OGq49CoMaOQsiTvIaYjoy3cFENlpUUy0IPmCuJxHLDn+SgX9lK3IudOiN7CxnZ
         N7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BS9zAD2XVBFWxic3VwORgp8dzUF13FMIDSu6Qx4V5Ek=;
        b=xnCAjOoVyhmgUJ5KQzbBWxoVMHYiiuiAh4kIUu/aC7o1ohc7D9usDeNSa+3v4ehqf9
         upV1k5LVXR/gz1925CMomKNJHzACh0iE0nxItgZ0PbYbEQVsSomjKeYMKiSlE5pOzDFL
         8+J/yhGCHGX+uqMxLdgFpqr0q1cp/LcKvUCWG53qhVNDYSRK7ASz2HmHkiPKuGjZqhIT
         QPtVPrO8BFRMT8uxTzw+/ENAS8SzUuRI0bI6eX2/o4J1E2XURYAaEYjJWuqIsp7J0TDc
         U6dLeRrFl/0XzSI9O+NAmgzsGbpwSpa196gigj2eWrsENMh3EGODPUp9oL5M7xGrgScq
         wy+g==
X-Gm-Message-State: AOAM530Mz8noKZBQkLftIQgDkGgC8F29Tm3cOSj1UJgjXYlZHjfu5msK
        3Tk3wMGyUy74rZZcCFGgPdJCekkGRAW9irWLAx6g0upNq78=
X-Google-Smtp-Source: ABdhPJyW85sYjKwSJln2OjkRx+OgPHaYOgb1eb0nO6QQSH9Fk3i7hLST3LjRyk5UY3AUPSCp+FUibDzN7fZ/0kZjOLk=
X-Received: by 2002:a2e:bf25:0:b0:240:c5b5:88d1 with SMTP id
 c37-20020a2ebf25000000b00240c5b588d1mr3023795ljr.117.1645035841046; Wed, 16
 Feb 2022 10:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20220216180822.GA3300192@roeck-us.net>
In-Reply-To: <20220216180822.GA3300192@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 16 Feb 2022 19:23:49 +0100
Message-ID: <CAB95QASWWMvSSuuwQU=TwZX-QcU=hRPCJVQ0E6Bh29sc4d66Ug@mail.gmail.com>
Subject: Re: [PATCH v4] hwmon: (asus-ec-sensors) merge setup functions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 19:08, Guenter Roeck <linux@roeck-us.net> wrote:
> $ scripts/checkpatch.pl --strict asus-ec

So, contributors have to use the --strict option?

> WARNING: braces {} are not necessary for single statement blocks

The file is full of such braces, because I like them and it is only a
warning. How should I proceed with them?

Regards,
Eugene
