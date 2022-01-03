Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C1A483004
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiACKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiACKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:45:10 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80374C061761;
        Mon,  3 Jan 2022 02:45:10 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d1so77351259ybh.6;
        Mon, 03 Jan 2022 02:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VbPuZiW/1Qkzm5w7KW+G1qO7Y5j2xfvJABuQJzXu4eE=;
        b=fuaRNJKNrp3vE3uSHgjrdqCVm8KmM7Te50uPnH/Ks0UIQpYFDZbWUmZfkUcBIZQqPZ
         /fw87SCujq3gddXDwi+xTVxWrYw9exzOJt4Kb0iGuNYGzMSm1VBsezRHgYaFHSr0/I0W
         6U/dOL3UpvaGCJ7kiu7wbpF+u12biX3MqvE99GnVwq9sgNmxFySaJ/BXN0uBoMBDhEl9
         s1jP5LzLIZrFflAHF/9C00w8hPU5vtE3LWSLT+SLVUyZH1IzbKgjEvKzeMtRgl3b+j6R
         xnXxKlIYOq/fvqRFooXJcEkMRlaj7c6KZgELZNRipjCwe70TqrfIbwQBK2X2yC3gZPXF
         QrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VbPuZiW/1Qkzm5w7KW+G1qO7Y5j2xfvJABuQJzXu4eE=;
        b=srs4YI/Gae/u2Vgnq0gNKuxbV6gH9lYnMvZvrXPRWGy6lXVW/J63M2ZWtMxxX+NlMY
         qDfRaj16fYtMNXlyNCVfQbfpa2GGWXXSlgZtrhYL2WTj15D6X+xQeNhUN8YR8IB60WU0
         SLijOrBNxpomS3UfhY2n1G70q5pvCQQvT/X4am9WbcN+AHOPJeSGQbd/Ki0m8vUruOc1
         NJJ2NpTTs3Z3Xj6zMR9ozbs2M+s1Z46IbkZLXcXya+FHcON6uRgO8pyM9tl8VqigXnJx
         TSOAHBE3L55D4mimRxnvA/9ZkuCSMXjdogfJGnSo4u3lVIHt14dX27GfHDcSTMLlPAM9
         l9gQ==
X-Gm-Message-State: AOAM530w9PItB4mxggzX90pzb5Age/5JZ71muUz3+XsnQoSeXrBImEdu
        14Xqtd8mZYtVL2UKcxPJUw6dWta3pSfYK9qKM4aB1aWSXFM=
X-Google-Smtp-Source: ABdhPJwIrrCOZiixswFFGbjt1p5pJZZ5VD1zyAOhh+nu8/z+9NN2n0DbanaszwWOuuUSLDqwO5gAD0aVxqAZAL/FPr4=
X-Received: by 2002:a25:cccf:: with SMTP id l198mr2515418ybf.608.1641206709699;
 Mon, 03 Jan 2022 02:45:09 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 3 Jan 2022 11:44:59 +0100
Message-ID: <CAKXUXMwARdtgBQ26vB2c0gubgc5P08xfwyQonrG_D+p1iNDLxg@mail.gmail.com>
Subject: Reference to non-existing CONFIG_CPU_H300H
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yoshinori-san,

In ./arch/h8300/include/asm/hash.h, there is a reference to
CONFIG_CPU_H300H, but CONFIG_CPU_H300H does not exist.

Was CONFIG_CPU_H8300H intended to be referred to here?

Best regards,

Lukas
