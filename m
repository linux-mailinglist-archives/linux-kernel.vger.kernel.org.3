Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AA58D309
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiHIE4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 00:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIEz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 00:55:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870971DA5B;
        Mon,  8 Aug 2022 21:55:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o2so8161334lfb.1;
        Mon, 08 Aug 2022 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=KEMyayddLy4t6p8x0SCdpm1giKMFIXwhj2kSN1bL98Q=;
        b=CZj90YxhOGnQ3nKJHtR0oJ9SF9LGBXFEdQYpU9xi78E1gBqji+BueKnHxp6FOOtO0c
         mGGzJFfrIhm2UDfaKQTCPMV/XWjKqYS48aanAWfnH1AhLtf2SDn7NoMa8G7l857wO3io
         Cc89fl2/Ucu3EMOGahD0jrBaTa9g0nQgpdMtdz/5AT+SCzTJBRE8Y2L/60gGnkWlYE9l
         3i/ecDFRluHcK/hO5bhnk3C0VIKTIoR3+ve0HPMGdVSE0k7nw4TyIOCb+AxeUQ18ec3p
         GMtE8+f2eXD27c3BP8NeAc9h05RUzWpsMVbXd/gC/3pbEEll8pnctEhMM2iiJOa69qkD
         b5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=KEMyayddLy4t6p8x0SCdpm1giKMFIXwhj2kSN1bL98Q=;
        b=VOrF23nYMA9A4arvxMhch2vPwxnjnSsS96aRKtIRsX30B3R1tMbIEINgMF7AzSbIXK
         zCCrBtjvXkzaSTyBcaWFHN6C8JZjVPaKl70QJnEJ9szZY95LoURHj2H0UF5AG2lf7XLz
         jMDKwjH8anNWvI79gyhquq2y2dq3bNmcuwf+Av2h5aIMFNz+QViXofUzFLDAwJ77okQW
         z7UiQo1YEAbJx5HdTkJNM/liAJ2kxXM2rEI9eOFDfJE/8/hVFOjT3ajnIFjxAP/Sp4z3
         /fPub9hAcfK3nkIMdIETaYFOO+rAq/rMJSnpHBDHG3bWZnP/b4fVD9MpKeW211qPYrB9
         yUVQ==
X-Gm-Message-State: ACgBeo06lTmiwaHWhELCIb0AzZTTxr86f+7g/EyNlrosoutTU8sKsunk
        By+hR/oxLqmHspPttytyxIE=
X-Google-Smtp-Source: AA6agR6lZ2hkFeBAmBHcwFrjnp501bwk8OJ8RqEHIXkU/bk2JZTDcrh6ou1HT8WBeeLmqhwo/HVEnQ==
X-Received: by 2002:a05:6512:3087:b0:48c:f71d:961c with SMTP id z7-20020a056512308700b0048cf71d961cmr2338325lfd.431.1660020955750;
        Mon, 08 Aug 2022 21:55:55 -0700 (PDT)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id u17-20020a196a11000000b0048ae316caf0sm1626378lfu.18.2022.08.08.21.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 21:55:53 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] Documentation: stable: Document alternative for referring upstream commit hash
Date:   Tue,  9 Aug 2022 06:55:43 +0200
Message-Id: <20220809045543.2049293-1-carnil@debian.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additionally to the "commit <sha1> upstream." variant, "[ Upstream
commit <sha1> ]" is used as well as alternative to refer to the upstream
commit hash.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 Documentation/process/stable-kernel-rules.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index c61865e91f52..2fd8aa593a28 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -97,6 +97,12 @@ text, like this:
 
     commit <sha1> upstream.
 
+or alternatively:
+
+.. code-block:: none
+
+    [ Upstream commit <sha1> ]
+
 Additionally, some patches submitted via :ref:`option_1` may have additional
 patch prerequisites which can be cherry-picked. This can be specified in the
 following format in the sign-off area:
-- 
2.36.1

