Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D9491045
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbiAQS1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242535AbiAQS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:27:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0C2C061746
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 10:27:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g22so22689003edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eO3SarKuawfnSDlycroRnbnpPkYTlr8nD5yeqFUVHFc=;
        b=O42iWlmqZFfrZT1YQH9NZLLqWeHsjrezFg0IKlF+MbOJe+MmgTCMTBO6BLj86ZhqgZ
         Ktth5BBRygqea9NiPD3Du+Dp9tbZhmz4BgHQMpWRrgnxtjXP18bxvCJP0qh5SIp85N8t
         En/NuGe+o1wwdA2DLdNhasLj4fF3Z4BBqsEuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eO3SarKuawfnSDlycroRnbnpPkYTlr8nD5yeqFUVHFc=;
        b=WZy0EjaA3aikwcqcRLYtceOCQoU8qCXjYCylwNbqt40sZ8wXWrrhMjleZj80WMTb9t
         QIwEjk+biRfW4Ob3sS549gUKMqt1JR9M49TmuDUtwdpu/n57Zjf/uyiSt7K8EVEauv6H
         Ws8gQJYMT6U8nuBfxOVK84ti4d+5ja+SNzj2nTyX0crDuiOL6Vp3KtUfnEV5B+BRa3XL
         kgWT2CP9KXhGbN/kLT7SM34RL82KCisKK4MfEOHXkC/4T+fwoyiSs7xGU2E/KCAuKsd3
         MF0TFDxfbFiMkA+CkOyVSmFk+CRT/DiFC9xWp4fur3e8M0dk2jxIDVChr/CwpeCm+FPI
         IxBg==
X-Gm-Message-State: AOAM530qzZjMGLEpm9Spb1LrYBr2J+Rx4JdZFnmVl88OOv8x8L/B2U5e
        GADFOdqjLi3daKg/vtuH8bO6Dw==
X-Google-Smtp-Source: ABdhPJznsIxpLjJR/d/R7v1Oul8vJd4+xCZf+aPIqc6VC6qHoTTYJ7sDnbKhxaNfBngrSRolsMd80Q==
X-Received: by 2002:a17:906:175b:: with SMTP id d27mr17982456eje.476.1642444023056;
        Mon, 17 Jan 2022 10:27:03 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id la10sm4657462ejc.22.2022.01.17.10.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 10:27:02 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 2/3] media: Documentation/driver-api: Document device name
Date:   Mon, 17 Jan 2022 19:26:57 +0100
Message-Id: <20220117182658.468993-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220117182658.468993-1-ribalda@chromium.org>
References: <20220117182658.468993-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document how the name of the metadata devices is modified.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/driver-api/media/v4l2-dev.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/v4l2-dev.rst b/Documentation/driver-api/media/v4l2-dev.rst
index 99e3b5fa7444..935a46e29c5e 100644
--- a/Documentation/driver-api/media/v4l2-dev.rst
+++ b/Documentation/driver-api/media/v4l2-dev.rst
@@ -42,7 +42,9 @@ You should also set these fields of :c:type:`video_device`:
 - :c:type:`video_device`->v4l2_dev: must be set to the :c:type:`v4l2_device`
   parent device.
 
-- :c:type:`video_device`->name: set to something descriptive and unique.
+- :c:type:`video_device`->name: set to something descriptive and unique. If the
+  device has the `V4L2_CAP_META_CAPTURE` or `V4L2_CAP_META_OUTPUT` capabilities,
+  the string `Meta:` will be inserted before the original name.
 
 - :c:type:`video_device`->vfl_dir: set this to ``VFL_DIR_RX`` for capture
   devices (``VFL_DIR_RX`` has value 0, so this is normally already the
-- 
2.34.1.703.g22d0c6ccf7-goog

