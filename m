Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB357AFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiGTEOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTEOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:14:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923FF23BC5;
        Tue, 19 Jul 2022 21:14:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r6so22215714edd.7;
        Tue, 19 Jul 2022 21:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4wCC2ziK2kF2VlR2ekC/uKsZFKJwFSO4tEAOnLZG5Uo=;
        b=aEC9Oo6ouQGRXhMSpqPmXCX734hUnnYa9W+kPiLK8L4rm6G4So4zszJbipvBE7w/p3
         pmpX065Ckwm8gvvlH/I19LrGORmHW4gdi9jUchB2GrVpNQCp8i0up8O4NNrj9I2iNOKt
         qYLCLakrEFVYtUnFkSpWoCjEJ61iF/W9Fs+nTYum8dnToV06dZgxJEPFHcqhGGm2OqWN
         fxs1MsUlHdSdiZC2ISNrSPNQF3/48jLKzbgxF1cM2rz9wLLMeNIDAfRYpW2g+hPShpor
         llzn5SuTQiKPrjL4ijKcga/N5oMVeoiSYkqURsJnPIrgHjwcddzFcVMvkHC3q25wYsLv
         mRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4wCC2ziK2kF2VlR2ekC/uKsZFKJwFSO4tEAOnLZG5Uo=;
        b=ZNr86BZGvWaKtZZxMv28ZUwxqPjKo+9uIriyT/4svqLmIiYoIvx5eq2JUrvvPHvP/4
         FmwVyt2EwyVhEMPYQE6ZPx48cVfRKxcf8RWm7AeV8GnII3y9KCfW3Jq7oiXaYpSzAMcS
         d8IUsmzZU03HWBldk9yV1zVXnsn9vg7W6V91/RElx9od5ZkAkuF18qobHU64mkWi53FL
         uZYMu+i1tWlGlI86NL9/u1zzUnis9Fef7905RNhrwabRf4+fCnjD1gthmGC5amMZVKfn
         o3SHsn7xdMAZbNIIHaMNBSoCzYGQCcnuSlBq3JaihssW59YT3fmvTqF8k/7snmz87wZH
         KTSw==
X-Gm-Message-State: AJIora+XaqnkEBwiiIyM67E3LUCKkFEXEvZyrdjuGQzDL8x1cIMNN+Nq
        bWaaBmVHD2AuCCwo8Fu58z86l9HRVEI=
X-Google-Smtp-Source: AGRyM1u6zfG0GZgFwJ7QJz2BYOaBDGY4e0H7/4hWHIjNFtbiz1V6t+m7YS8GFIgk+5Edc8pffXTfoQ==
X-Received: by 2002:a05:6402:501d:b0:437:e000:a898 with SMTP id p29-20020a056402501d00b00437e000a898mr49418298eda.265.1658290445164;
        Tue, 19 Jul 2022 21:14:05 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id t6-20020aa7d706000000b0043a85d7d15esm11512978edq.12.2022.07.19.21.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:14:04 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 1/2] docs: admin-guide: do not mention the 'run a.out user programs' feature
Date:   Wed, 20 Jul 2022 06:13:24 +0200
Message-Id: <20220720041325.15693-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720041325.15693-1-lukas.bulwahn@gmail.com>
References: <20220720041325.15693-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a.out user programs with the latest kernel release is a very rare
and uncommon use case nowadays. The support of a.out user programs is only
remaining for the alpha architecture and is not defined and activated in
the architecture's Kconfig (so even the activation of this support requires
to modify the Kconfig file and not just kernel build configuration).

The discussion on a.out support in 2019 (see Link) shows that the support
of a.out user programs is just remaining for a special corner case from
some (alpha architecture) users.

There is no need to point out and mention this special feature to the
general audience of kernel users. Delete the reference to this historic and
special feature.

Link: https://lore.kernel.org/all/CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/admin-guide/README.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index caa3c09a5c3f..b78fe64b39f6 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -262,8 +262,6 @@ Compiling the kernel
  - Make sure you have at least gcc 5.1 available.
    For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
 
-   Please note that you can still run a.out user programs with this kernel.
-
  - Do a ``make`` to create a compressed kernel image. It is also
    possible to do ``make install`` if you have lilo installed to suit the
    kernel makefiles, but you may want to check your particular lilo setup first.
-- 
2.17.1

