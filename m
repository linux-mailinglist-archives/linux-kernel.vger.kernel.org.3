Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5D528210
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbiEPK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbiEPK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204CE12626;
        Mon, 16 May 2022 03:27:34 -0700 (PDT)
Message-ID: <20220516102615.824675061@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=keWFZaYM3pBWFQL5eIcbG+1HbVJ3I2JMHzQ+elRSrxM=;
        b=QQvwH2yazLnIQpol2NnIQyjNVa7cbaZyfJ2Il6/Kzj5alqumg2cfd2+gxQzFcWO7nlfXwE
        NFRPim8kv5DIMovcYJuaVkwRlP2F4YMKX1I39pwqCo2RKVVhCU2sR4h+lupqEO2CXFcE8A
        xSf07F/ZV75ukk9ajU/c7KxEL93Z8OJRYnfD3WOYR2GSJjsz5GF6grZRik0nwF3jIS5r8G
        xEKCPR134EWVvXAeC3nvsdeauWVMz4hlq7FCVB14oVz7mVpc2/K5F2UBbDKQvSfIQStFtl
        Yk8rkgDgyD+VcRDttWmlKacfKuTHBdi1qXh454owPdwLMsvq23rB0oYyHYTEhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=keWFZaYM3pBWFQL5eIcbG+1HbVJ3I2JMHzQ+elRSrxM=;
        b=WEqQzAxHOkuYnp8pikfGWwIZy3UDO9Kz4tHS5b27dLDWdbMmrsSGdjFAm+epgpabA3Qm0C
        w+jO4M/Gl3TTZ/Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 7/9] scripts/spdxcheck: Exclude MAINTAINERS/CREDITS
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:32 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Listings of maintainers and people who deserve credits are not really
interesting in terms of copyright. The usage of these files outside of the
kernel is pointless and the file format is trivial. No point in chasing
them or slapping a SPDX identifier into them just because.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxexclude |    4 ++++
 1 file changed, 4 insertions(+)

--- a/scripts/spdxexclude
+++ b/scripts/spdxexclude
@@ -11,3 +11,7 @@ license-rules.rst
 # by the Kconfig tools
 kernel/configs/
 arch/*/configs/
+
+# Other files without copyrightable content
+/CREDITS
+/MAINTAINERS

