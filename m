Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94E465537
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbhLASWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbhLASWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:22:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AE8C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:19:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so104797658eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 10:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wizery-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o85HKBKb6iNjw5vYOzVGcqogGstJArNiD6jjf44KFJE=;
        b=tgx1e2s2lLy0430QYrRjCD0sfIWJ0kac0UfYZqqRfJrY5AYcvI9rMpQ62TArlhUzlt
         23SSl18PPeAAo9LzLGcMXML2CXEvhOfxws2A1bmyPwAf+xRJnP2yzJoExhjOxGAl9oOH
         zdvUSXQyj+Tq3zg0rWZPLezbCrejuCRKjmOV5AxQk1A0e3BZpkOBt3KDC2X2JzrYFVSy
         7r5cFzvNUHSndCkGNuHioVPMHxzDNs/KNWywvo4LG4JkwhxZzkJlq3oWZa0vQoIElG38
         tQiWfb1BpYyCg2xXrFZQK9M0LPqU/QW07OxGQslYRaqauPbMfDd/2mI8fV9daBKgBaOo
         C5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o85HKBKb6iNjw5vYOzVGcqogGstJArNiD6jjf44KFJE=;
        b=frHIqTozs0GikpEWRaeyZ8SX9ykz3meom1tGGdwygNDfWLVqc1o1mhRZgGLLh+e0GO
         teyKQZtPd3v6yHnXQ+p+rfTTCofTZdvGwohIWjRLUNPoEQNwPG300qHTPSzLH0WIIH1o
         x6t1qZHx+AJQbC2w//G4Xa5LRBnlcmylxKjujADdbzGR5a1ZxMc3m00vg8rprmhvJRzf
         R0QfTxKRuD0thChbyP4TasGd3vUPu1WhDT3J61LReBDtc9sN/lgefpkxnL9NSYfw6S4U
         BWkYFT16ZhSSt+4Rq2y+0n2ButegBWkdRxdpR98hqSX403bABGcRgjE3Sz9ifO7H6uWQ
         qkcA==
X-Gm-Message-State: AOAM530QuRMi0qlGps1jHNhPYVmchnfLNnBLSADhFN7iGyZjWr1achGu
        PafnnkeR5J6k6aK2l8cRyzTZrzmXiNv+JnDnVJZyTA==
X-Google-Smtp-Source: ABdhPJwKZUnM+NrfLH9X/wIZ/VWM0oqasJ3L0uc5fSX7hqgEgo/dm3l0jQVbWI5XNwftrSkkXqNWAyJ2ZYL2aDavxr8=
X-Received: by 2002:a17:906:55d7:: with SMTP id z23mr9003066ejp.393.1638382758071;
 Wed, 01 Dec 2021 10:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20211201175345.865408-1-mathieu.poirier@linaro.org>
In-Reply-To: <20211201175345.865408-1-mathieu.poirier@linaro.org>
From:   Ohad Ben Cohen <ohad@wizery.com>
Date:   Wed, 1 Dec 2021 20:19:06 +0200
Message-ID: <CAK=WgbaQrgfvOsdqCq4JA9OOQK=kGTarP_FEKyndc7PZ_g-RTQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Removing Ohad from remoteproc/rpmsg maintenance
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for the patch, please use the below

On Wed, Dec 1, 2021 at 7:53 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> +N: Ohad Ben-Cohen
> +E: ohad@wizery.com
> +D: Contribution to remoteproc subsystem
> +D: contribution to RPMSG subsystem

N: Ohad Ben Cohen
E: ohad@wizery.com
D: Remote Processor (remoteproc) subsystem
D: Remote Processor Messaging (rpmsg) subsystem
