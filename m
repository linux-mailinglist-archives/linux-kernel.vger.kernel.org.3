Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944AC5885F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiHCDFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiHCDF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:05:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476BEE2E;
        Tue,  2 Aug 2022 20:05:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d7so10931754pgc.13;
        Tue, 02 Aug 2022 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=dKrbTswEBKps4LIBfZnVxO0RT3I4OW4FVzxRQv/5Wxg=;
        b=AGr+IwSBcS/eiBTqOW/VDhJljU/KBlPe4jGdwarBPm0x2lwhoi9BOKR9B5HsLkzELy
         +zdEOXmNOqXeIMAqKWnWigkLwgESDIAkDCvvU3c7FIxMev29nIcVoo02fx5huTkFt+12
         CAGfo6BqOSbYlf92DhsatL3mCmqe83HlxTyuptitgiXAnacKroosYsOKIJ+wvBULWqBr
         xUdFo4IyziBH7KbC4xHzGtWDxNwkOznc7tLFKyLAnw0rrNlSqY+beHiv6xYegfzdfdGA
         cCdOIOs72+UsMAS9Md7OpIbFv9pi4OII8zq/j4QgcyMp5wGQgX2sqyW+bFgE1ORI39kw
         AH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=dKrbTswEBKps4LIBfZnVxO0RT3I4OW4FVzxRQv/5Wxg=;
        b=dIpO/I9b6drPuXTwhP3U+AImUiMJYmDF5kmMd25Mg0EkmCIupF8G6FSeLZisAnzyLC
         PCqLwYSt6bn884CsQFmCL5Ce9LVWz6C7xCnklg8AnFVCxmz2Kavey6LFbGZaWGIqHEfV
         Bsm4bcGDDsO0so/GDVRxEBsJFcEj5zDh7Ed3NgDD268LvGqPJZA05KfycsVTJWnAphbL
         DkyrtDtF52N6RoTGxI3xV7xUFxT2e6Z9GQ92hDuornkEONfsIP8eB2IWJxgKWt5majK1
         KqTyG5bumR20cSLlN5gLXeKnFzn5tbNZJKvvjuGWMJNgn3cU/LylOag0nPj9Tq4neaN7
         FR0A==
X-Gm-Message-State: ACgBeo39J68OAzNFu5GJ7OIek/pg9DwvPcjBZU6LM1pODthhL1XKpaL4
        x0lrF9mZrTx7uOqZ9tGiRn3RnoHVejA=
X-Google-Smtp-Source: AA6agR7zh+sV6/bWM+G4hEa3KLn7GkRm0SuI1ytXV+WYDsgEhV5SbeKEVIuxsU6MH095hnKOSvQz0A==
X-Received: by 2002:aa7:8f13:0:b0:52d:fe17:ce11 with SMTP id x19-20020aa78f13000000b0052dfe17ce11mr3870779pfr.26.1659495924333;
        Tue, 02 Aug 2022 20:05:24 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-59.three.co.id. [116.206.12.59])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709027e8600b0016bf2a4598asm442528pla.229.2022.08.02.20.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 20:05:23 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4AFCC103924; Wed,  3 Aug 2022 10:05:19 +0700 (WIB)
Date:   Wed, 3 Aug 2022 10:05:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: checkpatch: add some new checkpatch documentation
 messages
Message-ID: <Yunl74ozKOzV+n2A@debian.me>
References: <20220802055528.13726-1-utkarshverma294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802055528.13726-1-utkarshverma294@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Tue, Aug 02, 2022 at 11:25:28AM +0530, Utkarsh Verma wrote:
> Added and documented the following new message types:
> - JIFFIES_COMPARISON
> - LONG_UDELAY
> - MSLEEP
> - INDENTED_LABEL
> - IF_0
> - IF_1
> - MISORDERED_TYPE
> - UNNECESSARY_BREAK
> - UNNECESSARY_ELSE
> - UNNECESSARY_INT
> - UNSPECIFIED_INT
> 

Use imperative mood for patch description instead.

