Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9FF504702
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiDQHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiDQHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 03:53:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD991403A;
        Sun, 17 Apr 2022 00:51:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q12so13724803pgj.13;
        Sun, 17 Apr 2022 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DjQdA2HXpcP/GF59oEry3wEf5qflLMtjXUNEoLakT2g=;
        b=IMT+AQWjTbf83qC7ACGL5TT369tCmX2xF+To4fRFGMOyKte9ShatFtrYYkqvvcw7M5
         zROLrNNDsYrd1+DdRkpGH7QII/IGjixAOXhfb61SG9gI6xdJms340CaxwYFaDyg2bNlz
         aCyVsXKeJfjjR8U/A7uxlpJTINN0mCOWZNUjy6eKAAY4Q5tN8HJJqZCZ9D+1XbAbynrd
         A/4OW6OeiWB/0T5HzY+E3tuZYlCCXAu2hN0haxWgYA6jnc2yBBHBIJJ86qXTouN1YnN+
         30oA11Ob7au02iotBDiXswARGzfJFqeZ2HiDMhoO0QPLD7AliSe1iOYFLT9bTtHkbHx1
         dC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DjQdA2HXpcP/GF59oEry3wEf5qflLMtjXUNEoLakT2g=;
        b=t6x3Ok9l5ZwiJ8GNpKm45+EPCLULTHb6yP2AY4pZ4N13Mpb9JOX6W1Tnnjex6B594M
         tnDWRE16tYuJ7g6yfIwWgBUdDQe5wUdvTF23WExJVgAjvAsIrR9jwC/SQZxlBvn3n02R
         2sLw9Te9r22TYM7O9rBhOs3lTBB2gO5zELBW8sadGmxAMgc5rFrV8nIEB47cSXTx6g/h
         gcJllzh8Vul+ximwYhwvS1WGl4IFUJ/B/SjVIbgLpuqzRzC2CcMpTByOUM5vd5th6Wdr
         PA37c7o3ZdeRdVpImMq4hzH1vcKqvomvns0MnibOMPzs3jf8dwrIzKqJmFny4+Ixo55i
         IebQ==
X-Gm-Message-State: AOAM5320M7o+kMkvGz2J/OJ4ZtwpESG7fZKddICaj8C05TlqGkjJF9if
        0pPbD7GXsQEJ+9Krqflfpy3uPUR3idi45Q==
X-Google-Smtp-Source: ABdhPJwPAFLA8pCiHsessflPULLDG061FXnfrs+GXPKcgNv5c1HNKj3/lMEUrf207B0rQc3m9fKBSg==
X-Received: by 2002:a63:f217:0:b0:39d:a9ed:2160 with SMTP id v23-20020a63f217000000b0039da9ed2160mr5639291pgh.111.1650181884906;
        Sun, 17 Apr 2022 00:51:24 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm13558356pjl.39.2022.04.17.00.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 00:51:24 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] Documentation: siphash: formatting fixes
Date:   Sun, 17 Apr 2022 14:50:56 +0700
Message-Id: <20220417075057.127865-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting fixes for Documentation/security/siphash.rst. The shortlog
should be self-explanatory. Resend of [1].

[1]: https://lore.kernel.org/linux-doc/20220329042952.10100-1-bagasdotme@gmail.com/

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org

Bagas Sanjaya (2):
  Documentation: siphash: convert danger note to warning for HalfSipHash
  Documentation: siphash: enclose HalfSipHash usage example in the
    literal block

 Documentation/security/siphash.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
An old man doll... just what I always wanted! - Clara

