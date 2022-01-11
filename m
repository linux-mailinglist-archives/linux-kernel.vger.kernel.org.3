Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2019D48B2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiAKQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbiAKQ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:59:20 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BFDC06173F;
        Tue, 11 Jan 2022 08:59:20 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id i82so1762139ioa.8;
        Tue, 11 Jan 2022 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jv0wunLbiwTtF+YiChPU+JCOCA9nvaovS2Do/J3M028=;
        b=d0FBGryZs92aRe7WrvBGDeqfR/peyF39hb+xUNvHkCvZm4c+CxrD3FPL1GF2IZ0qHy
         bbqSKy466sBkWJ8LWchk7HPEvA6yzi/BZvBbW7RVBifFNaZnR4+9O1S0++JIYG7Bb9RZ
         YFHuPw+18ACtJuSFbciYYFUR84FZg4vBOVPuBV2/7WsN5wNeUMSUCXawjGgl3j1Yccdm
         udl1uInUOkRxIxWv7wdearx8XoLbMLOsUmyYH5SrJ5rphhaQkekX3YHbdgj2i9a5i2AG
         bFfB6124f6fS03EMcpoP6Lc761y8W6H0fdF9l2fNtTWy1/+l37Pc4Y6eR59V2loPTPt6
         5aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jv0wunLbiwTtF+YiChPU+JCOCA9nvaovS2Do/J3M028=;
        b=NMHyy37kZ7fUPBUE3brzocu9i7G1Sa3gmyGa7n9XYNcnltK51gskV92iUmPLNPDKw4
         tYjuYk9t9NlUZd3rEYTH3ERglUX8q9lQyeUe7Ahhkxp6Nkl4RBjnu6PIHcDB59H8aGp3
         JQO1BRgzBzVNSymtl2LkJJFJ0Le42pn4Qf2I3JcdvAHdM/n20HPS6/HJ+mzgoRa6qYFr
         C+Q29dRTEkPp1ym4nMdXDIOISLFU5BtdP/cXsgV5Sgj7uZpX1TswfaCiPc52vq0TzLIQ
         8yJoTBmaBYlBsw3fT9sBOkdFyyV8iP3nlxJF+ouEzfIKkrsCntML7ryeQ8DQxsH6xbvk
         ijvg==
X-Gm-Message-State: AOAM531vWh7C9QgZAbugqcLZoF8rGrfCf77ogpjUZe6dCWdZIcfLt1cf
        HMPPHEfOWD2+qxN0V/irOeYOUMJ7ofawkd6Gx2aX/QvsZ90hmw==
X-Google-Smtp-Source: ABdhPJyxXy/3yNyHwJKfhrQKD+tsvMIikupy4X1+xx37To2Tv+8dUXdwSWYA54RLwLP6pzgYNnPK3IizDX1yFRh25cg=
X-Received: by 2002:a02:6d0b:: with SMTP id m11mr2846842jac.108.1641920359651;
 Tue, 11 Jan 2022 08:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com> <a520f11e-c495-b456-0216-e57ad21c4182@roeck-us.net>
In-Reply-To: <a520f11e-c495-b456-0216-e57ad21c4182@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 11 Jan 2022 17:59:08 +0100
Message-ID: <CAB95QAT6ii5L2SBcMUMEYFPV0PQr9x0=5w1jPzFhx_iDk9+nqQ@mail.gmail.com>
Subject: Re: PATCH v3 ASUS EC Sensors
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

> Subject should start with [PATCH v3 0/3], and there should be a proper introduction,
> not just a brief change log for the last version.

Thank you, I hope v4 is properly done.

Eugene
