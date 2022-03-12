Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B95E4D6C95
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 06:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiCLFLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 00:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLFLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:11:02 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527686CA45
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 21:09:57 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id z85so11622718vsz.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 21:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3jXD08skrPZKqzTSkABEDqn7CXZy2e+Noa+0zE1i5wg=;
        b=A7cE5wvfrubOotIyaQ3917KStOx+SQpgwOOnBn7s9FiLSfJB+9oQCI1Mp8qFrPsUfs
         HYvjHPbH+Gi3sDannqPAWgee1qIyJIkfT3U4owzr7Q/QUpczbXHrYsuIUZBSx8FSbnyw
         kTjTgVIhKt7i7rnLE9VkNpuQSi8myvmgj95DVG67tQ7Hsx+jOdN/5Rn9IS05wV1gKe3o
         NmfnWZk279nQE/qfnQyhM10AnV8FfEd2rwlFY+a6QzJgRbIVRYbB7Q8tKXW+7FobhFKK
         x9pnjDFzEQKP8sbdU1uYwckNFv4EiZmA0zFvSAJrb6XhfrDaa3dEt8TiD5si1X2zAAky
         V7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3jXD08skrPZKqzTSkABEDqn7CXZy2e+Noa+0zE1i5wg=;
        b=W3tO+Bq1+zMhd9S3KPM63xJOnkNvjPhQNFYbgi1iZuIImHQZeSd9cKwB3VwCQwtk6C
         Ob6+SeqJl5zguKsqh9CLoQMiWoAWgXMdaV/dR3iePWYQpiQQXzj+eErgZgY6E3s+mzDw
         Im8jp97ZQ68c8+2oY3nUsBeS9026y7IBbxrTmKs2wxSb6CyXl/3nrn2Jjj0VVMKaxPeL
         3+ihDUmySytehbIE/mUTMYcJVU65RAQpj8h4D/zx/9H5f4KjIbmiJBcnwVV7YJjzkzmN
         P68gnDUGwzWNujh6er624asmlhIS9uy+AW066WoXrjX/NMmywWLtm9CXvyiexa8uXXjr
         O1zw==
X-Gm-Message-State: AOAM533JBOADBLw3zUzGr+qOJ05/SvMBJzv3xHbIX3HW2Rr8eKomfLhu
        vdGU/ZdSLf0Ybfeve80YZS5FLsG03gwC9DpgTW8=
X-Google-Smtp-Source: ABdhPJxXb6ejKuPJanJShCInWHdELwYTN8Y4FQz0TXfxUeOEDLpl80U+osjypbrZ0/EjP6JvKxKOEewG2vYEDusuWio=
X-Received: by 2002:a05:6102:40d:b0:322:a0f5:c8fe with SMTP id
 d13-20020a056102040d00b00322a0f5c8femr5510304vsq.40.1647061796417; Fri, 11
 Mar 2022 21:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20220311074413.14644-1-yusisamerican@gmail.com> <YisE6jjbzJyytqB8@kroah.com>
In-Reply-To: <YisE6jjbzJyytqB8@kroah.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Fri, 11 Mar 2022 21:09:45 -0800
Message-ID: <CAJoG2+9w=GP9=+d=pLuNRoR7USH1V7f=DSPURxnxotYs_CwW+w@mail.gmail.com>
Subject: Re: [PATCH v7] drivers: ddcci: upstream DDCCI driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, javier@javigon.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How can this ever fail?
If ddcci_verify_device() fails
> Not needed, just do not have it.
I'm assuming you mean the locks?
> This should not be needed in sysfs.  What tool wants this?
Its for the idSerial and modalias part of the userland interface.
> Why "_void"?
suppressing "initialization of =E2=80=98void (*)(struct device *)=E2=80=99 =
from
incompatible pointer type =E2=80=98int (*)(struct device *)=E2=80=99"
