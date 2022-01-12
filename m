Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59CA48C7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355000AbiALQKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354958AbiALQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:10:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F7C06173F;
        Wed, 12 Jan 2022 08:10:33 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:662a:d95e:24d7:7832])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B1C11340;
        Wed, 12 Jan 2022 17:10:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642003831;
        bh=d45DbPFknuXwx5Ecvst0XXYfrHx7ADaDjWBVHRWPyIw=;
        h=From:To:Cc:Subject:Date:From;
        b=Yyyj9eySS605OA9YUGEr/HcjIZu8fYKb+mESQEarHJ7Rsd91oMHgK88ZJw1MFJ+qT
         Hq7FAaFPq8Cm3Ciz9fjnzalBp68WrF1vuI4Lc4A7oG8wLmZunr200FxDzrWuvKLU5K
         iNoQJqZnCMvqIv1f4V3nIUHIWvlHFbikYcH9bv7U=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        dave.stevenson@raspberrypi.com,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Subject: [PATCH 0/3] Add 12bit and 14bit luma-only formats
Date:   Wed, 12 Jan 2022 17:10:11 +0100
Message-Id: <20220112161014.972076-1-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While working on adding the V4L2-PIX-FMT-Y12P and V4L2-PIX-FMT-Y14P
formats, I noticed an issue in the way V4L2-PIX-FMT-Y10P is described.
This series aims to solve it before adding Y12P and Y14P.

Those two formats are needed for the next-to-come bcm2835 unicam driver.

Jean-Michel Hautbois (3):
  media: doc: pixfmt-yuv: Fix V4L2-PIX-FMT-Y10P format
  media: v4l: Add V4L2-PIX-FMT-Y12P format
  media: v4l: Add V4L2-PIX-FMT-Y14P format

 .../media/v4l/pixfmt-yuv-luma.rst             | 48 ++++++++++++++++++-
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
 include/uapi/linux/videodev2.h                |  2 +
 3 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.32.0

