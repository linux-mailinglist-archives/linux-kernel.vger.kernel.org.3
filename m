Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9043A58755C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiHBBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiHBByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:54:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756C491C5;
        Mon,  1 Aug 2022 18:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B362AB81910;
        Tue,  2 Aug 2022 01:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3072AC433C1;
        Tue,  2 Aug 2022 01:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405205;
        bh=PsjJEscwfqiEIk6jnESsddoju9xgCRns2EXUi58QroI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuZWVJhICWqRc9EDLzclZryn6L/AoqP8sC8+o/riXbBmNujCAKm8wb1YIRxojmXH2
         7U94MjeHsW2ujQyzyJQGn+Ws+8qkw0Up8iAGw7OSMIVDmbbIYpRuMV1HdatOXWPEe1
         ki3Yzb76aBRIk2/oK0aVPbcpJMIpCUQBqTtWf3z6L3zgl4rTiChYFPwBl42WuN2VI6
         V1yKS64H5gsaauWDTVIC6o3IzZLm64089oz+/n9jt7eK+4K+hS+UkiP+V4XBe99aoE
         ZinuOFDk7TL1lfrXtUr1OYK/ELeQBV3WET+0m+D+SSAR+HQEtPjLvVqdQIeU76BccT
         db/wmZ/mZQ4Hg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Subject: [PATCH v8 25/31] configs: add `rust` config
Date:   Tue,  2 Aug 2022 03:50:12 +0200
Message-Id: <20220802015052.10452-26-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@google.com>

This allows us to enable Rust while creating a configuration file, for
example, we can run `make defconfig rust.config` from the command line
to create the default configuration plus enable Rust.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 kernel/configs/rust.config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 kernel/configs/rust.config

diff --git a/kernel/configs/rust.config b/kernel/configs/rust.config
new file mode 100644
index 000000000000..38a7c5362c9c
--- /dev/null
+++ b/kernel/configs/rust.config
@@ -0,0 +1 @@
+CONFIG_RUST=y
-- 
2.37.1

