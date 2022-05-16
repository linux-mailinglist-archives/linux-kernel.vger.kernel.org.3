Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C26528214
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbiEPK2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242608AbiEPK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0912A86;
        Mon, 16 May 2022 03:27:37 -0700 (PDT)
Message-ID: <20220516102615.947490347@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1eoy5klb8svAdIn9/UXgJevyTb9Ww/jSlczBpVi7ZNQ=;
        b=rP1Gt0hSMwM7kYHgwY2C/ntB3s+H1l/1S6Km3OE8/0DZSiXO+N34LP58EkR/cK5y5ZA+vl
        rCWdp5xSsaIN6io1zjKsLjBMvlaLBcMUpFxr5/7WhC2sRknoYnhYII+b5BBK8j91zHb8nT
        mwBEvkbCWlzSFQiak01DaUqEyHZpla7pzVWnN27XI3fDcHv8gcy1Sk34rP/2+zY3rVjgac
        DUDprnEnjAC5I55v/zWRtcfdCkdtjVnrNq5ir3arzOKHnsyC9yJEC2XNj+DmdxfJbuGHa9
        YCAeEM6lsU0ulctTwMK154VMv12Y5c92F6x1echwCe6n9er2/w1cZkeemGlsog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1eoy5klb8svAdIn9/UXgJevyTb9Ww/jSlczBpVi7ZNQ=;
        b=lssgXrIntPIE3+KeFtioEjxQhOZYiNdcS54BaTMXZbEgYUywepWrJcAAiZpO710cCWZsWo
        53HbHOG5ATwx3aBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 9/9] scripts/spdxcheck: Exclude top-level README
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:35 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing copyrightable to see here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxexclude |    1 +
 1 file changed, 1 insertion(+)

--- a/scripts/spdxexclude
+++ b/scripts/spdxexclude
@@ -21,3 +21,4 @@ arch/*/configs/
 # Other files without copyrightable content
 /CREDITS
 /MAINTAINERS
+/README

