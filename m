Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5847EEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352621AbhLXLzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhLXLzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:55:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D554C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:55:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j18so17123173wrd.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0xcpi0Gitd25v86mG6F6era86f13f6qHaOx3JaAv2Wk=;
        b=Jb1E2qfhC1puRpMi6Q1ZzifIouvCGhE9PxgxYuTqMCWnqWRXhiCbyrOakGhZm9b5zK
         93yaF9Lu31EF5r3CFvyl+XwTHOpafxR5KRrSue2dGTsiAN7Pm+hIesvmqFeL4m6X4QsM
         Tv0Be197fSgjK1S5hczU4hWrsReIBovZ6qlhobfFlr0UelimWpFXg+uK3WFCpNCp8HVq
         Res88GuLYTcgLBPbpJ0yv/vgZn3mzSSvuEopldz6+dieWuIiUrOB+Kt1lw9LPUVhtGFD
         YQU6CaHGnBBW6ydj0V/Cu7dKOeagkdxZvt7zhVz8Sbn1hzHKWBOF5q4q2W13K+mXTMxK
         umyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0xcpi0Gitd25v86mG6F6era86f13f6qHaOx3JaAv2Wk=;
        b=wdvN7Shs5K2SgENM3IIkegHkoAt9kTWkDx+HbxUux/JHzJ26W93A4fG3LGpJiAdWdU
         dwlu85qb3XDPda46F2RdY9cnxQkxvswLRX4F+mDN1Vy6jHZEL/rcBqI9Q4v9oGYNpZiQ
         E8bazUy6a62Yo6omiZ3Kzc75EQ4Q/MiZTUgM7viznl2WunBQmW6aXcqGUSLX0T3vhK9D
         WMRN3NxCcRP1puzbSFsTBY6QfpxsakQRKaMtWzICoHnLCNNczPK4E0LLK6DRF2GAj9U3
         ndd9ynav/tMdGw3bDmyib7n+ngZEzFqp4BeLxPSWMWqNZNAr1/tb1zBfie0b1iHDGhaw
         d50A==
X-Gm-Message-State: AOAM5326UwbAl3TF/EsX5W/XlLKujz/ZIVV8xkZ6d8wGPq0lIZ8LaNur
        z6/6i1/bSpJnMbqZ3bsFuSCnEMkbWFbG0g==
X-Google-Smtp-Source: ABdhPJzCsvdI7GfNUjI1YJ/T3AOvfGvHVotvGVkPfECl5Rm8QPqkbWJmKa/QqxDA6GFj5QWv70EEBA==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr1867759wrf.538.1640346941695;
        Fri, 24 Dec 2021 03:55:41 -0800 (PST)
Received: from elementary ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id u10sm7697029wrs.28.2021.12.24.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 03:55:41 -0800 (PST)
Date:   Fri, 24 Dec 2021 12:55:37 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Melissa Wen <mwen@igalia.com>
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, melissa.srw@gmail.com
Subject: Re: [PATCH 0/3] drm/vkms: add support for multiple overlay planes
Message-ID: <20211224115537.GA9505@elementary>
References: <20211213181131.17223-1-jose.exposito89@gmail.com>
 <20211223203525.4sr7rjfq6l42il5r@mail.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211223203525.4sr7rjfq6l42il5r@mail.igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Melissa,

Thank you very much for your review.

> On Thu, Dec 23, 2021 at 07:35:48PM -0100, Melissa Wen wrote:
> What test did you run? Indeed, not all kms tests are passing and fixes
> are welcome :)
> 
> Last time, I used these testcases for overlay: kms_plane_cursor,
> kms_atomic; and these tests were fine too: kms_cursor_crc, kms_writeback,
> kms_flip

For the different patches I have been working on I have tested mainly
with kms_atomic, kms_plane_cursor and kms_plane_alpha_blend.

For some reason, kms_cursor_crc suspends my PC. I still need to
investigate the cause.

I'll include a table with success/skip/fail tests before and after
the patch on v2 :)

> However, I think we need some limits for this number
> of planes. I would suggest to just expand the enable_overlay option to
> expose a predefined number of planes
> [...]
> I don't have a strong opinion on an exact/practical number. I took a
> quick look at other drivers and exposing 8 planes seems reasonable to
> me.

8 planes sound reasonable to me, I'll change it and send a revision
of [1] as well using the new constant.

Thanks again for taking the time to review this,
José Expósito

[1] https://lore.kernel.org/dri-devel/20211223081030.16629-1-jose.exposito89@gmail.com/T/
