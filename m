Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58059D1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiHWHK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbiHWHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:10:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094E61D5C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:10:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pm13so4297172pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QzCqbZG5/Frug0ESLdm92AY28QUqZDqY0QVaHTbOZtQ=;
        b=dqTtKlX9Bk71Vcu7wl74Q/5H+hxWuGaQWVO5Z2kZMA3WpjojO63MFnZsd5XNDPuYxT
         lnmKomrPIyBzh2I+mqo0r3JaAevv7ffKy8RuHomiofBOO7qFVeK3hkT32OhreXSOKmt8
         rWuw/msvbwq925b3I/XTIUxOd0cFM/PqBG3kbCBcwUqkqGemIh2bXe5NKx5jpMl82ENR
         fjS3WpHlKufGUKeBmTTWQ5lOjvL0v77vnWD8oZUHOxfLhYGZpUeQ52xFBdK9nRiTxrBN
         /EaS7Tw/Huh3NfJ4Xw+8+0fjTN7azMJLhEIeRPfug0mZa6PippyUoklxPAafncScCg3X
         L2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QzCqbZG5/Frug0ESLdm92AY28QUqZDqY0QVaHTbOZtQ=;
        b=cXPmmzyPR2Y5oIM6z5PtaGjrBTRQJrxwszRKipP7NxfYG/yKssMF5IDEsjXtr7PsWg
         /qm64Xe7jSXoukGimRRdPOgHxDl+ylPVeAtz2G5/5A9jgif6mslNKYCZETrjGddJra+M
         naDoWQn++QT8y3B+q51D0e/fzgxG+Mfsxq9ZFuUsd8MErtbmj8Om7cDycG41EKj2JyAL
         mk0+w8ZiUAmWI5VaYONUinNUCNsXLCZcl6ZWlgBkpC1jvGvE1TZq1Ep+kkGSJ1oZiUJK
         h8OK0ThgmMHQ9Dku3t46GaEknPf2ZzV1i2JceMxT+UO6vHiyJsvcj2v4ilXySKQLqXzO
         XWaA==
X-Gm-Message-State: ACgBeo2ulfTqOKTJ5LlsxljHCIcLmQXssQkOlGnsrpGwmndxgzYf/HcZ
        NwlJKhMeewht/bMyHkZPF8ksjtQwV4Q=
X-Google-Smtp-Source: AA6agR5j5OGvOgcNbVR5eBq/O3FVF0PqZoicQf/VNzkojtGnPwx3FhQHE2kJuI8hSp+eslfnJlkM+g==
X-Received: by 2002:a17:902:ea86:b0:173:5e9:9ef7 with SMTP id x6-20020a170902ea8600b0017305e99ef7mr886700plb.14.1661238614983;
        Tue, 23 Aug 2022 00:10:14 -0700 (PDT)
Received: from localhost.localdomain (121-200-9-125.79c809.mel.nbn.aussiebb.net. [121.200.9.125])
        by smtp.gmail.com with ESMTPSA id 22-20020a630d56000000b0041c66a66d41sm8506773pgn.45.2022.08.23.00.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:10:14 -0700 (PDT)
From:   Daniel Tobias <dan.g.tob@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Tobias <dan.g.tob@gmail.com>, akpm@linux-foundation.org,
        trivial@kernel.org
Subject: [PATCH 3/3] spellings.txt: add entry for debugsfs -> debugfs
Date:   Tue, 23 Aug 2022 17:08:39 +1000
Message-Id: <20220823070839.533562-4-dan.g.tob@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823070839.533562-1-dan.g.tob@gmail.com>
References: <20220823070839.533562-1-dan.g.tob@gmail.com>
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

Signed-off-by: Daniel Tobias <dan.g.tob@gmail.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 8435b99452b6..b1c111204abe 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -426,6 +426,7 @@ deactive||deactivate
 deafult||default
 deamon||daemon
 debouce||debounce
+debugsfs||debugfs
 decendant||descendant
 decendants||descendants
 decompres||decompress
-- 
2.37.2

