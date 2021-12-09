Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98846DF93
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbhLIAnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhLIAne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:43:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE92C061746;
        Wed,  8 Dec 2021 16:40:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15974B82331;
        Thu,  9 Dec 2021 00:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800D4C341C6;
        Thu,  9 Dec 2021 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639010398;
        bh=Rru9VNpKwobGSsbMxjlqdcJD47gIcRS3a6kDRYb0Q30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTo8jAuPeOQ8DXQE6IsrDRmK7CwS1MHMwac+PggASMHREGUYdWv0GaU63McBPUnYr
         wNbkgy6Pv3GQFus+XHv+uRdeYLaI6Oy4RFkokWk+SEZfaelk+UCIMJEYAgiccSOEsl
         2LW78zJ8H0LpWrGcPGmDoEcYH3MCnOS1CcO+K8/ad4/QuzIJCROph8safHc/ooFjl0
         ik9DMKhoEGpuZavzq0q98Jp6HyiwDsgNcirQNrmSWxGPjLOEtcz6ikL+W7abTXjrue
         DyqQv/4J6DYchnbY03Bzeb7mgOllKE/zUz6Je3SDZMPTm58mXz9TUzncyUtv4YwUls
         /hF//Hp/elYGw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 1/8] docs: sysfs-block: move to stable directory
Date:   Wed,  8 Dec 2021 16:38:26 -0800
Message-Id: <20211209003833.6396-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209003833.6396-1-ebiggers@kernel.org>
References: <20211209003833.6396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The block layer sysfs ABI is widely used by userspace software and is
considered stable.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

