Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DE5876EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiHBF4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:56:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D117C1BEBE;
        Mon,  1 Aug 2022 22:56:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o3so12505072ple.5;
        Mon, 01 Aug 2022 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kORmtTvgKG66VW6uuUrG1tf2ELc8v1lDuMJWmVT1kk=;
        b=n/DAqDErekDYlPiDZHfZENWFr/WUWWLIGG8ftmZNDe5Y9e0el7qhRVzOUJIvAwJ22b
         mYGU8Q45czxFdMzJg6fw4dmpynykfZ09oidR6XkbUCeGyEGlBwnkBactNN1LWVkKahvB
         3rzilYtm4fkfpC+T8jkytiydwMWH0U0Z1b2tSbXdsPCyPIylmdDKYGPwCTqYVK+wj6Js
         XNaiO3+5HB1PhloWGwUq4S8nMpT8hezwWxFEGNGtGNe6Zyb5UDpDz4QU6Vuo0XC3eyyE
         HW2sQNKUcqCK13QiW5fbO1Xfprx+x3qCudFGV8746YF4KBhkjaltgqexEjPOCGYzcy3q
         pUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kORmtTvgKG66VW6uuUrG1tf2ELc8v1lDuMJWmVT1kk=;
        b=DGq2am+do006iUfj8nf5zVrALEgZ/aPK89irOJjb4wz5V9HwjMZnXrjuAU7ML1uqqd
         1GlpGaHAOq4r++sja/TdmP3B7iVxgKu/zHAWQi+TO4bp+a3JuK55DCsLcRVZ9L04SwZj
         b/93jKKF47hxC2K/mG9wj9ewlp97eDloHiXhanCl06nLFBB4Wc/qLEQgs44D6vpCV4XI
         dR6bJI7/ShTU0/o/XCrNBD9lhGj9T6/9cQAqlGU+E+zpiXM8IYzlL/tEckQ+7GPBtxJU
         iOMmXRX3TYZ4L3kdxB9Njh6cmQvRIObcuQfxcfrwBeutIjnxRkli0zrc4kvl+ymNVwpu
         Owzw==
X-Gm-Message-State: ACgBeo11HlqNWzwCAj32y47agX16ctBsX010BZvg6lz0sDe7zYAdm65t
        J1zOEvmi+YCJK+GBDO242UDvjzwTscnblYs5
X-Google-Smtp-Source: AA6agR4Uq6pRu/GVLj3u7uiBDVmb/uZbKbmA4WgIVb6BTfhkvsPmsA6NZlkUIlavy6CU/9BP6tBUFw==
X-Received: by 2002:a17:902:8f92:b0:16c:e485:7cd2 with SMTP id z18-20020a1709028f9200b0016ce4857cd2mr20365261plo.50.1659419794042;
        Mon, 01 Aug 2022 22:56:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:4050:e96:467e:d56f:ae53:bbb0:f63a])
        by smtp.googlemail.com with ESMTPSA id q30-20020a631f5e000000b0041c6541383dsm571068pgm.60.2022.08.01.22.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 22:56:33 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] docs: checkpatch: add some new checkpatch documentation messages
Date:   Tue,  2 Aug 2022 11:25:28 +0530
Message-Id: <20220802055528.13726-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added and documented the following new message types:
- JIFFIES_COMPARISON
- LONG_UDELAY
- MSLEEP
- INDENTED_LABEL
- IF_0
- IF_1
- MISORDERED_TYPE
- UNNECESSARY_BREAK
- UNNECESSARY_ELSE
- UNNECESSARY_INT
- UNSPECIFIED_INT

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 300 +++++++++++++++++++++++++
 1 file changed, 300 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index b52452bc2963..78abcadb5228 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -445,6 +445,34 @@ API usage
 
     See: https://lore.kernel.org/lkml/20080320201723.b87b3732.akpm@linux-foundation.org/
 
