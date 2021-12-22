Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6056647CB50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhLVCQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbhLVCQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:16:32 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E98C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:16:32 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bk14so1652336oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjvSc6Zc+phiwllv9IBUiUWQ+4eYlzKIjbFvpbNL+r0=;
        b=W+tvuM/1MFvZJZ9ZafbDYJu8HqtyQA3TB2JNiXiRXlaYEY4alQSki7xDIF/FvRMHOf
         lZWRjnaMueYhqE7/1bk6mDTjMlRmQZK/C2GLYaaHUhIuKFarJdVLqJYADJ4wU3mgU9/U
         TfmfIobvYOFKcm6LEfXy7EyUMWMXsjOEpJ+6712KkGOuzcJV4Grw4N4vviZ97Fd3ubEy
         j7LTyp4hQqWazdagNLbVQxQ7ov6OBxfo4+lZiYylI8NWSigwxdVHHWLghvCY1vQ+TSM5
         lRjqj3br36pUrWkgQCgOMEP6aNi3PSZtd0kHed7uqn3vffZLmJrV25lUMGg8PSVZUmmW
         TbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjvSc6Zc+phiwllv9IBUiUWQ+4eYlzKIjbFvpbNL+r0=;
        b=Cjow8ituLoKNh7xEMDveW9zN2WwQsfiIWTrAhIlSnd18QKXaVW20/pNBJQi7u11c+G
         GuW0KQvRDprsi6tB6WvBhZ1MzJrOKg90Iivf6T2zSmGG+D4fEbXHbsj1G2onhld6CjW6
         EzR6mbaAMXvnhRl5T8Ue73zqMZB5i0SsgbxaXfrUVVDg3SIE11KvXVX/+WQ0wEQVNNiv
         sSGjfCWvb9l2Mbvco2qpW/tNOBsHq4i4ktGwQvLowZTE4jVFQDMHwHi3NyzNL1TQy+Gv
         UN5C84UltM/pRJ00zeI060hM+2G55UlUI4VqikYUpc+FjhJaeW1BOxY6XTH75gyGDv8f
         uuwA==
X-Gm-Message-State: AOAM530beCkJP/axySgcpS5smmHT78geTptoP89MwevcI6Oyi6/2e9yp
        5cjiRX595M41N6w6xs3Ck4pJqyRhUnDBrc76rbnJqcEQjp8=
X-Google-Smtp-Source: ABdhPJxcTE0tRvTBllqs3cr0F9sO0zZeXMvsl/bZflqBg+hsNfi88xkWkosuNmr2F7f9aKL6ThDkerca0MXJcliVCvc=
X-Received: by 2002:aca:5a87:: with SMTP id o129mr728405oib.114.1640139391889;
 Tue, 21 Dec 2021 18:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20211220062406.108789-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20211220062406.108789-1-yang.lee@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Dec 2021 03:16:20 +0100
Message-ID: <CACRpkdbfJY=NKgZ3GcNG9QqrFpCkQpXMmLcWJ20EcPuQ6WfVdA@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: starfive: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kernel@esmil.dk, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 7:24 AM Yang Li <yang.lee@linux.alibaba.com> wrote:

> Eliminate the following coccicheck warning:
> ./drivers/pinctrl/pinctrl-starfive.c:1029:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This patch is not in the pinctrl tree, I guess it is in the SoC
tree and need to be applied there.

Yours,
Linus Walleij
