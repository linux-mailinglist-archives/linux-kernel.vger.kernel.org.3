Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C024A7E73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349233AbiBCDtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348594AbiBCDtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:49:10 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D6C061714;
        Wed,  2 Feb 2022 19:49:08 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y84so1752727iof.0;
        Wed, 02 Feb 2022 19:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cH+JefUkNgMOJwGnoWzmYzTDgAaIN5IwlvQkAxTpPBk=;
        b=hNwPLhL+2AMOsSEb5mgiypBw1Sx5dmSSUrkrMIBfqqN1H6/ZH+hujkzXclyLAJ8LJo
         wiWZLo1JrwTgf9jcafQAlmcsC73bbe4cNRjooMJBRD2mzTdJn2+JV1L3qodAvLWxWn5T
         Vr/SJfKkAxFagd/IOdhuWr0DuLB7hwGb6Wp2u+jVVwOkQE+VI24No/eLeN92q/58K2NY
         cAy1kElsuDFjj3lK2x2Gw08cvIXl93/UIBtvuG2KiZz+jmI6rf9og0nokdDHHlbN5RK0
         xFvcxguQ1L0pIiBOlgxCyM5vlVUK7oU9YVKvyYPCjmj8WcwwWY2Lxkrxm8+OWd5ZEhoE
         pH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cH+JefUkNgMOJwGnoWzmYzTDgAaIN5IwlvQkAxTpPBk=;
        b=0MXH5KW1F1ZeiDmHLwRusmIDz+YU3xkef+XjoGPelqEukUDimhaULmai9ia72mWiFH
         bH+DNwU7nm1qrZbcEKYZ0NRlCJmaY84LD7fBHeYM4v/h8Skz3YsNE8aakN5/HHrqKqpR
         /vgiKlgrSE+YsVHT5wGecYz8h0sQuKaNRXGd8z+zpMoWJOmUGBHWGP0Sm8eRY1rbdhsX
         tnstGYIZmy6OvNr7Vhxkjsyu9MtrwFlDeOOs5TLQrlbSYkTAegwFnJXGVODOZYr0N3Dr
         stN2icL3znSzZQQxEi090eTgn+MtG9aOWgRXBCel152CkAKRy+a7ed0OvZ6gppos0A42
         +9lQ==
X-Gm-Message-State: AOAM530k4z4s/muh6u0RL5WuNjrTG1Qff+y/qkHlxtOlxHzrdzuUsgoF
        HgfJ6Y56m1x2Ps6YOuGTqSfSd1Z/UyrwcEWzjj0=
X-Google-Smtp-Source: ABdhPJwYxfXG3TFpo+sC0YB0Lv4N3eZ1fDN9qaIptbgVQWAFBiSRaVVmL5hU2sS21b5pN65p9xNG2xRh5XnH+if00xU=
X-Received: by 2002:a05:6602:1484:: with SMTP id a4mr16884736iow.133.1643860144934;
 Wed, 02 Feb 2022 19:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
 <CAB95QASxE8Z_z046mnOBD1Zk1oeg=xB-wS+J8Oeuj=akm8171Q@mail.gmail.com>
 <c613f73b-9c91-9aad-e367-87b9d8b17530@roeck-us.net> <CAB95QASv2nY6kttOw1rwReUuucfpSgoByA6yrAbuQPRcTUQJBQ@mail.gmail.com>
 <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net>
In-Reply-To: <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 3 Feb 2022 04:48:53 +0100
Message-ID: <CAB95QARyz_sp9MoMsakfAK+PRBnVVnyOQzm2ZwJwwLE5vvAUFg@mail.gmail.com>
Subject: Re: [ASUS EC Sensors v8 0/3]
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Oleksandr sent an informal one already.
> >
>
> He wrote:
>
> "Given minor changes against v7, I think my "Tested-by:" should have been preserved."
>
> which doesn't mean he tested again, only that in his opinion
> the tags should have been preserved.

Oleksandre, could you, please, let us know did you actually test the
v8 code and if so provide us with the Tested-by: tag?

> That means that I am left with either accepting the series without any
> Tested-by: and/or Reviewed-by: tags, or I have to wait for some. I guess
> you are telling me that I won't get any additional tags, so I'll have to
> go in myself and have a closer look. I'll try to do that in the next week
> or two.

Thank you, I understand now. If Oleksandr does not reply in a few days
I will send the update with another board
(fully duplicating information for its base variant), tested by a
Libre Hardware Monitor user.

Best regards,
Eugene
