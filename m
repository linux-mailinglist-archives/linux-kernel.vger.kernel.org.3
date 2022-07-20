Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B857AFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiGTEOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTEOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:14:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB35323BC5;
        Tue, 19 Jul 2022 21:13:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ez10so30810951ejc.13;
        Tue, 19 Jul 2022 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zjj7340ZvsschDyfoJLUbFZMbu4BAOYat1cxfePijEg=;
        b=mQzbPiSOn4z58rBd4iunQ4pHfOBgbFud76V/FZjolse7vmiCbS0jULAMwmHC33mixe
         YGcRZT3XJIFTFhYpX8blWAm4fb8ThYSIC2bG1X8p19XcjbI4KZHIBg0C/2qVdwkSt0ry
         b3OGLIIw/iQ/I4R0WBniCNq0OlS+H5iz3zBuiiEjMQpBRBJLyFRVQspCK7robc8OQvbD
         9IN+fd3fY1qIEzRQAZ4bc7cG24M6LJfum1jY/ts9p0P2b9w5NzN8f/sr9AvUfeLKSHVk
         Nj8CuYLnrjfNfZnDE4Svj715ihq+EDK7UotXPPr6TKV02hagOXc9JVVH27pB1zcgcdsf
         8lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zjj7340ZvsschDyfoJLUbFZMbu4BAOYat1cxfePijEg=;
        b=xt4jy7RfcZ9XroXnow4OQgn1c0yE/C6dy5jyHxz7FISu2XlCcUbhDYlyYNsgK99t/n
         ccVUwitQ4QWe1GpqKBkyRgs3zswq+2IL7NhqSmez+9rK0p29fApaJCtyeKaPBsPI71Co
         Zu3kDMTLFJvpZVtUzQaa7CRrdUU7brFqQagZPTMPHMmvU8eWFsizGzNmAtJEoqFwqxlL
         fdesH3KCwhvmLYRNWb9LtOiyjUwPZgD8e8sV/trMggu7iSecSz1yqS90CAanjd/wjnPh
         28fteQ3fbLz+wF2XJ/IgXKIzoD4ZF5wv73jLVkegYh5yIapXc3TOKnjX+Fae28/0n44U
         BQxw==
X-Gm-Message-State: AJIora98sSOVROIRto0zq7zfO5wyXQLFCT+BINjgIB6OTLa+s1ZhuAYj
        obj7hbRapCkxOanbzCZa5NE=
X-Google-Smtp-Source: AGRyM1tLigBTex3IdwZFfDm0mmXnGVu8g6w23H3ZESI1HiYHdZZoqLiEV0xYH1J5Jy34IHhz1kHs5Q==
X-Received: by 2002:a17:906:844b:b0:72b:54b9:b97d with SMTP id e11-20020a170906844b00b0072b54b9b97dmr34645973ejy.229.1658290433275;
        Tue, 19 Jul 2022 21:13:53 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id t6-20020aa7d706000000b0043a85d7d15esm11512978edq.12.2022.07.19.21.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:13:52 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 0/2] Rework the kernel's README.rst
Date:   Wed, 20 Jul 2022 06:13:23 +0200
Message-Id: <20220720041325.15693-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jonathan, dear Thorsten, dear Linus,


As far as I see, the README.rst file in Documentation/admin-guide/ covers
three rather outdated (or subsumed) aspects:

  1. mentioning that it is possible to "run a.out user programs with this kernel"

  2. how to report a kernel bug

  3. the explanations around the use of LILO as a boot loader

This patch series addressed the first two aspects; the third one simply
first needs some more experimenting/experience on my side to update
the description of the setup with a GRUB boot loader.

I am happy if anyone else contributes or helps with this rework task on
the third aspect.

I am also adding Linus as recipient, as he seems to be the original author,
i.e., in the text, 'me' refers to Linus.

Please let me know if you are generally fine with this approach, and
if there is something on the other documentation to be done to get this
patch accepted.


Best regards,

Lukas

Lukas Bulwahn (2):
  docs: admin-guide: do not mention the 'run a.out user programs'
    feature
  docs: admin-guide: for kernel bugs refer to other kernel documentation

 Documentation/admin-guide/README.rst | 91 +++-------------------------
 1 file changed, 7 insertions(+), 84 deletions(-)

-- 
2.17.1

