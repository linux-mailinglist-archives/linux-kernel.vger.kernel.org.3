Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01486482C4E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiABRE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiABRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:04:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21CAC061761;
        Sun,  2 Jan 2022 09:04:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e5so65716025wrc.5;
        Sun, 02 Jan 2022 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXKrBtAmzO1iv3BLmBCxnnQh/1B6MdFJ6KiimeIM16s=;
        b=kqDBT/dwdFlnNKQqgesrxM0EV6Sr0zVArfv9Atnhe9f1xV55SCBBtFw73amZ1ZbYHM
         fCPVJuf0eKOtfjCItBUbeWvIOpbpF0dNKDRERS3Z8/7aoJn8HLwwHmSBeoqtd7qMvmOI
         MkrIL51UGjRxTLV4yOeBUyWey/m/qTIBrCCVwpmSeo3pEkOmUvoMXazeeXSCWMCfmUZx
         pJJ+nI7TnjIXyiTPF/kxjUYl9I50TeM3P74WH/XfeyF291O5WHx+B/jxi2C7+N78wBNK
         6FIDdXLcnPiYKaivwkSKqXcKhTTGOO0U/Pkx4FRTsj7UHK4UmZsS9lv/krprc2enPzjA
         z8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXKrBtAmzO1iv3BLmBCxnnQh/1B6MdFJ6KiimeIM16s=;
        b=AAb4/OqG5Vf/9gNnbx1uZ05iUoizU9DAIjHrhInSxdDfBonK4lyY7oNzEaLSeRUfFf
         n9eS53OQ3B6KtBKUwmoXDHTPyalXfB7Xq1EBgHbuiIYv+haqNQ3JwwKDMWB6/9ZOtoQf
         WAbAOgzw+EDCNhgZRfZj8qxFC5AfmIuMsUFoLFcnFafXo7ix14LxyUIowtq4FU0CfYIV
         mxCODN2mbSdYy4l7NLCIYRwxBusHMp/ewAcg7VKUikydOr+gw05dETyALZNTQOjE5d3i
         f8/xBV83VlIwu6o++Xy2ruQavbRcnjXfA8RnB4SDGB5nwR6sW26i2PWZyRf1vtzRT3hB
         qcaA==
X-Gm-Message-State: AOAM5309wxhezCwUO+ccnLcZHlHQf9Mv7cIJLjWvBwA8M121s2G8m7zR
        gcJ6S51a4IGUQPFV+mZZ7kw=
X-Google-Smtp-Source: ABdhPJwb+DLlMGJfwnksXZYaW8eR+TR8qNRjRXrsdN+TdJRIRi3EtxA5sgK1lBLyzAb0MyiCebuQQA==
X-Received: by 2002:a5d:6212:: with SMTP id y18mr34774256wru.608.1641143095572;
        Sun, 02 Jan 2022 09:04:55 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a204sm34869172wmd.39.2022.01.02.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:04:55 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexhenrie24@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/1] Magic Keyboard 2021 with fingerprint reader USB battery
Date:   Sun,  2 Jan 2022 18:04:46 +0100
Message-Id: <20220102170447.159959-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch is meant to be applied after Alex's patches adding
the device IDs [1].

Thanks a lot,
Jose

[1] https://lore.kernel.org/linux-input/20211202061651.115548-1-alexhenrie24@gmail.com/T/

José Expósito (1):
  HID: apple: Report Magic Keyboard 2021 with fingerprint reader battery
    over USB

 drivers/hid/hid-apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

