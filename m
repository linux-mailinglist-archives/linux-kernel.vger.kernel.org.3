Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64F24E8076
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiCZK3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiCZK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B27F55BD;
        Sat, 26 Mar 2022 03:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEE7EB803F1;
        Sat, 26 Mar 2022 10:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79409C2BBE4;
        Sat, 26 Mar 2022 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648290447;
        bh=o9c+IInErQpOAwntbwHfaT1J5iPpxLk5tRtpR93Le08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6UPQkpP18rB1ORZ3Pbg4YA9yl/Tp/GNYjzgOsyPhpBjSLe8EBIrpKC3QLxtQqDqO
         7CKGLserdlk2jN3oD5b82gyqYjuR1UTrZ1xKoYyfv6cvdqRH4h+9LmXD1cavbg+/5J
         5+//98a4m3gzjmrtgJO1w5yEMlPkRzy8PydbO1Pvv+NrTY2WdLfcHfHQ3wcES4EXu+
         Zx+JPedWul3mTD+34SbzNYpHY+6I39DttErwQPQevAWGPNZQNLO2e93VELF1T+2bpy
         7eaXNcWRmcUJh8f2GaqggbcFKGIxEqI0pxm9uW6tK+1O+Px0elJgZPzccMKyrWFDEX
         TXipT+Fgbk/Ow==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nY3dl-00Co0k-87; Sat, 26 Mar 2022 11:27:25 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] scripts/get_abi: change the file/line number meta info
Date:   Sat, 26 Mar 2022 11:27:23 +0100
Message-Id: <125ffd31fbc77ad9eee4d6906e1830b8162fa6ca.1648290305.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648290305.git.mchehab@kernel.org>
References: <cover.1648290305.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make it more standard and ReST compatible,
change the meta-tag used with --enable-lineno from:

	#define LINENO

to
	.. LINENO

In practice, no functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 0/6] at: https://lore.kernel.org/all/cover.1648290305.git.mchehab@kernel.org/

 Documentation/sphinx/kernel_abi.py | 2 +-
 scripts/get_abi.pl                 | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index efab9b14a9f5..b5feb5b1d905 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -138,7 +138,7 @@ class KernelCmd(Directive):
                 code_block += "\n    " + l
             lines = code_block + "\n\n"
 
-        line_regex = re.compile("^#define LINENO (\S+)\#([0-9]+)$")
+        line_regex = re.compile("^\.\. LINENO (\S+)\#([0-9]+)$")
         ln = 0
         n = 0
         f = fname
diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 7437e19ba3ac..1389db76cff3 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -327,7 +327,7 @@ sub output_rest {
 		my @filepath = split / /, $data{$what}->{filepath};
 
 		if ($enable_lineno) {
-			printf "#define LINENO %s%s#%s\n\n",
+			printf ".. LINENO %s%s#%s\n\n",
 			       $prefix, $file[0],
 			       $data{$what}->{line_no};
 		}
@@ -1023,7 +1023,7 @@ logic (B<--no-rst-source>).
 
 =item B<--enable-lineno>
 
-Enable output of #define LINENO lines.
+Enable output of .. LINENO lines.
 
 =item B<--debug> I<debug level>
 
-- 
2.35.1

