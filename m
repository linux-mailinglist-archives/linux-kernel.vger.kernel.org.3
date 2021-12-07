Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3210D46AF44
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378577AbhLGAmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378506AbhLGAmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:42:14 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F131C0611F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:38:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so49760979edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZ8QpBf2biMuMXCRBVugY0vgtYK9Kkf5AKuFBkLz2xg=;
        b=gRII6l4QN0/96xlw9ErXrJx41GPd606dLDQ+m/IfVmIUafTixM/1M25JswAx0/sQbe
         /QPyuSHY66/CR9npP1/SFupTrhBCLBUaSK+qpEkDIv43ILfdghnPr6IUtr+Jr9OrFZ32
         IhStwMKc4XxBGGaWNGlSTY6Tevql1sKXo+n0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZ8QpBf2biMuMXCRBVugY0vgtYK9Kkf5AKuFBkLz2xg=;
        b=iYK5OiuKSEiA0UXzgiXGjMgacuH+bA7J55glrd7BUnf2HGQTQR+BMEVWULDUDYaElJ
         nvGQWVV1UaGJEA0C5qkUUbV9ZXZ/tniBFCnUfX4F7FDmZ2AMy8eRVBCR2MdMSZ5TqsOc
         BjlDugdW7g9qRnMH1MmyGblLrqVNvBu6TkfacTAbSkEt8yC4ag2AtiZ12Xj0LuOTHRQ3
         Q5j29N6roeTY0DIxcjqJRUvZueg9hTyu33kqwL1GG7BP8x/ncuBLnHq7gJlv2CHJHs/v
         d5HC9mHTIsWUGTk7KSnfr0cfngo8y/0FquV6td7tYwXAbeFkdvCaRdae9LHVM3baZu2P
         TjEA==
X-Gm-Message-State: AOAM531eM6HPByOHzy3CgylsJhSN+jg18crzkXLnO66ic3kYE+xyX84m
        DGfIThjjIMO9oA8Ne13xt6aoVw==
X-Google-Smtp-Source: ABdhPJyNVJOvCTsZ9sTSjk94cgl5lWeuMmWOPI9/I9Ela6IO+fjOLU9XaeE+Kae/boRfckP+eUdd8w==
X-Received: by 2002:a50:d49d:: with SMTP id s29mr3757515edi.55.1638837523688;
        Mon, 06 Dec 2021 16:38:43 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hg19sm7422531ejc.1.2021.12.06.16.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:38:43 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 3/4] media: Documentation/driver-api: Document entity name
Date:   Tue,  7 Dec 2021 01:38:39 +0100
Message-Id: <20211207003840.1212374-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211207003840.1212374-1-ribalda@chromium.org>
References: <20211207003840.1212374-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the entity name can be configured by the driver to a value different
than vdev->name. Document it accordingly.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/driver-api/media/v4l2-dev.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/media/v4l2-dev.rst b/Documentation/driver-api/media/v4l2-dev.rst
index 99e3b5fa7444..22120b60b0a9 100644
--- a/Documentation/driver-api/media/v4l2-dev.rst
+++ b/Documentation/driver-api/media/v4l2-dev.rst
@@ -134,6 +134,10 @@ manually set the struct media_entity type and name fields.
 A reference to the entity will be automatically acquired/released when the
 video device is opened/closed.
 
+The entity name can be configured by setting the `vdev->entity.name` pointer
+to the desired value. If it is set to NULL, the entity will be named as the
+video device.
+
 ioctls and locking
 ------------------
 
-- 
2.34.1.400.ga245620fadb-goog

