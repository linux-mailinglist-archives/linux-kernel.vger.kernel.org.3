Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EA04BBF55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiBRSRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiBRSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C25C2BB09;
        Fri, 18 Feb 2022 10:16:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so15893589wra.12;
        Fri, 18 Feb 2022 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zy0x5Exl42nPFRLYIWGzellcEZxdd2iOka5tuDBPYC8=;
        b=cyjXjfe3ONdltPjRdTnXzyxbcybIdQNRtyvVzBCT6kdlJHlLJ1HOp9B7tE3KqdiGG1
         DL54NEkkZeZZXX6HHRkqsmLlDobihm91Ff5NLnEe8J2bxpPW3IK7JVZ3BqKWlJ9moC9N
         kVp3jMKfnwCwYTUqrx0ZaSRcX9EefehtWyGV14W+oe6DArFmFgRO8SoSyysCZtxf1/cM
         iHDY3t+07hkIMZEh/vpvynSgIwKuOh6zxb4jj/FwL1V5VnBbh0p1w413RKKyFwblbjwf
         +lABf2GRLwK8Cxvv44uSXEfYjhk+/bqgTakwg+yPSaizb7TSjCgqJKq5SNwWT9EbFg9m
         ViIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zy0x5Exl42nPFRLYIWGzellcEZxdd2iOka5tuDBPYC8=;
        b=d7mLPPJ0k8RiS6v9u2vxeSxKu/GMbRG1sESBOmvr0QkRU3uoUSOTeVmeFZiAj5eUVT
         hGV6H/TqxQ/QuFkWg9YhIKZX8hXxcaO1gQXLqF3e6RCicjbT/Jz7THOMMsoIaDSdd+EF
         CHhmvJTingRx4ygjN4RVwUP34KHewbPFKsK/PaF5+gQanFKjtJ/CzvM0kP3wuOIBdpzG
         PNKBv9up1tiEMnHqwt7mMnBKmojTmoYfnZ/RV5aXLMyZ6EXskJFreim13y5k9KLLQpib
         PTcjfrLMBcVTxSeHUlVsqBN9NUSEgvIOyMY+D2lKJRFZnSV0K7vtJmlN/Hem3O1/cg0G
         gzBw==
X-Gm-Message-State: AOAM530aHMcm+ckv2gM4O8ewzTenarbWlzwkQIV2GiAGhkHxd6m8fYmG
        uj+r5gCmiJ3J7zEsDbUsX+E=
X-Google-Smtp-Source: ABdhPJzpovEpj7/M1EHMrOkky5VoS8NsJiOXMRA/hm047XIGVhy+R7UCEnZAe3QNt9GU/1U/M9t87g==
X-Received: by 2002:a5d:64cc:0:b0:1e8:f4ad:bf85 with SMTP id f12-20020a5d64cc000000b001e8f4adbf85mr5953050wri.630.1645208210622;
        Fri, 18 Feb 2022 10:16:50 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:50 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v4 10/11] scripts: kernel-doc: Drop obsolete comments
Date:   Fri, 18 Feb 2022 19:16:27 +0100
Message-Id: <20220218181628.1411551-11-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What for? To improve the script maintainability.

1. License

As stated by Jonathan Corbet in the reply to my version 1, the SPDX line
is enough.

2. The to-do list comment

As suggested by Jonathan Corbet in reply to my version 3, this section
doesn't need to be transitioned. And so it is removed for clarity.

3. The historical changelog comments

As suggested by Jonathan Corbet in a reply to v3, this section can go.
I wanted to keep it, but since it doesn't contain copyright notices,
let's just have it clean and simple.

4. The "format of comments" comment block

As suggested by Jani Nikula in a reply to my first version of this
transformation, Documentation/doc-guide/kernel-doc.rst can serve as the
information hub for comment formatting. The section DESCRIPTION already
points there, so the original comment block can just be removed.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 143 ---------------------------------------------
 1 file changed, 143 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index d7ca4877eeda..a5a397e22ea7 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -12,9 +12,6 @@ use strict;
 ## 								 ##
 ## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
 ## Copyright (c) 2000 MontaVista Software, Inc.			 ##
-## 								 ##
-## This software falls under the GNU General Public License.     ##
-## Please read the COPYING file for more information             ##
 
 use Pod::Usage qw/pod2usage/;
 
@@ -54,146 +51,6 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 
 # more perldoc at the end of the file
 
-# 18/01/2001 - 	Cleanups
-# 		Functions prototyped as foo(void) same as foo()
-# 		Stop eval'ing where we don't need to.
-# -- huggie@earth.li
-
-# 27/06/2001 -  Allowed whitespace after initial "/**" and
-#               allowed comments before function declarations.
-# -- Christian Kreibich <ck@whoop.org>
-
-# Still to do:
-# 	- add perldoc documentation
-# 	- Look more closely at some of the scarier bits :)
-
-# 26/05/2001 - 	Support for separate source and object trees.
-#		Return error code.
-# 		Keith Owens <kaos@ocs.com.au>
-
-# 23/09/2001 - Added support for typedefs, structs, enums and unions
-#              Support for Context section; can be terminated using empty line
-#              Small fixes (like spaces vs. \s in regex)
-# -- Tim Jansen <tim@tjansen.de>
-
-# 25/07/2012 - Added support for HTML5
-# -- Dan Luedtke <mail@danrl.de>
-
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

