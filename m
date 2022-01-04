Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4A1484634
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiADQuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiADQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:50:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F82C061761;
        Tue,  4 Jan 2022 08:50:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o30so21138167wms.4;
        Tue, 04 Jan 2022 08:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjHD3HZXQHArcXXHZDB3X9bEf8vlE4ZCTQedafap4ok=;
        b=M8LzFPw4k6dpYPt3Q6bYHHxZw5mAb5RUOjv6sdvvgZge8Vb0GRsZ48eRej+lAOZV6c
         GgblIfNvc/0kPssl6G3+CHLyg3HieJV3+iwOTM1emd73ZDzFbmnEMJejUJe0Whpl/iGq
         +oO4uz8KXlQ8D/B2lIxYBXvivTs389/OhnimD1HnMYCqkFqKlzdAygv7hhaJH05hXYxI
         LmNhEa5es1KdQgAm0hu5yN2XyjMQmTZ14WaMmUuID6nIVUQIeImZS8nGiGhMQ+jrhSxX
         8rWVLnai61wHdFhkRuM6S0RfnaO+U4Dh5MKBC2WgEkiPv9ozzLrJxdApvGDtzCOogS2Z
         MRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjHD3HZXQHArcXXHZDB3X9bEf8vlE4ZCTQedafap4ok=;
        b=LehPhZp6/t+afw44Lgg6nZzdYWrbS/fLCqzl4pXgjEfIc7aaqXJeWpCAUndQX1iiJ8
         4PPLd8c1c7onTgw7nzeGmL5hY0pOraLgQbn/FYq00TL5h5+hmcr+HfFH7pnEGCkgsZyd
         cWjAaW7VHA8KB68NQdw241B1facFOuFs24XfCOr4MTxqtvTd3JH2CNQtatUWprCGE2B0
         cwxjWA/JHrzBWAws7VqwmC4e26Wx8326TnYH59DQdWO8Bo88wEXxyPcNcYzUB0bH29qo
         jNjqnHt53BXvKscJxanV2Dhy7E2QDjqCyGY+EdAgBk9coPFGK9f3FHBYgBuoQ+cAQdaQ
         u6xg==
X-Gm-Message-State: AOAM5323s9W+Yn5qx3jxQARdGcQhh9e3j2fn5UGg5nNi05tL4X1L1yfW
        L3kFpTlqJrDpLhMwCnvmeUuTyPAuelVu4A==
X-Google-Smtp-Source: ABdhPJx2cYTn4bp8DbsB9/P9Al4MW3TRJ4Tj6fqAtdXq8KSDHZWwvpDPQidXQAletxVvpCaPXNdNJw==
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr41460545wmf.48.1641315038120;
        Tue, 04 Jan 2022 08:50:38 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id j85sm417696wmj.3.2022.01.04.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:50:37 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexhenrie24@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/3] Magic Keyboard first generation and 2015 FN key mapping
Date:   Tue,  4 Jan 2022 17:50:30 +0100
Message-Id: <20220104165033.29421-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset adds the missing key mapping for the Magic Keyboard first
generation and the 2015 models.

Since the first generation model had numlock emulation in place, I
decided to fix the bug (described in the patch) and keep it in place
just because it has been there for so long that people might use it.
Having said that, there is no indication in the keyboard about which
keys can be used as numbers or how to enable/disable numlock.
I think that a patch removing APPLE_NUMLOCK_EMULATION might make sense,
but I didn't want to remove existing functionality without asking :)

Thanks a lot,
José Expósito

José Expósito (3):
  HID: apple: Refactor key translation setup
  HID: apple: Magic Keyboard first generation FN key mapping
  HID: apple: Magic Keyboard 2015 FN key mapping

 drivers/hid/hid-apple.c | 92 ++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 19 deletions(-)

-- 
2.25.1

