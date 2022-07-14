Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28206574C08
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiGNL1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiGNL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A62B58879
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DED761B75
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97D9C3411C;
        Thu, 14 Jul 2022 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798067;
        bh=SD3jecQUKQiJHuXwCvcq11EL2LTpQ6ytcH9yFhQwQlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOTESsBMkFtZm21u9XPlYhBjBk6tmjavKb+TjkVrU3d4QNTk55mRLkNnFkJQTUe26
         GH/a2vMZCLPyQdT01fw4qoieU5rIhg/jxsPT0MNGVE4KmIyew+WYhEbbRcxcg9wpY2
         TOGXNon1bxSutHlOdadqkQaYyTYt5TUlN3v/nC0oMSbURKKP7TsS3gQBtkhlZOpKxw
         FTO85Dw3fuMcbea/PRhyaY8g7VhPt9Mrb9g0bCjJKo1H1u0vCzixYh532Ium0CgcpD
         MKNV1EdI629f6dP9P35AIAVODzvpI7Ta/5we6PtUFx+tQ1MZTJhL6mv5uZZsE2W+8f
         b9w/9hcJASl4A==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: [PATCH 1/8] MAINTAINERS: Use Lee Jones' kernel.org address for MFD submissions
Date:   Thu, 14 Jul 2022 12:25:26 +0100
Message-Id: <20220714112533.539910-2-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220714112533.539910-1-lee@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going forward, I'll be using my kernel.org for upstream work.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f96b480000a2..dad7f26edf5ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13825,7 +13825,7 @@ F:	Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.yaml
 F:	drivers/media/i2c/mt9v111.c
 
 MULTIFUNCTION DEVICES (MFD)
-M:	Lee Jones <lee.jones@linaro.org>
+M:	Lee Jones <lee@kernel.org>
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
 F:	Documentation/devicetree/bindings/mfd/
-- 
2.37.0.144.g8ac04bfd2-goog