+  **JIFFIES_COMPARISON**
+    Doing time comparison by directly using relational operators with jiffies
+    or get_jiffies_64() is wrong. Example::
+
+      if (jiffies > timeout)
+              do_something;
+
+    The above code is wrong because when the jiffies value reaches its maximum
+    limit, then it overflows and wraps around zero, so the above code will
+    not work as intended. To correctly handle this jiffies overflow condition,
+    the kernel provides some helper macros defined in <linux/jiffies.h>.
+    Some of the important macros are::
+
+      int time_after(unsigned long a, unsigned long b);
+      int time_before(unsigned long a, unsigned long b);
+      int time_after_eq(unsigned long a, unsigned long b);
+      int time_before_eq(unsigned long a, unsigned long b);
+
+    So the above code can be corrected by::
+
+      if (time_after(jiffies, timeout))
+              do_something;
+
+    Also, by using these macros, the code is easier to maintain and
+    future-proof because if the timer wrap changes in the future, then there
+    will be no need to alter the driver code. So it is strongly recommended
+    to always use these macros instead of direct comparison with jiffies.
+
   **LOCKDEP**
     The lockdep_no_validate class was added as a temporary measure to
     prevent warnings on conversion of device->sem to device->mutex.
@@ -452,11 +480,68 @@ API usage
 
     See: https://lore.kernel.org/lkml/1268959062.9440.467.camel@laptop/
 
+  **LONG_UDELAY**
+    Passing large arguments to udelay() results in integer overflow in the
+    internal loop calculation of udelay() and the driver code will display
+    an error of unresolved symbol, __bad_udelay.
+
+    Different CPU architectures have different threshold values for udelay()
+    after which they call __bad_udelay(). For ARM architecture, the threshold
+    value is 2000us. For the exact maths behind this limit see
+    arch/arm/include/asm/delay.h
+
+    This checkpatch warning is triggered when the argument passed to udelay()
+    is greater than 2000us. Though for some architectures this threshold
+    value is more than 2000us, but as a general rule if the wanted delay is
+    in thousand of micro seconds, then use mdelay().
+
+    mdelay() is a wrapper around udelay() that accounts for the overflow
+    condition when passing large arguments to udelay(). Also, note that the
+    udelay() and mdelay() are busy-waiting, other tasks cannot run during
+    that time. So if the hardware supports hrtimers, then a better approach
+    would be to use usleep_range() function. For delaying 10us - 20ms,
+    usleep_range() is the recommended API. But make a change to usleep_range()
+    only if the hardware supports hrtimers, along with proper testing on a
+    real hardware.
+
+    If the delay is more than 20ms then use msleep(). msleep() is the
+    recommended API for delaying more than 20ms because it is implemented
+    using the jiffies timer and does not involve busy-waiting.
+
+    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html
+
   **MALFORMED_INCLUDE**
     The #include statement has a malformed path.  This has happened
     because the author has included a double slash "//" in the pathname
     accidentally.
 
