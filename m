Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9206648D260
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiAMGjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:39:17 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41132
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231248AbiAMGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:39:16 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D1E9140033
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642055954;
        bh=Z/d7ON8aStCCPS5HD+SrrIVpBpxi2CdKa+GaDG4iK0o=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Unf3GggJb9/z+ZWX4zMCO3vyZ88JE0j7Tj1rgYF7XhjtSx/SgoAYre4OGmrUHr4JF
         09L7VgSs1lxZV3sFTrL46b2PlqAxzn8pYUOuYr851gZKFB7Y1LtoF1b8LogpTOLZtH
         EZoV+ROAb+mogLwMnTnNyd9jnqhcc9KN24XXIQuegrJLT4he5xbsrUb4vYvbTeHbcL
         iJvWa6osQwYBKYR8bW97+D1YNoj6WNXNeYWaIqhnEAqs7+x1LBDNchZv7olsx02rnr
         yULzQZeyw19N7DDpdko9/GqgoQ98pQEDeIukiTQi7tqhz8mzlkvRQxBphZkOoebToS
         gsZRB19xujorw==
Received: by mail-oo1-f71.google.com with SMTP id s14-20020a4aa54e000000b002db004adebdso3450672oom.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 22:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/d7ON8aStCCPS5HD+SrrIVpBpxi2CdKa+GaDG4iK0o=;
        b=Xiszxn8QUCq6nobLdvHy3Ihp61f0hOA0jO8fBPerb+y0tqnR1MiE9apxn49cmUBeuO
         EX2CeSh/3EcWvblpCjRZAGfuqaUCmlucBm/SYBaGA0kOCkEZw613GPP4KouZIpYHI5lc
         0yJbLHqqPN3Yq4L45OfbZjrBODGOooN8RcpW7wwjhGtEDL+/kHQ5y07vpN/dU8KzNRFE
         oVPwKYBN0a1WHqvwvYGfYh8ik2m41smOEMD2Ycv87HFFlXgidHbTFWVX84xn6rWCwKAL
         if02a20v00TEtpE6GPSHa9eihpKfpemdUEmxHJktx3cTNE/LXuOhnylk/CrUf1NMyDGa
         JUvw==
X-Gm-Message-State: AOAM5322wfnViqQ3DHyU5igPYEl0bvNtItt56VyDQYGKxuptlNDC0+FM
        A7f4Ouf230bEnw8EPlyYDjlbUTn6wSKFvOkJXMeH8uHQYtDmf3YneD81Lf4reF1xMBQA1/Tpsy+
        9KHk/5An+0Oq5Wm5A9C2dUU/YrJ/TghUD8hab+Yk9ty0jtMcpxfjUR6uGaw==
X-Received: by 2002:a4a:ba90:: with SMTP id d16mr2034220oop.80.1642055953616;
        Wed, 12 Jan 2022 22:39:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEMpazgYUKs+xSD8KDd1iXrFDQ8M0eRXsEmPqcnb56gtzNC3Fy7zUJntyN9v+/auUMk2mULVsKUj/6+1novVI=
X-Received: by 2002:a4a:ba90:: with SMTP id d16mr2034216oop.80.1642055953371;
 Wed, 12 Jan 2022 22:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
 <20220112071659.GA4502@lst.de> <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
 <20220112140304.GA27446@lst.de>
In-Reply-To: <20220112140304.GA27446@lst.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 13 Jan 2022 14:39:02 +0800
Message-ID: <CAAd53p5Qo3+-sXMLLPxe3ckY4ySxRvaLZkv=0zgKc=EVun9uYg@mail.gmail.com>
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 10:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 12, 2022 at 08:50:33PM +0800, Kai-Heng Feng wrote:
> > USB thumb drives also use this flag, so I am not sure why it's not
> > applicable to NVMe?
>
> They shouldn't report this flag and might need fixing.

So what should we do? Introduce a different flag but with identical
usage for external USB and NVMe storages?

Kai-Heng
