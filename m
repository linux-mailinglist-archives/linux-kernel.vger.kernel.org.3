Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4432488850
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 08:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiAIH31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 02:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiAIH30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 02:29:26 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6431FC06173F;
        Sat,  8 Jan 2022 23:29:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so18746525pjf.3;
        Sat, 08 Jan 2022 23:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ABpe723VdAG++mLmVJtQgfj7bdVAG98VviWIXnTdgFs=;
        b=ShMud7Z/8D2OTfAfGGcEKU7KgASpM7hXksFB6AYWLaTxPnau4Expe7kkW/MUSmXbls
         /G/t23YJN6P8kMGDaEP7ZxgBSNJ/JmxHQNSSbDieN6OZle9oUIpYJh3RQarh7SWc4H5J
         DIXs9WQR1L8Uwaiu7gaOO0QHQvNL9gZDugfc02hYYbzBh+M9gEzLCCKAVg+Ut30LjZyA
         xIB6ZnJiuHvW1BHAQ0nYhFdrabNAYu0t4wUmiV2/2tze0nWpWSk6q9ShcBbg1RJCJ3mA
         0mVRVxgwbxjE46im0kXtWJuCUTUkeUgM5mVGlx4OVCYM+ktRhnKxdzDz6G8eVucWpUW5
         1UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ABpe723VdAG++mLmVJtQgfj7bdVAG98VviWIXnTdgFs=;
        b=a36XotZjl+8ttvklsPumLt1AahL1Sr5qWWt5UxsFrj/I/hnsK/6e/n1ut/Q+4jWDD4
         eX2+P1LreZhEJ2D+8DUba0KF2opv9WphxOShf+ymEqHfnZwBNcXCJ4fl5SDoeF4N0xfF
         PQCReE//togprV61ZkLXvDZ90Fz+GF8+yv1p3kRNNNADI/KPtqRTUiWTQtb2W2v1FuBx
         frrUOKClcA4oQum0H83DImO3CyUhlgbKv4MdAvivxdVo3mKCJxz5RKc/dYKuKikx7b0D
         he5RvnSEB8m16YFPWMvrPdlmmrSHvMWOqhzGyt8FfJHHYQ9abP+acMiQWNnarAQGQSI8
         b8XA==
X-Gm-Message-State: AOAM532sTqfCQqQOdLgVkO1QSzWHFkhPHzrhbQ4KhihiI4RGo5diQyIc
        z+uHAeotn0+b1Cu4istZb5w=
X-Google-Smtp-Source: ABdhPJxh8aDsuNV3cqiVjXy2QBqDupJcQl44+BzuswPxChCYjaYIa6osngPfXnCWVAvYizROVzDhjg==
X-Received: by 2002:a17:90b:4ad2:: with SMTP id mh18mr24441490pjb.197.1641713365790;
        Sat, 08 Jan 2022 23:29:25 -0800 (PST)
Received: from google.com ([2620:15c:202:201:1402:d240:ab6c:2258])
        by smtp.gmail.com with ESMTPSA id b2sm3079880pfl.138.2022.01.08.23.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 23:29:24 -0800 (PST)
Date:   Sat, 8 Jan 2022 23:29:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.16-rc8
Message-ID: <YdqO0p960x1KT/bo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a small fixup
to Zinitix touchscreen driver to avoid enabling IRQ line before we
successfully requested it.

Changelog:
---------

Nikita Travkin (1):
      Input: zinitix - make sure the IRQ is allocated before it gets enabled

Diffstat:
--------

 drivers/input/touchscreen/zinitix.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Thanks.


-- 
Dmitry
