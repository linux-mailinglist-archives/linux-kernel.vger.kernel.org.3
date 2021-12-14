Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7A474D58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhLNVom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhLNVol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:44:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36454C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:44:41 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g18so18929920pfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THxExHrYQURfkbRhwNTeSsNawMahB6ZzIhBW5VwbCz8=;
        b=Hi26RILjCjVTH05HqzLFaqMSw0rNSQ0+0z7rtvpA4aUVKJ2BEAH8tKz50eXKEuTo5p
         ojCqEyvrgh4r91X1ifkHklF/64ARzBfbP1D0iU9RMqgbQPUaM5pGDKecP6u+q2Z9J5od
         tqOXHgmlFVhHPdDuFh0urhabR1bkwZK6bE28jT3Ucgngdz/DXx9pt2cTzmK2SPm6ETOq
         H1uEPjlhDVtjfzdchS92K3aZvLSmlLRLnVH7RgsbqMKzhSt1LxvvwoSSiZKVLKcwG8N9
         I22d5AVgwcqjWcaYYHSqyV7wk+GsMGt3B3ZuzQGxbWv+C67ubV+fk6kIG5l766IX/DD2
         EqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THxExHrYQURfkbRhwNTeSsNawMahB6ZzIhBW5VwbCz8=;
        b=H7TMq3B5CzPlWClE8z1CHVUXMp/1gYu6cBO0h4yueOcLJvLxdc/chvfe9VkYClpbsG
         XnasXJT+laEp3w3DXjlUnHY+wTOWmjw4oE5CQc3Imfia0QJ4OJChHU3HK0u5Yo5vcu0h
         j83VtqxTm2/QmVMNITs+Y8bzIJyiEDdVU8hYLUaebP65KUvKjJVWh6A3IHaktT/812or
         xQLbV4dFEvCR3Tw2cCtCn8dLBWrjOJpz1FcP9/LjX1Cv1nYYnc2Lfv+m2/Q+bGig2o2q
         sYMMvhiEazPwBC6m8D9nkaWlC9B+vgEn05QzBF9FMuRygMf7X5K5gS7inaAOdpUhywbt
         rgqw==
X-Gm-Message-State: AOAM532m+twQLjc+q+2Zm16ytDSak3DG7IYS/RMGluTwsV90LZps+782
        dTgAVCwzGR+3gEJhOjgPRJivAmtn7C6twnfDar/Szw==
X-Google-Smtp-Source: ABdhPJwELAfVoYCnTMr+UNfbuTuFkjTNGyP6zlMgqmFaPs6bjaOxUR0h3dukSOn02ZhkE8SFVBYr/ukf+xBjU5N7KjQ=
X-Received: by 2002:aa7:96b7:0:b0:49f:df90:e4ae with SMTP id
 g23-20020aa796b7000000b0049fdf90e4aemr6263532pfk.24.1639518280544; Tue, 14
 Dec 2021 13:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20211214192612.134306-1-dlatypov@google.com> <20211214192612.134306-2-dlatypov@google.com>
In-Reply-To: <20211214192612.134306-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Dec 2021 16:44:29 -0500
Message-ID: <CAFd5g44qB7emcsV_QCtddUcFdoxVUpzoY_fgmRARfDwS3byNMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: tool: delete kunit_parser.TestResult type
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 2:26 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The `log` field is unused, and the `status` field is accessible via
> `test.status`.
>
> So it's simpler to just return the main `Test` object directly.
>
> And since we're no longer returning a namedtuple, which has no type
> annotations, this hopefully means typecheckers are better equipped to
> find any errors.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Looks good. Thanks for the rebase!
