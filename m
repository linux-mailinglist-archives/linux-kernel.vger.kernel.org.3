Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4474C58CFB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbiHHVcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbiHHVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:32:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EDF1AF2D;
        Mon,  8 Aug 2022 14:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0620B81057;
        Mon,  8 Aug 2022 21:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBAEC433D6;
        Mon,  8 Aug 2022 21:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659994321;
        bh=xWCUcAeqCWwt1kkZKOVSQ9s4ddOJ8FaQ1qoekkR/JGI=;
        h=Subject:From:Date:To:Cc:From;
        b=ExI/Rvvb4OXLwnOsUTBlbPbQGlA9jDSFb/4OpQNBKMfYiRRWoIML21Sstn3YBU6gU
         Fc+PLPr5pz7oowF0ira+zgpYNir5qptQPQa1zWOt5OubIxgIiahezmXbmFQ0wbgzVO
         Tbm2To6tWzI8gJKWFpVkrUClDDbjrG2N/dj2zpls=
Subject: [PATCH v2 0/5] Update the maintainer PGP guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Mon, 08 Aug 2022 17:31:48 -0400
Message-Id: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
X-b4-tracking: H4sIANGA8WIC/3WOzQqDMBCEX0X23C1JEK099T1KD8nmx4AkkhhpEd+9S+89DTPwzcwB1ZXoKty7A4
 rbY405sVGXDmjWKTiMlj0ooZQY1Yg2U8U1rBhatA6l9TTJQfYkPDBkdHVoik40M5basnA4x7rl8vmN
 7JLl+bdvlyiQ+ps3YiAzaf9YYmpvn1uyeuNz11wCvM7z/AIf2asfuwAAAA==
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-fe10a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=xWCUcAeqCWwt1kkZKOVSQ9s4ddOJ8FaQ1qoekkR/JGI=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJI+NlycmhFWmnFh4qkTHz70Oa5lt6i7KCUY+89NNoJ3W9+K
 4kd3O0pZGMS4GGTFFFnK9sVuCip86CGX3mMKM4eVCWQIAxenAExk8WRGhi9X4n1nCSX5bdT4cSNEM3
 33k3993jLzLq7dFypQa9UuacvwV/5I3rbKT8Z7Jn1S8jmgEzL35LF9vReWCn3xbfu24GPPHQYA
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the guide to match terminology used in the upstream
"protecting code integrity" guide and brings the documentation in line
with the latest developments in the GnuPG world:

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

Link: https://github.com/lfit/itpol/blob/master/protecting-code-integrity.md
Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

---
Changes in v2:
- Rebase on v5.19.
- Small wording changes based on feedback.
- Link to v1: https://lore.kernel.org/r/20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org

---
Konstantin Ryabitsev (5):
      maintainer-pgp-guide: use key terminology consistent with upstream
      maintainer-pgp-guide: remove keyserver instructions
      maintainer-pgp-guide: update ECC support information
      maintainer-pgp-guide: add a section on PGP-signed patches
      maintainer-pgp-guide: minor wording tweaks

 Documentation/process/maintainer-pgp-guide.rst | 286 ++++++++++++-------------
 1 file changed, 142 insertions(+), 144 deletions(-)
---
base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
change-id: 20220727-docs-pgp-guide-1dfc91614c0f

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>
