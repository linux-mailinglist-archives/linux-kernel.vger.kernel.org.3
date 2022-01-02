Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C1482C77
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiABRvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiABRvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:51:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF74DC061761;
        Sun,  2 Jan 2022 09:51:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso17269004wme.1;
        Sun, 02 Jan 2022 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnD/k5dOnRMWbk+gLPrEGJiWu/w2QcrrSuk3ehIWI2k=;
        b=KglIZXQLmSy7G9nRuroDU70PORuR8Mfv16kpEG//7PO0M/M3CyNyrEBg9yZWk7FYnr
         /OMSuhotjlbcIAgXWg7UcABpN5fRbqbx1qTKsZnBxRrXCzKznyUqQSGBLPXRroOpdhHQ
         yTFoep8bI++sOeCGYYjVNk1rcGcN34c8jaIPhrV0n1qcn3H1MlHmpuXlaEi6yTQoKOsb
         fMWQK7yhC+3f8Qf9mfGe55V31NP5HssysFlLW6M12ft2FTuvy0asbvoEJmtT8NHk4Qt/
         QHz7LRP267lwPKKhG1BGtQ0jg+LWxaGq9JmQRjwurxVZcid5SrEF6m7mPMGwnyUM28cO
         KhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnD/k5dOnRMWbk+gLPrEGJiWu/w2QcrrSuk3ehIWI2k=;
        b=zwVlm6JHGSE/YPBiuZeE69vwBfL054qNAfhURhZwzK5R63+4uojGtT+rhE3Dykuiax
         4kDmXsrlCfXTBMUgYobmN3mI1Up3kwSDs37Ixq5m326S3B5CQpnYD0D5eBfeJ8R5WMHf
         j0f9Yc3EF/LmRMKtXRUnbsBGK8StUc+vPPQ986nHJ4iekVp8v7okYuvAwNK1ag8D2YHl
         CYhDllrP496lQ/O9bue1Mg9/wxDSzNBDFzqD07oj99SeGdisOHRtb0AfHztGN1Ask1bt
         5TgHjiNj4qwzM3Co7XPxY2Z0jeA/A5jLAmWK+NnQWNqGlDnrrNLDV7+OncjwX7CDMJA6
         Y2HA==
X-Gm-Message-State: AOAM530QwdVHTI2ta5kU1TDboQlFa/1oOImc7qR3YbaT99UcJGEyMEaQ
        lQBd6j30HpCS20ljUoqj87o=
X-Google-Smtp-Source: ABdhPJy2tMf1pUxRsfR9XXtLSzdQFFewogSTQv/P9NaorkMoiROMrRQgB9mhnIUhXetl+EK1StZ+zQ==
X-Received: by 2002:a05:600c:4e46:: with SMTP id e6mr36539943wmq.132.1641145880423;
        Sun, 02 Jan 2022 09:51:20 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id l17sm22564593wms.24.2022.01.02.09.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:51:20 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexhenrie24@gmail.com,
        bberg@redhat.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/1] Magic Keyboard 2021 with fingerprint reader FN key mapping
Date:   Sun,  2 Jan 2022 18:51:12 +0100
Message-Id: <20220102175113.174642-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch is meant to be applied after [1] and [2].

Thanks a lot in advance,
José Expósito

[1] https://lore.kernel.org/linux-input/20211202061651.115548-1-alexhenrie24@gmail.com/T/
[2] https://lore.kernel.org/linux-input/CAMMLpeSdmc1Ti4EZ9Tm7eq3a3+u46TEMWSaqD=USSnSRnZMYTg@mail.gmail.com/T/

José Expósito (1):
  HID: apple: Add Magic Keyboard 2021 with fingerprint reader FN key
    mapping

 drivers/hid/hid-apple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1

