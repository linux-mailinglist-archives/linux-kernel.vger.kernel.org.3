Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C13958475C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiG1U5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiG1U5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2443E7821B;
        Thu, 28 Jul 2022 13:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACD5361871;
        Thu, 28 Jul 2022 20:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6B6C433D6;
        Thu, 28 Jul 2022 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659041847;
        bh=fG+3nCW7qlAcg2TRLEYO2j/tO09JErrxFIGTuZ1+Pkw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=0/5X582XPxczuTXnk7ACfcWOa2ZKA1vmxSM+qKOfITTzTkSFClTvq27pI2+/YjS3R
         PHvittK0SFrABTC8euKI6f6vfRG9DpmoDppNwOnn94/Ic1mI35GpL4liwiQvQHsial
         bd2wXSd9yICLuB1SJOC8sFXOQWAdsHUVMtyRcX4c=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Thu, 28 Jul 2022 16:57:08 -0400
Subject: [PATCH v1 5/5] maintainer-pgp-guide: minor wording tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220727-docs-pgp-guide-v1-5-c48fb06cb9af@linuxfoundation.org>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
In-Reply-To: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-49460
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=fG+3nCW7qlAcg2TRLEYO2j/tO09JErrxFIGTuZ1+Pkw=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJIe/TD3cVbhvLDXX71r4cy+BfyWTe+WzTM/6nTA8pDlXUvD
 uK5XHaUsDGJcDLJiiixl+2I3BRU+9JBL7zGFmcPKBDKEgYtTACbSUsDIcFjOoc6Db4p1tqa6/1e51S
 WOv82NX73Zs9vXZcODwtjDXowMlwz+B0ul7O77ovBitbXzeX6d+k+3yvL4mfN4Hqd9izdhBgA=
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak some wording to remove redundant information or fix spacing.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 2ce38e5d547d..ea74c87d09d8 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -265,9 +265,7 @@ home, such as your bank vault.
     Your printer is probably no longer a simple dumb device connected to
     your parallel port, but since the output is still encrypted with
     your passphrase, printing out even to "cloud-integrated" modern
-    printers should remain a relatively safe operation. One option is to
-    change the passphrase on your master key immediately after you are
-    done with paperkey.
+    printers should remain a relatively safe operation.
 
 Back up your whole GnuPG directory
 ----------------------------------
@@ -311,7 +309,7 @@ Remove the Certify key from your homedir
 ----------------------------------------
 
 The files in our home directory are not as well protected as we like to
-think.  They can be leaked or stolen via many different means:
+think. They can be leaked or stolen via many different means:
 
 - by accident when making quick homedir copies to set up a new workstation
 - by systems administrator negligence or malice

-- 
b4 0.10.0-dev-49460