> +  **MISORDERED_TYPE**
> +    According to section “6.7.2 Type Specifiers” in C90 standard, “type
> +    specifiers may occur in any order.” This means that "signed long long
> +    int" is same as "long long int signed". But to avoid confusion and make
> +    the code easier to read, the declaration type should use the following
> +    format::
> +
> +      [[un]signed] [short|int|long|long long]
> +
> +    Below is the list of standard integer types. Each row lists all the
> +    different ways of specifying a particular type delimited by commas.
> +    Note: Also include all the permutations of a particular type
> +    on the left column delimited by comma. For example, the permutations
> +    for "signed long int" are "signed int long", "long signed int",
> +    "long int signed", "int signed long", and "int long signed".
> +
> +    +--------------------------------------------------+--------------------+
> +    |                       Types                      |   Recommended Way  |
> +    +=======================================================================+
> +    | char                                             | char               |
> +    +-----------------------------------------------------------------------+
> +    | signed char                                      | signed char        |
> +    +-----------------------------------------------------------------------+
> +    | unsigned char                                    | unsigned char      |
> +    +-----------------------------------------------------------------------+
> +    | signed, int, signed int                          | int                |
> +    +-----------------------------------------------------------------------+
> +    | unsigned, unsigned int                           | unsigned int       |
> +    +-----------------------------------------------------------------------+
> +    | short, signed short, short int, signed short int | short              |
> +    +-----------------------------------------------------------------------+
> +    | unsigned short, unsigned short int               | unsigned short     |
> +    +-----------------------------------------------------------------------+
> +    | long, signed long, long int, signed long int     | long               |
> +    +-----------------------------------------------------------------------+
> +    | unsigned long, unsigned long int                 | unsigned long      |
> +    +-----------------------------------------------------------------------|
> +    | long long, signed long long, long long int,      | long long          |
> +    | signed long long int                             |                    |
> +    +-----------------------------------------------------------------------+
> +    | unsigned long long, unsigned long long int       | unsigned long long |
> +    +-----------------------------------------------------------------------+
> +

The table above triggers htmldocs error, so I have to apply the fixup:

---- >8 ----

From 4fcc0df4ffcf1190330c12db5352cae03f8620fb Mon Sep 17 00:00:00 2001
From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Wed, 3 Aug 2022 09:48:43 +0700
Subject: [PATCH] Documentation: checkpatch: MISORDERED_TYPE table intersection
 fixup

Sphinx reported error and warnings pointed at MISORDERED_TYPE table:

Documentation/dev-tools/checkpatch.rst:1393: (SEVERE/4) Unexpected section title or transition.
Documentation/dev-tools/checkpatch.rst:1393: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/dev-tools/checkpatch.rst:1393: WARNING: Unexpected section title or transition.

Fix these above by marking cell intersections with plus (+) sign.

Link: https://lore.kernel.org/linux-doc/202208030829.xj2bvI7P-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 78abcadb522824..a9d27913e6c46f 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1371,30 +1371,30 @@ Others
 
     +--------------------------------------------------+--------------------+
     |                       Types                      |   Recommended Way  |
-    +=======================================================================+
+    +==================================================+====================+
     | char                                             | char               |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | signed char                                      | signed char        |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | unsigned char                                    | unsigned char      |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | signed, int, signed int                          | int                |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | unsigned, unsigned int                           | unsigned int       |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | short, signed short, short int, signed short int | short              |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | unsigned short, unsigned short int               | unsigned short     |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | long, signed long, long int, signed long int     | long               |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | unsigned long, unsigned long int                 | unsigned long      |
-    +-----------------------------------------------------------------------|
+    +--------------------------------------------------+--------------------+
     | long long, signed long long, long long int,      | long long          |
     | signed long long int                             |                    |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
     | unsigned long long, unsigned long long int       | unsigned long long |
-    +-----------------------------------------------------------------------+
+    +--------------------------------------------------+--------------------+
 
   **NOT_UNIFIED_DIFF**
     The patch file does not appear to be in unified-diff format.  Please
---- >8 ----

> +    Also, do not change the code if there is only a single return statement
> +    inside if-else block, like::
> +
> +      if (a > b)
> +              return a;
> +      else
> +              return b;
> +
> +    now if the else statement is removed::
> +
> +      if (a > b)
> +              return a;
> +      return b;
> +
> +    there is no considerable increase in the readability and one can argue
> +    that the first form is more readable because of the indentation. So
> +    do not remove the else statement in case of a single return statement
> +    inside the if-else block.
> +

So the first indentation above is more readable for it's clear that
b is returned if the condition is false (in this case, a < b), right?

> +    See: https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/
> +
> +  **UNNECESSARY_INT**
> +    On Sun, 2018-08-05 at 08:52 -0700, Linus Torvalds wrote:
> +    > "long unsigned int" isn't _technically_ wrong. But we normally
> +    > call that type "unsigned long".
> +

IMO, the mail quote above can be deleted.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
