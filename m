Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468A24F2225
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiDEEhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiDEEhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:37:16 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371EB7CC;
        Mon,  4 Apr 2022 21:34:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id i4so9547120qti.7;
        Mon, 04 Apr 2022 21:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2F6pdE01x8+LWv49X1XqEP9fwWhAgADePGjVUrJZtBc=;
        b=Nxjgu29NcyoUQQvdWmirHaBDLtseXhtj7lcWJjMk9Iiw47oNWInUQodWc0CG7OOIRo
         E5vGW0B+56BtG6tZFcHkF/r0qYJ3UR7Q9Y8sSe5yw5CX6UlPZJFQKpbRaVoqivu0/+tK
         RuLeUYnPEFT2gS7E1rhJ5Oe2oQUJeEgBgxqTQ11WHHYhUwKXjTceIBr7d2gnRMt5Ms+e
         U2wai/4F4xmnLRgHhz+DUqe1s/iGgyPlxT87VyoldvzSVvIWSbcueJ2mdPNkr19QOUeW
         5E0+Qefp34+sdPwxkWORuK4+KUoa6vYSoRkU5OPXhEKTo2LZ7q5rQn/mn51+Mm36wIKi
         ITig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2F6pdE01x8+LWv49X1XqEP9fwWhAgADePGjVUrJZtBc=;
        b=PubO/NhdXncb/HflHNhySL39X+g6CHUt+bG/PMtyTx3dwpcVXR3IeSgh94/mLaHKtL
         P++sLZKOOfThdj4aWNTW0HhGD8EtMTL8e0u/SU2ag92slxdvWjrazwCg0yWI3/6NbFOO
         QanaBoaugCCsqX6Zey10LzBdCHzQhrtGowjTf+ceQxLtHwxJGY/KVv3CPYkb1GjW7aCF
         gXw7GfdokADzM9Odv+eSQSi5gi/Hn1A+uBXWV24WnXp9ZSDtp3FoVaWOZ05e+zVhrYzU
         2SSbmyncTU96r89AWCsPA6933l5ojJ/B3Bc/3pUn5TEHH6hdUYoKFYMLQVr1vADD4CWj
         vXgw==
X-Gm-Message-State: AOAM533vlIMn4smct91f/ZXpb9JibD2ILDB/NWFBHNucoibSYCRG3uB4
        LYsgSnn5WyJ12BoDdTPX8Ru7OJpWZ9DLAQ==
X-Google-Smtp-Source: ABdhPJzRnztAxZFoPFNYGfQZufiSdZYE3yV4xvWPXjmMbn6lpfGb8r7lTbTB5VYi/wYLefr4FKVxMw==
X-Received: by 2002:a05:622a:148e:b0:2e2:2ebd:63d9 with SMTP id t14-20020a05622a148e00b002e22ebd63d9mr1438143qtx.601.1649133280094;
        Mon, 04 Apr 2022 21:34:40 -0700 (PDT)
Received: from necipappleseed.attlocal.net ([2600:1700:d80:8410:fa3f:95ff:bd13:53a4])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm10190386qtx.36.2022.04.04.21.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 21:34:39 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, paul@pgazz.com,
        fazilyildiran@gmail.com
Subject: [PATCH] docs: kbuild: add references on Kconfig semantics
Date:   Tue,  5 Apr 2022 00:33:51 -0400
Message-Id: <20220405043350.12599-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add references to 1) a research paper which provides a definition of
Kconfig semantics, 2) the kismet tool, which checks for unmet direct
dependency bugs in Kconfig specifications.

Signed-off-by: Paul Gazzillo <paul@pgazz.com>
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 Documentation/kbuild/kconfig-language.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 93a5b6e1fabd..a7173843a294 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -693,6 +693,8 @@ in documenting basic Kconfig syntax a more precise definition of Kconfig
 semantics is welcomed. One project deduced Kconfig semantics through
 the use of the xconfig configurator [1]_. Work should be done to confirm if
 the deduced semantics matches our intended Kconfig design goals.
+Another project formalized a denotational semantics of a core subset of
+the Kconfig language [10]_.
 
 Having well defined semantics can be useful for tools for practical
 evaluation of dependencies, for instance one such case was work to
@@ -700,6 +702,8 @@ express in boolean abstraction of the inferred semantics of Kconfig to
 translate Kconfig logic into boolean formulas and run a SAT solver on this to
 find dead code / features (always inactive), 114 dead features were found in
 Linux using this methodology [1]_ (Section 8: Threats to validity).
+The kismet tool, based on the semantics in [10]_, finds abuses of reverse
+dependencies and has led to dozens of committed fixes to Linux Kconfig files [11]_.
 
 Confirming this could prove useful as Kconfig stands as one of the leading
 industrial variability modeling languages [1]_ [2]_. Its study would help
@@ -738,3 +742,5 @@ https://kernelnewbies.org/KernelProjects/kconfig-sat
 .. [7] https://vamos.cs.fau.de
 .. [8] https://undertaker.cs.fau.de
 .. [9] https://www4.cs.fau.de/Publications/2011/tartler_11_eurosys.pdf
+.. [10] https://paulgazzillo.com/papers/esecfse21.pdf
+.. [11] https://github.com/paulgazz/kmax
-- 
2.25.1

