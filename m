Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF13259F4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiHXIJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiHXIJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:09:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E483BD2;
        Wed, 24 Aug 2022 01:09:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h22so21729576ejk.4;
        Wed, 24 Aug 2022 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=HBCsLrC+BZ57dXA8p6JgMF0Isv3MyvvLN8lewLj3GQI=;
        b=asEj1SbHqJwc2sRjdvudUmZk3hffx1BUlTwt05WxXJUw9eneEoO5Y6RIivyXDlbIyk
         67/bbf0ogqhhdnvEz2Cwph4cq4wzc+N/5S5Ci0KLfHxFETDNUccuktrEsw5eN68nhoXm
         srMxk204nWWr4k5UJgbNNVvJH3yOsIApOebiMaDIQadoHYYpLdVvpktxGiSAI+q64faA
         P109tL6WCnbKRUKYOL/tSdM3Whm3X1Ot/4P2P3oTHJeLelB16MvwkTdtfFVwkBexuBxN
         Ga5Ou124oJPExczaAOZBjjxgGMtqiPwO4RqtIr/R3TmSZpZn/rEobE1XpD17ghPyXHL/
         esPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HBCsLrC+BZ57dXA8p6JgMF0Isv3MyvvLN8lewLj3GQI=;
        b=I9j3Q93aXnteHyx7yp1XYY3znWq9Y9BMMHe3uKq1z7FOYv8RcY+uusPzMC648d/b4I
         ZYIiLiDKHfmWOm4ZRZWBRoJaxgFNKUXHg9bp81yiUymDa0EvaivtyorHgsVqMuZYMlZ1
         PhGjIRNatlszIHH6eiS87mHqzPQ9HeQvGXQWuSbptjmgSJW9UMuWWntRB3JryAwUjWYb
         y84xQiPP5qPDmz3DIHpAEgL5ApUyPw2vlE+JInRfmXjHo/IKgctm9o5VWlrEfn2IDJSh
         RxDAPOAOim6lx0QhNZh3f9mkImpqAwMVNtaNFqQbnsn3gIreJ8qoWcEdacUcMDYyfq69
         jDtA==
X-Gm-Message-State: ACgBeo3cJTpSIw/qOrkkBzSY+khg3AasfK5RkfSa5JFoeuj+beRhvqIU
        B59Dt1xofgdpZ5qg12iI67Q=
X-Google-Smtp-Source: AA6agR7nFEPUMYXzTXuq9byRWDY/PHXv4rvG+IqBfsUw0kWABOiUIHQGuB4b5OUKJUfGV/4NXktuCA==
X-Received: by 2002:a17:907:a073:b0:73d:8503:a55e with SMTP id ia19-20020a170907a07300b0073d8503a55emr2088246ejc.315.1661328544228;
        Wed, 24 Aug 2022 01:09:04 -0700 (PDT)
Received: from felia.fritz.box (200116b82606de00690367f10e5093c9.dip.versatel-1u1.de. [2001:16b8:2606:de00:6903:67f1:e50:93c9])
        by smtp.gmail.com with ESMTPSA id d6-20020a50fb06000000b0043a5bcf80a2sm2610603edq.60.2022.08.24.01.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:09:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
Date:   Wed, 24 Aug 2022 10:08:36 +0200
Message-Id: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A quick 'grep "5\.x" . -R' on Documentation shows that README.rst,
2.Process.rst and applying-patches.rst all mention the version number "5.x"
for kernel releases.

As the next release will be version 6.0, updating the version number to 6.x
in README.rst seems reasonable.

The description in 2.Process.rst is just a description of recent kernel
releases, it was last updated in the beginning of 2020, and can be
revisited at any time on a regular basis, independent of changing the
version number from 5 to 6. So, there is no need to update this document
now when transitioning from 5.x to 6.x numbering.

The document applying-patches.rst is probably obsolete for most users
anyway, a reader will sufficiently well understand the steps, even it
mentions version 5 rather than version 6. So, do not update that to a
version 6.x numbering scheme.

