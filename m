Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C658CFB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbiHHVcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244025AbiHHVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFB1836E;
        Mon,  8 Aug 2022 14:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618FF60F40;
        Mon,  8 Aug 2022 21:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843AAC433B5;
        Mon,  8 Aug 2022 21:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659994322;
        bh=sPldY5OOK0lFXoqD+bbxVQOlfH0Oqs80plXbsIzeR9w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=B5I15c/dWoLtGLxHhvS2ExxITF/WoTYpULPDVs89KRar3yiWS1ZGFA3wns3af3fdv
         vP+bofpb+0jBEvs8G1/5kFF43PL27ey6w4i8qGkoUji9S1V9IYy6QvqcyzRp77WyOv
         WVDQMJ+q7sqql7ZJNh5gBbmFpQbBfoEm+9DtVMm8=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Mon, 08 Aug 2022 17:31:50 -0400
Subject: [PATCH v2 2/5] maintainer-pgp-guide: remove keyserver instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220727-docs-pgp-guide-v2-2-e3e6954affb6@linuxfoundation.org>
References: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
In-Reply-To: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-fe10a
X-Developer-Signature: v=1; a=openpgp-sha256; l=5444;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=sPldY5OOK0lFXoqD+bbxVQOlfH0Oqs80plXbsIzeR9w=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJI+NlyS3nft2897+xfOuCIuP4n/KOf6J9/FtmpGsBmquVrs
 WLRJs6OUhUGMi0FWTJGlbF/spqDChx5y6T2mMHNYmUCGMHBxCsBEYuIZ/ilMKU1X319w+tO9aR2MR2
 ZMsAgIU81ULv2UZsLP8Pf81PcMfzjWFtnVxh7z/JXkLD61ZU1ViPWy2xX8i8MKr7JIc0t8ZgEA
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

Keyservers are largely a thing of the past with the replacement systems
like keys.openpgp.net specifically designed to offer no support for the
web of trust. Remove all sections that talk about keyservers and add a
small section with the link to kernel.org documentation that talks about
using the kernel.org public key repository.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 7dada4eaedca..ead5bc815017 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -121,18 +121,6 @@ edit your ``~/.gnupg/gpg-agent.conf`` file to set your own values::
     to remove anything you had in place for older versions of GnuPG, as
     it may not be doing the right thing any more.
 
-Set up a refresh cronjob
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-You will need to regularly refresh your keyring in order to get the
-latest changes on other people's public keys, which is best done with a
-daily cronjob::
-
-    @daily /usr/bin/gpg2 --refresh >/dev/null 2>&1
-
-Check the full path to your ``gpg`` or ``gpg2`` command and use the
-``gpg2`` command if regular ``gpg`` for you is the legacy GnuPG v.1.
-
 .. _protect_your_key:
 
 Protect your PGP key
@@ -229,11 +217,6 @@ separate signing subkey::
 
     $ gpg --quick-addkey [fpr] ed25519 sign
 
-Remember to tell the keyservers about this change, so others can pull down
-your new subkey::
-
-    $ gpg --send-key [fpr]
-
 .. note:: ECC support in GnuPG
 
     GnuPG 2.1 and later has full support for Elliptic Curve
@@ -907,65 +890,17 @@ the new default in GnuPG v2). To set it, add (or modify) the
 
     trust-model tofu+pgp
 
-How to use keyservers (more) safely
------------------------------------
-
-If you get a "No public key" error when trying to validate someone's
-tag, then you should attempt to lookup that key using a keyserver. It is
-important to keep in mind that there is absolutely no guarantee that the
-key you retrieve from PGP keyservers belongs to the actual person --
-that much is by design. You are supposed to use the Web of Trust to
-establish key validity.
-
-How to properly maintain the Web of Trust is beyond the scope of this
-document, simply because doing it properly requires both effort and
-dedication that tends to be beyond the caring threshold of most human
-beings. Here are some shortcuts that will help you reduce the risk of
-importing a malicious key.
-
-First, let's say you've tried to run ``git verify-tag`` but it returned
-an error saying the key is not found::
-
-    $ git verify-tag sunxi-fixes-for-4.15-2
-    gpg: Signature made Sun 07 Jan 2018 10:51:55 PM EST
-    gpg:                using RSA key DA73759BF8619E484E5A3B47389A54219C0F2430
-    gpg:                issuer "wens@...org"
-    gpg: Can't check signature: No public key
-
-Let's query the keyserver for more info about that key fingerprint (the
-fingerprint probably belongs to a subkey, so we can't use it directly
-without finding out the ID of the master key it is associated with)::
-
-    $ gpg --search DA73759BF8619E484E5A3B47389A54219C0F2430
-    gpg: data source: hkp://keys.gnupg.net
-    (1) Chen-Yu Tsai <wens@...org>
-          4096 bit RSA key C94035C21B4F2AEB, created: 2017-03-14, expires: 2019-03-15
-    Keys 1-1 of 1 for "DA73759BF8619E484E5A3B47389A54219C0F2430".  Enter number(s), N)ext, or Q)uit > q
-
-Locate the ID of the master key in the output, in our example
-``C94035C21B4F2AEB``. Now display the key of Linus Torvalds that you
-have on your keyring::
-
-    $ gpg --list-key torvalds@kernel.org
-    pub   rsa2048 2011-09-20 [SC]
-          ABAF11C65A2970B130ABE3C479BE3E4300411886
-    uid           [ unknown] Linus Torvalds <torvalds@kernel.org>
-    sub   rsa2048 2011-09-20 [E]
-
-Next, find a trust path from Linus Torvalds to the key-id you found via ``gpg
---search`` of the unknown key.  For this, you can use several tools including
-https://github.com/mricon/wotmate,
-https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/graphs, and
-https://the.earth.li/~noodles/pathfind.html.
-
-If you get a few decent trust paths, then it's a pretty good indication
-that it is a valid key. You can add it to your keyring from the
-keyserver now::
-
-    $ gpg --recv-key C94035C21B4F2AEB
-
-This process is not perfect, and you are obviously trusting the
-administrators of the PGP Pathfinder service to not be malicious (in
-fact, this goes against :ref:`devs_not_infra`). However, if you
-do not carefully maintain your own web of trust, then it is a marked
-improvement over blindly trusting keyservers.
+Using the kernel.org web of trust repository
+--------------------------------------------
+
+Kernel.org maintains a git repository with developers' public keys as a
+replacement for replicating keyserver networks that have gone mostly
+dark in the past few years. The full documentation for how to set up
+that repository as your source of public keys can be found here:
+
+- `Kernel developer PGP Keyring`_
+
+If you are a kernel developer, please consider submitting your key for
+inclusion into that keyring.
+
+.. _`Kernel developer PGP Keyring`: https://korg.docs.kernel.org/pgpkeys.html

-- 
b4 0.10.0-dev-fe10a
