Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5540B494D01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiATLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:31:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231479AbiATLbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:31:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FEE7ED1;
        Thu, 20 Jan 2022 03:31:00 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.37.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 630C43F774;
        Thu, 20 Jan 2022 03:30:58 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        mike.leach@linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] coresight: Fix TRCCONFIGR.QE sysfs interface
Date:   Thu, 20 Jan 2022 11:30:46 +0000
Message-Id: <20220120113047.2839622-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 * Add Mike's reviewed by tag
 * Also make it impossible to write the reserved value of 0b10, regardless
   of what is supplied by the user.

James Clark (1):
  coresight: Fix TRCCONFIGR.QE sysfs interface

 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.28.0