+  **MSLEEP**
+    msleep() is implemented using the jiffies counter. When msleep() is
+    called it stops for a minimum of 2 jiffies. So, depending on the value
+    of HZ the mleep will atleast stop for 1-20ms. In worst case, if HZ=100
+    then msleep() will delay for a minimum of 20ms
+    (https://lore.kernel.org/all/15327.1186166232@lwn.net/). So for
+    sleeping for 10us-20ms it is recommended to use usleep_range() and not
+    msleep().
+
+    But ignore this warning, if the change to usleep_range() cannot be tested
+    on a real hardware.
+
+    usleep_range() is implemented using the hrtimer. Some hardware doesn't
+    support hrtimer, so no sense in making the change to usleep_range().
+
+    Also, the min and max value in usleep_range(unsigned long min, unsigned
+    long max) must be selected by understanding the driver code, and the
+    hardware with lots of testing and verification. One can see these timing
+    changes that others have made to get some approximate min and max values,
+    and then test to get the best possible values.
+
+    See:
+
+      1. https://lore.kernel.org/all/alpine.DEB.2.22.394.2110171140040.3026@hadrien/
+      2. https://lore.kernel.org/linux-staging/260b38b8-6f3f-f6cc-0388-09a269ead507@i2se.com/
+      3. https://lore.kernel.org/all/1357253791.2685.48.camel@bwh-desktop.uk.solarflarecom.com/
+
   **USE_LOCKDEP**
     lockdep_assert_held() annotations should be preferred over
     assertions based on spin_is_locked()
@@ -661,6 +746,30 @@ Indentation and Line Breaks
 
     See: https://lore.kernel.org/lkml/1328311239.21255.24.camel@joe2Laptop/
 
+  **INDENTED_LABEL**
+    goto labels either should not have any indentation or only a single
+    space indentation (https://lore.kernel.org/all/20070527171817.4ce9d40d.akpm@linux-foundation.org/).
+    The Linux Kernel Coding Style does not indent the goto labels. Since
+    the program control can directly jump from one part of the program to a
+    pre-defined goto label, so making these labels easy to spot is important.
+    By flushing the goto labels to the left, these labels are more visible
+    and easier to identify.
+
+    Since the checkpatch only uses the regular expressions for finding the
+    possible coding style violation in a patch, and does not track the logic
+    or flow of the program, so there can be some false positives. Though for
+    this rule it is rare, still do not blindly follow the checkpatch advice.
+
+    Suppose if there is a conditional (ternary) operator across multiple
+    lines and there is no space around the “:” then this warning can be
+    triggered. Example::
+
+      return_value = (function1(value1) && function2(value2)) ?
+              NULL: some_other_value;
+
+    Here the checkpatch will give this label warning along with the spacing
+    warning.
+
   **SWITCH_CASE_INDENT_LEVEL**
     switch should be at the same indent as case.
     Example::
@@ -823,6 +932,19 @@ Macros, Attributes and Symbols
   **DO_WHILE_MACRO_WITH_TRAILING_SEMICOLON**
     do {} while(0) macros should not have a trailing semicolon.
 
+  **IF_0**
+    The code enclosed within #if 0 and #endif is not executed and is used
+    for temporarily removing the segments of code with the intention of
+    using it in the future, much like comments. But comments cannot be
+    nested, so #if 0 is preferred. But if the code inside #if 0 and #endif
+    doesn't seem to be anymore required then remove it.
+
+  **IF_1**
+    The code enclosed within #if 1 and #endif is always executed, so the
+    #if 1 and #endif statements are redundant, thus remove it.
+    It is only useful for debugging purposes, it can quickly disable the
+    code enclosed within itself by changing #if 1 to #if 0
+
   **INIT_ATTRIBUTE**
     Const init definitions should use __initconst instead of
     __initdata.
@@ -1231,6 +1353,49 @@ Others
     The memset use appears to be incorrect.  This may be caused due to
     badly ordered parameters.  Please recheck the usage.
 
+  **MISORDERED_TYPE**
+    According to section “6.7.2 Type Specifiers” in C90 standard, “type
+    specifiers may occur in any order.” This means that "signed long long
+    int" is same as "long long int signed". But to avoid confusion and make
+    the code easier to read, the declaration type should use the following
+    format::
+
+      [[un]signed] [short|int|long|long long]
+
+    Below is the list of standard integer types. Each row lists all the
+    different ways of specifying a particular type delimited by commas.
+    Note: Also include all the permutations of a particular type
+    on the left column delimited by comma. For example, the permutations
+    for "signed long int" are "signed int long", "long signed int",
+    "long int signed", "int signed long", and "int long signed".
+
+    +--------------------------------------------------+--------------------+
+    |                       Types                      |   Recommended Way  |
+    +=======================================================================+
+    | char                                             | char               |
+    +-----------------------------------------------------------------------+
+    | signed char                                      | signed char        |
+    +-----------------------------------------------------------------------+
+    | unsigned char                                    | unsigned char      |
+    +-----------------------------------------------------------------------+
+    | signed, int, signed int                          | int                |
+    +-----------------------------------------------------------------------+
+    | unsigned, unsigned int                           | unsigned int       |
+    +-----------------------------------------------------------------------+
+    | short, signed short, short int, signed short int | short              |
+    +-----------------------------------------------------------------------+
+    | unsigned short, unsigned short int               | unsigned short     |
+    +-----------------------------------------------------------------------+
+    | long, signed long, long int, signed long int     | long               |
+    +-----------------------------------------------------------------------+
+    | unsigned long, unsigned long int                 | unsigned long      |
+    +-----------------------------------------------------------------------|
+    | long long, signed long long, long long int,      | long long          |
+    | signed long long int                             |                    |
+    +-----------------------------------------------------------------------+
+    | unsigned long long, unsigned long long int       | unsigned long long |
+    +-----------------------------------------------------------------------+
+
   **NOT_UNIFIED_DIFF**
     The patch file does not appear to be in unified-diff format.  Please
     regenerate the patch file before sending it to the maintainer.
@@ -1247,3 +1412,138 @@ Others
 
   **TYPO_SPELLING**
     Some words may have been misspelled.  Consider reviewing them.
+
+  **UNNECESSARY_BREAK**
+    Using break statement just after a goto, return or break is unnecessary.
+    For example::
+
+      switch (foo) {
+      case 1:
+              goto err;
+              break;
+      }
+
+    Here, the break statement is completely unnecessary, because it will
+    never be executed. So it is better to remove it.
+
+    It is not a bug or syntactically incorrect, but it should be removed
+    because it is an unreachable statement that will never be executed
+    (https://lore.kernel.org/lkml/18981cad4ac27b4a22b2e38d40bd112432d4a4e7.camel@perches.com/).
+
+    Note there can be some false positives, which happen because of the way
+    this rule is implemented in the checkpatch script. The checkpatch script
+    throws this warning message if it finds a break statement and the line
+    above it is a goto/return/break statement with the same indentation
+    (same number of tabs). It only relies on the same indentation and does
+    not care about the logic of the code. For example::
+
+      if (foo)
+              break;
+              break;
+
+    Here the checkpatch will throw this warning message, because both the
+    break statements are at the same indentation. The second break statement
+    is unnecessarily indented, which causes this false positive. So do not
+    blindly follow the checkpatch advice here, instead consider the logic of
+    the code before making the changes. In the above example, correct the
+    indentation of the second break statement instead of following the
+    checkpatch advice.
+
+  **UNNECESSARY_ELSE**
+    Using an else statement just after a return/break/continue statement is
+    unnecessary. For example::
+
+      if (foo)
+              break;
+      else
+              usleep(1);
+
+    is generally better written as::
+
+      if (foo)
+              break;
+      usleep(1);
+
+    It helps to reduce the indentation and removes the unnecessary else
+    statement. But do not blindly follow checkpatch's advice here, as blind
+    changes due to this rule have already caused some disturbance, see commit
+    98fe05e21a6e ("staging: rtl8712: Remove unnecesary else after return
+    statement."). That commit made it to the mainline which had to be
+    reverted and fixed.
+
+    These false positives happen because of the way this rule is implemented
+    in the checkpatch script. The checkpatch script throws this warning
+    message if it finds an else statement and the line above it is a
+    break/continue/return statement indented at one tab more than the else
+    statement. So there can be some false positives like::
+
+      int n = 15;
+      if (n > 10)
+              n--;
+      else if (n == 10)
+              return 0;
+      else
+              n++;
+
+    Now the checkpatch will give a warning for the use of else after return
+    statement. If the else statement is removed then::
+
+      int n = 15;
+      if (n > 10)
+              n--;
+      else if (n == 10)
+              return 0;
+      n++;
+
+    Now both the n-- and n++ statements will be executed which is different
+    from the logic in the first case. As the if block doesn't have a return
+    statement, so removing the else statement is wrong. So always check the
+    previous if/else if blocks, for break/continue/return statements, before
+    following this rule.
+
+    Also, do not change the code if there is only a single return statement
+    inside if-else block, like::
+
+      if (a > b)
+              return a;
+      else
+              return b;
+
+    now if the else statement is removed::
+
+      if (a > b)
+              return a;
+      return b;
+
+    there is no considerable increase in the readability and one can argue
+    that the first form is more readable because of the indentation. So
+    do not remove the else statement in case of a single return statement
+    inside the if-else block.
+
+    See: https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/
+
+  **UNNECESSARY_INT**
+    On Sun, 2018-08-05 at 08:52 -0700, Linus Torvalds wrote:
+    > "long unsigned int" isn't _technically_ wrong. But we normally
+    > call that type "unsigned long".
+
+    Using "int" type-specifier with "short", "long", and "long long" is
+    optional. So "short int" is same as "short", "long int" is same as
+    "long", and "long long int" is same as "long long". Similary for
+    their unsigned counterparts also.
+
+    To avoid confusion so that people do not interpret these synonymous
+    types as different types, and also to make the code uniform, clean and
+    more readable usage of "int" should be avoided with "short", "long",
+    and "long long".
+
+    See: https://lore.kernel.org/all/7bbd97dc0a1e5896a0251fada7bb68bb33643f77.camel@perches.com/T/#m1fa34198ce2bd088b3520b74326468a2ab314ce7
+
+  **UNSPECIFIED_INT**
+    "signed", "signed int", and "int" are all the same types. Similarly,
+    "unsigned" and "unsigned int" are also the same.
+    So using type-specifier "signed" and "unsigned" with or without "int"
+    is the same type only. But to avoid confusion so that people do not
+    interpret these synonymous types as different types, and also to make
+    the code uniform, clean, and more readable prefer using the "signed int"
+    or "int" in place of "signed" and "unsigned int" in place of "unsigned".
-- 
2.25.1

