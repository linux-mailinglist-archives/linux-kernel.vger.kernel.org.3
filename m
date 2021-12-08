Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F31846C9B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbhLHBBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:01:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38684 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhLHBBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:01:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 63158CE1F58;
        Wed,  8 Dec 2021 00:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B4C341C5;
        Wed,  8 Dec 2021 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638925047;
        bh=eyFDhLZXXF0TjsoOyaqwW+4RWrrRXJe67NtK8tlN9nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVjbNvLQuFmbAP9T/11p/89kLj7Oi0EXGjmXyQXHEr3brp8pnfWh0bAaV13fzpr7O
         VyworE4Dy6N7sXvrhdMO+sAlWeMlLI0Ky/0m1mRd5vC2KvjaKGdHkuy4bovpeloEi8
         oxGro/wbwN/+O+6hLr/C6OOT3EUoxHZGV6RxSfLYCdpSsuAXXJRo4oYSlb5gfrDqpK
         T0xtb/FTw3+psumUKUzYEXC9yUoRDcsPvWQgufFSY9eF5X4O8i5krVoR57i8FcJCdx
         0w6CwDjTZfqpxmcKkQEFaHwrPyzR1AJjYs97VdrpCF04Z6h9uieizfVR2d3j+lvIu4
         1Jkn9NvtZG9Hw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] docs: sysfs-block: move to stable directory
Date:   Tue,  7 Dec 2021 16:56:33 -0800
Message-Id: <20211208005640.102814-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208005640.102814-1-ebiggers@kernel.org>
References: <20211208005640.102814-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The block layer sysfs ABI is widely used by userspace software and is
considered stable.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/{testing => stable}/sysfs-block | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/ABI/{testing => stable}/sysfs-block (100%)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/stable/sysfs-block
similarity index 100%
rename from Documentation/ABI/testing/sysfs-block
rename to Documentation/ABI/stable/sysfs-block
-- 
2.34.1

