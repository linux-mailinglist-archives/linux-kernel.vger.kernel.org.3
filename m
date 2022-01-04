Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7079B483A6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiADCAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiADCAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F7C061799;
        Mon,  3 Jan 2022 18:00:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o3so14842633wrh.10;
        Mon, 03 Jan 2022 18:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQtuX7PnzQb1a86BihNMH5QlslE8Ui1MxXpx4wzRIaE=;
        b=hG/CD/zWmn8lRNG7hIMn8AfcNWR5Upf9Ng5erTBZRbGF90VLTTPS5PGrSlR8b17LtS
         NnIqa3OAB9lJvXISTlEig4a8uqJpsjlDuxxItOMk0xzP7mhsRlYTPDH9/xokqOuCOUvx
         7oBgVNTr4gmpA/5WWXnIUANLDg62QYYc8fC96utMrk7vYU0+nCBnCPS9kVlMd5x8lxXe
         0pzJmVi23Ax36J4nLjiqpczNzAzrgn91JSjLVAlbwaF6I6VBDmhnvH8C0Ok1l76Tg4hF
         41w+0PNgmpFDIRXzrDfKM/rIyz4Gx3SKUIpEHjtyLFkzLkj8U7R1pHO/b2r42VTtB6Ys
         3Z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQtuX7PnzQb1a86BihNMH5QlslE8Ui1MxXpx4wzRIaE=;
        b=UJOyV/D8pjQqmXOvpJgDCGE02Mkxd87slslpztpvRcNYwIchgDep/MWV5e6Awr1qMG
         h9fYYspLir2twDKPPnYFT9fkgumF/E8oqwHlAQcCR1g4rSLwdi6GOII3hHtv9EYH74ft
         Lj+6ae1IbPiGL8UbX0FUWUauSFbZH9WoEN0A5a1bhSGHc72xxM/cyc4pF4BbKvyfdY+3
         h3PQ36a5AyuTwqv1Msu7KDs3G7ukrnH5lr8f51Z6AXy3pE3op1LBo3FLVIAio2MuZecq
         AZVG6drAsIK0r+fEw71BfGoguB1H2iDpCia7ESWSc1u9fveIqIwfnkBb4ALJmm/msZjD
         o5gQ==
X-Gm-Message-State: AOAM530onOW/z1MY+kzIKBkovl1mtS6VEW1bnyTGM1HNSGXrofad9Wsg
        3o5Sqph9oRRjRkHRQVOlse8=
X-Google-Smtp-Source: ABdhPJz+s6TKmSDF3SORmTjVP+66m//a/ECamkarHGRRSkaNHv2RUlss+V4mITyI0P0eljwvTEFqOA==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr40409713wry.406.1641261608888;
        Mon, 03 Jan 2022 18:00:08 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:08 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v3 11/15] scripts: kernel-doc: Remove the "format of comments" comment block
Date:   Tue,  4 Jan 2022 02:59:42 +0100
Message-Id: <20220104015946.529524-12-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Jani Nikula in a reply to my first version of this
transformation, Documentation/doc-guide/kernel-doc.rst can serve as the
information hub for comment formatting. The section DESCRIPTION already
points there, so the original comment block can just be removed.

* Transform documentation into POD (11/15)
See step 1 for the series details.

= Meta note =

I guess, I should use the Suggested-by tag for credits.
Maintainers, please correct this if I'm doing this wrong.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 115 ---------------------------------------------
 1 file changed, 115 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index b4852c2ba243..493c024744b0 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -79,121 +79,6 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 # 25/07/2012 - Added support for HTML5
 # -- Dan Luedtke <mail@danrl.de>
 
-#
-# format of comments.
-# In the following table, (...)? signifies optional structure.
-#                         (...)* signifies 0 or more structure elements
-# /**
-#  * function_name(:)? (- short description)?
-# (* @parameterx: (description of parameter x)?)*
-# (* a blank line)?
-#  * (Description:)? (Description of function)?
-#  * (section header: (section description)? )*
-#  (*)?*/
-#
-# So .. the trivial example would be:
-#
-# /**
-#  * my_function
-#  */
-#
-# If the Description: header tag is omitted, then there must be a blank line
-# after the last parameter specification.
-# e.g.
-# /**
-#  * my_function - does my stuff
-#  * @my_arg: its mine damnit
-#  *
-#  * Does my stuff explained.
-#  */
-#
-#  or, could also use:
-# /**
-#  * my_function - does my stuff
-#  * @my_arg: its mine damnit
-#  * Description: Does my stuff explained.
-#  */
-# etc.
-#
-# Besides functions you can also write documentation for structs, unions,
-# enums and typedefs. Instead of the function name you must write the name
-# of the declaration;  the struct/union/enum/typedef must always precede
-# the name. Nesting of declarations is not supported.
-# Use the argument mechanism to document members or constants.
-# e.g.
-# /**
-#  * struct my_struct - short description
-#  * @a: first member
-#  * @b: second member
-#  *
-#  * Longer description
-#  */
-# struct my_struct {
-#     int a;
-#     int b;
-# /* private: */
-#     int c;
-# };
-#
-# All descriptions can be multiline, except the short function description.
-#
-# For really longs structs, you can also describe arguments inside the
-# body of the struct.
-# eg.
-# /**
-#  * struct my_struct - short description
-#  * @a: first member
-#  * @b: second member
-#  *
-#  * Longer description
-#  */
-# struct my_struct {
-#     int a;
-#     int b;
-#     /**
-#      * @c: This is longer description of C
-#      *
-#      * You can use paragraphs to describe arguments
-#      * using this method.
-#      */
-#     int c;
-# };
-#
-# This should be use only for struct/enum members.
-#
-# You can also add additional sections. When documenting kernel functions you
-# should document the "Context:" of the function, e.g. whether the functions
-# can be called form interrupts. Unlike other sections you can end it with an
-# empty line.
-# A non-void function should have a "Return:" section describing the return
-# value(s).
-# Example-sections should contain the string EXAMPLE so that they are marked
-# appropriately in DocBook.
-#
-# Example:
-# /**
-#  * user_function - function that can only be called in user context
-#  * @a: some argument
-#  * Context: !in_interrupt()
-#  *
-#  * Some description
-#  * Example:
-#  *    user_function(22);
-#  */
-# ...
-#
-#
-# All descriptive text is further processed, scanning for the following special
-# patterns, which are highlighted appropriately.
-#
-# 'funcname()' - function
-# '$ENVVAR' - environmental variable
-# '&struct_name' - name of a structure (up to two words including 'struct')
-# '&struct_name.member' - name of a structure member
-# '@parameter' - name of a parameter
-# '%CONST' - name of a constant.
-# '``LITERAL``' - literal string without any spaces on it.
-
 ## init lots of data
 
 my $errors = 0;
-- 
2.30.2

