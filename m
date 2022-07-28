Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD96584759
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiG1U5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiG1U5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:57:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D078217;
        Thu, 28 Jul 2022 13:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDFE1B82452;
        Thu, 28 Jul 2022 20:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7351AC433B5;
        Thu, 28 Jul 2022 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659041844;
        bh=8dIeFV2FLAQnlvQroUFMUht8gP6P+wqqv7jUG5cFvf8=;
        h=Subject:From:Date:To:Cc:From;
        b=QixZkn7HvzK4R8Y9f/kXmvavOvgPVOVyZEBPBiKNq4V6QmbllFHJpDdn639rIMoBm
         LIX5ygr6LD8kWZI2OCroVvr1Ldubu3mk0ISiRcWKfmzydZQI9L2N9mmPCBUyNT+W+I
         sxtbnAoNnyXEG3S3A7JulzEniJiXYBQS67RtdQ74=
Subject: [PATCH v1 0/5] Update the maintainer PGP guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Thu, 28 Jul 2022 16:57:03 -0400
Message-Id: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
X-b4-tracking: H4sIADT44mIC/w3LwQqAIAwA0F+JnRuoRFF/Y3PqIFQcdYn+PY/v8F5Q7sIKx/RC50dUahmw8wSUfU
 mMEobBGefM5jYMlRRbaphuCYw2RNrtahcyEUY6vTKe3RfKo5X7ur7vB/PK8XplAAAA
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-49460
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=8dIeFV2FLAQnlvQroUFMUht8gP6P+wqqv7jUG5cFvf8=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJIe/TCRkRK0zuBceFrhduiPltLdq7WUelmPnFL35VNY+27d
 VC7FjlIWBjEuBlkxRZayfbGbggofesil95jCzGFlAhnCwMUpABMpVGRkaIr6F9ZVFXpEet+qNdNsui
 dIr00KvyA4fZdWxJ4Vt/xD/jP8d5muIzZt37SZPfPjudWNxPOk5lpxr6ycVaQTuktCPruVGQA=
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

This series updates the guide to match terminology used in the upstream
"protecting code integrity" guide [1] and brings the documentation in
line with the latest developments in the GnuPG world:

- uses "Certify key" instead of "master key" terms to remove common
  confusion that the "Certify key" is somehow able to restore lost
  private subkeys
- removes keyserver instructions because keyservers have largely gone
  semi-extinct due to GDPR enforcement and just general neglect
- adds a link to the kernel.org PGP keyring documentation
- updates information about ECC curve support among the devices the
  guide talks about (Yubikeys are able to use ED25519 curves with the
  latest firmware updates)
- adds a section on using PGP-signed patches with b4 and patatt

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

---
Konstantin Ryabitsev (5):
      maintainer-pgp-guide: use key terminology consistent with upstream
      maintainer-pgp-guide: remove keyserver instructions
      maintainer-pgp-guide: update ECC support information
      maintainer-pgp-guide: add a section on PGP-signed patches
      maintainer-pgp-guide: minor wording tweaks

 Documentation/process/maintainer-pgp-guide.rst | 287 ++++++++++++-------------
 1 file changed, 142 insertions(+), 145 deletions(-)
---
base-commit: e0dccc3b76fb35bb257b4118367a883073d7390e
change-id: 20220727-docs-pgp-guide-1dfc91614c0f

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>
