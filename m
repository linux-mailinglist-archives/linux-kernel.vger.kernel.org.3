Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A30476DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhLPJpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhLPJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:45:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BEEC06173E;
        Thu, 16 Dec 2021 01:45:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s1so8932743wrg.1;
        Thu, 16 Dec 2021 01:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ARN4qeir3Hz4c3b/QWXg3h+IBfZ0AX5ARmmNbEMD7Bg=;
        b=j0vD1zZLVa8psUzy5p/QOX2FqK+FVc6pWNRPLwbPdsMOjQVTfyuSA/zGc4t+j+FSAQ
         fZCmaFjE0Ffel/LFeaAVrQqMg4/dvvuoqiC+qfV4Ai11W/X0igTRNoyIj7q36X/c0gu7
         SpL7mSlWWiBnyKip4f577voNtQFgbaawN/7+IQ+6ZwpekyvnFpQX4f+L7IMiWmTegT9D
         SVBabQ3M6MUmHEN4rMkhf+Y+20RdfdT3yB+uWjUnif80Uk1AQ/oIiu6msPHcv6QSs9Tz
         FQ/Sl23i+zDy15ar70TbUbCq8MVAxtXniu7P43mhsTlQMiKZIp49sNPLC253NnMvv3XQ
         BPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ARN4qeir3Hz4c3b/QWXg3h+IBfZ0AX5ARmmNbEMD7Bg=;
        b=JLgBdQxtd4SFDBn9iutzfQtX5mgKZlE9YTS8IT/BUf44SZRUxXY+4IW3/twyIx+cfr
         6UkYU06ct/jtZbLQ+1fVuVt2y4fLO2CWv2chOVtVe9g47sV/ZD+8QSal/Tgjc3r06BC1
         xmSlrurlhM6pa/25YBXoFznB7DQE99/lOlZ8yiNGYmuaopkgCkDm140ncwNiZi1DCJpc
         zDouYKc3ZgrxCmaGYZri2C2MJCxrRdwuLj2Mhm2XqMikT2pIVIUhLNCL7jbFMFBOP7zY
         10g0TMb/GqbZz1ikveXVU+7VW9uYj8um2pJWb0he/1wQKwYE945B0EWLJBMoZG/cgdJO
         gOMw==
X-Gm-Message-State: AOAM5314kHJ44TKrzXFGzamZKn8oN283TfDpb1KKrxyCCmKfrOmb2c+i
        U2UUL1BDlNfAI5/4q4XyONY=
X-Google-Smtp-Source: ABdhPJwbIjTPzZFy8VT5f8JT2Une97QMgC0Zd0FEEOycuRTMmUs5Tfgz4ZnfOy19zcLP6lRHpdTVYA==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr8196312wrm.173.1639647913304;
        Thu, 16 Dec 2021 01:45:13 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:267b:1200:18af:bb55:aabf:94a8])
        by smtp.gmail.com with ESMTPSA id g18sm4294270wrv.42.2021.12.16.01.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:45:13 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drm/amdkfd: make SPDX License expression more sound
Date:   Thu, 16 Dec 2021 10:45:03 +0100
Message-Id: <20211216094503.10597-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b5f57384805a ("drm/amdkfd: Add sysfs bitfields and enums to uAPI")
adds include/uapi/linux/kfd_sysfs.h with the "GPL-2.0 OR MIT WITH
Linux-syscall-note" SPDX-License expression.

The command ./scripts/spdxcheck.py warns:

  include/uapi/linux/kfd_sysfs.h: 1:48 Exception not valid for license MIT: Linux-syscall-note

For a uapi header, the file under GPLv2 License must be combined with the
Linux-syscall-note, but combining the MIT License with the
Linux-syscall-note makes no sense, as the note provides an exception for
GPL-licensed code, not for permissively licensed code.

So, reorganize the SPDX expression to only combine the note with the GPL
License condition. This makes spdxcheck happy again.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
I am not a lawyer and I do not intend to modify the actual licensing of
this header file. So, I really would like to have an Ack from some AMD
developer here.

Maybe also a lawyer on the linux-spdx list can check my reasoning on the
licensing with the exception note?

 include/uapi/linux/kfd_sysfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
index e1fb78b4bf09..3e330f368917 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 OR MIT WITH Linux-syscall-note */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
 /*
  * Copyright 2021 Advanced Micro Devices, Inc.
  *
-- 
2.17.1