Update version number from 5.x to 6.x in README.rst only.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/admin-guide/README.rst | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index caa3c09a5c3f..9eb6b9042f75 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -1,9 +1,9 @@
 .. _readme:
 
-Linux kernel release 5.x <http://kernel.org/>
+Linux kernel release 6.x <http://kernel.org/>
 =============================================
 
-These are the release notes for Linux version 5.  Read them carefully,
+These are the release notes for Linux version 6.  Read them carefully,
 as they tell you what this is all about, explain how to install the
 kernel, and what to do if something goes wrong.
 
@@ -63,7 +63,7 @@ Installing the kernel source
    directory where you have permissions (e.g. your home directory) and
    unpack it::
 
-     xz -cd linux-5.x.tar.xz | tar xvf -
+     xz -cd linux-6.x.tar.xz | tar xvf -
 
    Replace "X" with the version number of the latest kernel.
 
@@ -72,12 +72,12 @@ Installing the kernel source
    files.  They should match the library, and not get messed up by
    whatever the kernel-du-jour happens to be.
 
- - You can also upgrade between 5.x releases by patching.  Patches are
+ - You can also upgrade between 6.x releases by patching.  Patches are
    distributed in the xz format.  To install by patching, get all the
    newer patch files, enter the top level directory of the kernel source
-   (linux-5.x) and execute::
+   (linux-6.x) and execute::
 
-     xz -cd ../patch-5.x.xz | patch -p1
+     xz -cd ../patch-6.x.xz | patch -p1
 
    Replace "x" for all versions bigger than the version "x" of your current
    source tree, **in_order**, and you should be ok.  You may want to remove
@@ -85,13 +85,13 @@ Installing the kernel source
    that there are no failed patches (some-file-name# or some-file-name.rej).
    If there are, either you or I have made a mistake.
 
-   Unlike patches for the 5.x kernels, patches for the 5.x.y kernels
+   Unlike patches for the 6.x kernels, patches for the 6.x.y kernels
    (also known as the -stable kernels) are not incremental but instead apply
-   directly to the base 5.x kernel.  For example, if your base kernel is 5.0
-   and you want to apply the 5.0.3 patch, you must not first apply the 5.0.1
-   and 5.0.2 patches. Similarly, if you are running kernel version 5.0.2 and
-   want to jump to 5.0.3, you must first reverse the 5.0.2 patch (that is,
-   patch -R) **before** applying the 5.0.3 patch. You can read more on this in
+   directly to the base 6.x kernel.  For example, if your base kernel is 6.0
+   and you want to apply the 6.0.3 patch, you must not first apply the 6.0.1
+   and 6.0.2 patches. Similarly, if you are running kernel version 6.0.2 and
+   want to jump to 6.0.3, you must first reverse the 6.0.2 patch (that is,
+   patch -R) **before** applying the 6.0.3 patch. You can read more on this in
    :ref:`Documentation/process/applying-patches.rst <applying_patches>`.
 
    Alternatively, the script patch-kernel can be used to automate this
@@ -114,7 +114,7 @@ Installing the kernel source
 Software requirements
 ---------------------
 
-   Compiling and running the 5.x kernels requires up-to-date
+   Compiling and running the 6.x kernels requires up-to-date
    versions of various software packages.  Consult
    :ref:`Documentation/process/changes.rst <changes>` for the minimum version numbers
    required and how to get updates for these packages.  Beware that using
@@ -132,12 +132,12 @@ Build directory for the kernel
    place for the output files (including .config).
    Example::
 
-     kernel source code: /usr/src/linux-5.x
+     kernel source code: /usr/src/linux-6.x
      build directory:    /home/name/build/kernel
 
    To configure and build the kernel, use::
 
-     cd /usr/src/linux-5.x
+     cd /usr/src/linux-6.x
      make O=/home/name/build/kernel menuconfig
      make O=/home/name/build/kernel
      sudo make O=/home/name/build/kernel modules_install install
-- 
2.17.1

