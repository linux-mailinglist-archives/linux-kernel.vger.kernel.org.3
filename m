Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B874B3864
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 23:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiBLWgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 17:36:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBLWgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 17:36:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791AD3B8;
        Sat, 12 Feb 2022 14:36:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so17137313wrb.5;
        Sat, 12 Feb 2022 14:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13OnRY73/Sj7aehxhk7RNR/sxx8XmpLARA6MyBb5ERM=;
        b=k/YKZdVzt4a9Asp2WwYWEiTDA22I8UN8Wc1Wr7NYJ29N8mudCUAwE3Z6FHq+la+ygZ
         eWynlWHgyMv4J0KDxMtOwYB6uVx2+BQKSqZ8eggIj8PeBRO3RJLPABl4MrjXHYyNsWvK
         acr92nXrIsxXxTlgEG3lBKpR1b5oAVw9FYeZ/koruq1Y68RMMzU+Ncfms9IEN0Vn7KNd
         rsRYL6f+JQ4++ORs5CIphbhtkpXg29n6u9Rmd0W4zzvzpe41anbKJ4BVckSFDcNXwE77
         GqiwWZfgYOjpFQVGDog9t/e8OL7rSIUb/y3UXPjw9XA+8eDGUeyduYF2zfPVrpuKWn+P
         UUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13OnRY73/Sj7aehxhk7RNR/sxx8XmpLARA6MyBb5ERM=;
        b=BhF9tgPOE7l7jC7PTghmcA1a6l8c1qrAFgs6COhWaCHQmUIetUW3CYATFuvI+wt/HB
         H7tEuycQ3XDn3eXHWUwLf7vbfhQKc/PeP3Vr4cwI/saKCIW6/6OjfEMyj65eC8X/sdaB
         b6EfdyAWMtGwC1Mne8z5dcQR7RgkpLXoHFz0XIknCukXbIHxYDyxG4oulkNtrKPq8gJ4
         ojkKvlFos5EfmrIi0Y5klYRejVZB7LCqkuETy/VHMYo+dccBgSxv7byWl6aW0qX20lTw
         6RCCetNry0cOaiWMOY4i2J9ko9RxzMSwTIkZULu5Iqqpounvh6SQ5KjLRdoyEQQcNH2x
         0uUQ==
X-Gm-Message-State: AOAM532rOtBZ1gkMOvAilGyEF6ZgJEX0ZlfBpI4Lpzq/00mNQc6DvIKw
        Y49jUWRy5O+hs96PE8PWzRfb8vlvg5doMouPjDo=
X-Google-Smtp-Source: ABdhPJxLJgWdo4q9+0lxA0BMrZs5AFnqi8cM8j+QYF1QjjO/vz14WaljbQwtCTNrNeMJaWINZrJmAeov72Jk+xGZ3mM=
X-Received: by 2002:a5d:4601:: with SMTP id t1mr6161158wrq.301.1644705404003;
 Sat, 12 Feb 2022 14:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20220206022023.376142-1-andrew.smirnov@gmail.com> <20220206053309.GA3140643@roeck-us.net>
In-Reply-To: <20220206053309.GA3140643@roeck-us.net>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 12 Feb 2022 14:36:32 -0800
Message-ID: <CAHQ1cqFcL0coZBY=A9gf1Y3dqaZrSU=y2tmJtivM3rk1ZDZdKw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add Steam Deck driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
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

On Sat, Feb 5, 2022 at 9:33 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sat, Feb 05, 2022 at 06:20:23PM -0800, Andrey Smirnov wrote:
> > Add a driver exposing various bits and pieces of functionality
> > provided by Steam Deck specific VLV0100 device presented by EC
> > firmware. This includes but not limited to:
> >
> >     - CPU/device's fan control
> >     - Read-only access to DDIC registers
> >     - Battery tempreature measurements
> >     - Various display related control knobs
> >     - USB Type-C connector event notification
> >
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Mark Gross <markgross@kernel.org>
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-kernel@vger.kernel.org (open list)
> > Cc: platform-driver-x86@vger.kernel.org
> > Cc: linux-hwmon@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >
> ...
> > +
> > +static umode_t
> > +steamdeck_is_visible(struct kobject *kobj, struct attribute *attr, int index)
> > +{
> > +     return attr->mode;
> > +}
>
> This is unnecessary. Using attr->mode is the default operation if there
> is no is_visible function.
>

Thanks, will drop
