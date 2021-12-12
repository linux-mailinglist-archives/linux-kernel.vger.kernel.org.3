Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C718D471C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhLLSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhLLSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:21:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2453C061714;
        Sun, 12 Dec 2021 10:21:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so23524849wrr.8;
        Sun, 12 Dec 2021 10:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heLImKmZeqCt6AqybtVYurhnUTJKAIiih42DM1JeSzo=;
        b=WaofHUGtJVhFrxdvwTJWIrlzVfi7jyo+Db6W6/8vI7aUKxGvhiuxzvdsnq/X9KOtYd
         59mVcqGg6I+7v9+FsI4buXyboUJyUKDxlJzLq3ziPRkOpGGmgSBc5nSccxoxyvLGOXS7
         JniGZ4kedliXun1ignNJ9sOjkdwGpmBow+h2bBKpCV4Er5UZyfmLRuk6pSJSFBb9xq5L
         SNSXrnxYQYqZ8sa5cSXFWj5V2CEAB2Bd6dX38K0S/j52h8Xvt0jftvbaX/CFdYrLoFAP
         v3x41p2p4k27Qjn9VpN1XrF2as8xDmtzLAFuUcNvpZ2ceQmr9QXJEvb1nzHCzTVlLP9x
         PKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heLImKmZeqCt6AqybtVYurhnUTJKAIiih42DM1JeSzo=;
        b=s5CLXp2iZuIZh7nZ3LkPYc/iSAsgQTika95Lq9TvgGq2kO8EXX4dFkr0TxC+nem7l4
         fnpB3K8CnAlxDmF0Bpoj1aZBJbmqGRLIwGJVXV4TWQHw1P0z/CBCDhYEsD8ZW75Zf4bk
         1EO7e1JU/h57XxzJ3xo9yCYz6ZgwUw3ubLupQDbx3BxlZIwNkBUHf1pZ7ReqW4OgZe6F
         japVTiWcxIhGIq3WfV+Buyhi4cmT1p1fCgn6BAnqEvELWl0oI6xmZTVytHfdSh4I9K/L
         SwSVm75cRdL+qMPcfd3KmPuheAio4nCL4Sxr+JRSN+vGPvJxROuVV3e20x+A8NHLMaS0
         7ytw==
X-Gm-Message-State: AOAM532fntWLaXmgxQffpzy832cp4fTcPpuJ83Dz9cexYTNhTvvWo3ws
        f0OD647jQ8K/vfodROsnrjg=
X-Google-Smtp-Source: ABdhPJzlu5vOSE8a2BdaJMhKPsBdWhxEXAsAj6guc3c+5heIaijVDHrCJ+fb7U9tnqneA9MKEzIIDg==
X-Received: by 2002:adf:a404:: with SMTP id d4mr27495404wra.556.1639333265441;
        Sun, 12 Dec 2021 10:21:05 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id r62sm4667421wmr.35.2021.12.12.10.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:21:04 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/2] Add Apple Magic Trackpad 2021 support
Date:   Sun, 12 Dec 2021 19:20:58 +0100
Message-Id: <20211212182100.40968-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple Magic Trackpad 2021 (3rd generation) is almost identical
to the 2nd generation devices.

The only meaningful change from the driver point of view is that
its name has changed.

This small series adds support for the device and solves a bug
caused when the default name of the device has been personalized.


José Expósito (2):
  HID: magicmouse: set device name when it has been personalized
  HID: magicmouse: set Magic Trackpad 2021 name

 drivers/hid/hid-magicmouse.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
2.25.1

