Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC149031D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbiAQHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiAQHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:47:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:47:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso22172182wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CymbHoqMdrBbxQE7Zla/8QpP1TV1cfWwuhrQrRdnQa4=;
        b=Jbtj3zW9qmlT0IcgcINehtnVuaCSqm4lkl3DLMTIKPJ+s9zFC9fT5eglDuqC1Lbu3u
         /aEZiBa4paZRCgkYmrKs1mfkNIr8CyJD8pBeFE+P+mMzOgpQVJ+jpwKGLY7sLPL6gD+t
         HZMw7IyqfOaevDTg7qmpt2LwYG7z0BOxqjkbKU2HGdpg9Qd/59tdiGi3Ntpx+pKG0izG
         xvaseFpuW9jSsKUrk2POWsdoZW0Hvs1nbv9ecARr+63rB4t2zTRT1ffKCzABKXlXFiEI
         GXkmjfuMVWEK2kYM8mAatCqJD1FCLl7iy6Op3YmbYcB1sxVmD+FABbLAK0Z1XS+ak9Dj
         C9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CymbHoqMdrBbxQE7Zla/8QpP1TV1cfWwuhrQrRdnQa4=;
        b=P63LiKb2N3MFBcrskguWen2vORTbdN7FAwqzrmspp8dTK3rXcDubNxCZcPdDCH4Pxn
         +X+JkyrNCojWA0U7Jcwa4dGMxqFvB2T7nMMm6+/Lk9Ly5PtxVRLjU+XQJ/r7smAtzL6J
         6LpEH1BOXlANu0wHIwZHd0LGTtYk34mOgmdssr4+cMXt+98bUqrpd4FHv+dPz484f5R9
         9eYTA+LsZgiPODUT8onICclf3C3imHHliofJneeDVPkaosixify6nGQjpXt7Tke/ClTV
         dPQXiU2VxjVkt2fNk1KdIwFr0WJqzPLfOVJ6RGoNHi5+7hk/zCwqV2MMhKR+mZ6OADVO
         qc2Q==
X-Gm-Message-State: AOAM530v8OEbLF2rSN6hW8MrdD5e/qlYQienUPd6lf5ok50FLwE3sG2T
        WqHXRJJdhBIYwoJPjXVVubc=
X-Google-Smtp-Source: ABdhPJyziHpYsFWrFgsO41TYBFZlkgF53Vtoxm7r4pRIMmuY7QwKRc+HBJqXw/xjm23OHToC5nD+0w==
X-Received: by 2002:a5d:588d:: with SMTP id n13mr5233368wrf.153.1642405640361;
        Sun, 16 Jan 2022 23:47:20 -0800 (PST)
Received: from localhost.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id f9sm14591166wry.115.2022.01.16.23.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 23:47:20 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     ytcoode@gmail.com
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] tracing: Remove redundant assignment to variable ret'
Date:   Mon, 17 Jan 2022 08:41:17 +0100
Message-Id: <20220117074117.3770-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220116144805.102999-1-ytcoode@gmail.com>
References: <20220116144805.102999-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yuntao,


when you consider removing dead-store assignments guided by some static
analyzer, you need to check if the code you are looking at is actually
missing an error-handling branch.

In this case, ftrace_process_locs() may return -ENOMEM, and the caller
needs to appropriately deal with this error return code. Your patch
does not change the code at all, i.e., the compiled object code is the
same as after the patch as before.

Think about how to deal appropriately with the -ENOMEM return in this
caller and submit a patch that implements the right error-handling
branch or argue in your commit message why that is not needed at all.

If you do not understand or cannot check such basic code properties for
dead-store assignments, it might be better to work on some other aspect
and area of the kernel repository. E.g., the kernel documentation build
also has a few warnings that deserve patches to be fixed.


Best regards,

Lukas
