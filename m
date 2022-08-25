Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67755A0C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbiHYJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiHYJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:15:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51064B0F0;
        Thu, 25 Aug 2022 02:15:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u14so23753941wrq.9;
        Thu, 25 Aug 2022 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=rE9qzKn8fr9Qet7CHqO5LOfoqE9kcAR4goeb/eXRqec=;
        b=kgrtHCCIH6IoVNUpb2iR0dq+7tJeY////+cIJWuR6ZKZUJAas5DDwRDhwMQ0WXLhiq
         QnCGv3r0PGJF8I53iHvS0qOMGJ9W8Ili6KKxnWGrrxvF2diz4HzX5qTVFl6r0Txg85+3
         4dR1iSd53t5KhbNKA8IlFQzos8HVEuLyrwCIjeZ8ui7o97ubT3pX57gfhuoerbfrMdE8
         jE/ZBDL1FYwKBNEDcGYJT17VaokCJBK0r+q4sF/L5KC2wxIcqZU1+qmwskwIgKDkUbMI
         KECsLE6XuQNQKwqsk7WELepfZDFz13Iptsy6K8NeqLMawMLnblj7wk5o3lFzkngYEwTf
         38tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rE9qzKn8fr9Qet7CHqO5LOfoqE9kcAR4goeb/eXRqec=;
        b=lS+l0HBaIeCZJ6+0djaC/c5bkgh/pjvIeNW5c+qzEgfAOiWyog8XbU6Y3Nb4j/izYP
         Q+wMZt9qQf22unnSyzADH7R78ccm9vvNPENS6/YseU7aoLN9GDPIIk3XbIq+8lifVoKn
         MB98oOrR9e9/G80c41gh8BzuV9iSjxeFhh3kMBSKTgFa8hMt29TWO4bqRHImru/5pSWs
         uPiyDJeI5wW695Ib5YWDgQh90j2261/DrejypFtuViBzrMKMlLWGy39VytgDdGupi/NE
         4GHbTkvc1mvIes3wfapl76a2Z7W1HvztKKLQ8ZTBYgyyBDXwSb71YF9Dg0yLKqs4Yyp4
         hx7w==
X-Gm-Message-State: ACgBeo0PuBynG0hkZaRjnPpDBZrlZTHaSM/LdbQeZCFDNZ2unGL05Zrk
        s1SZtCg2Gz4M9qYyOjWtlg8=
X-Google-Smtp-Source: AA6agR7Gp5lPd3O//yzoESmSgXksfcJB3i/H5xOQ7Fs2C5/jmHfwlY4qn8K+AjmSgpDKWg/l+0HaKA==
X-Received: by 2002:a5d:4a84:0:b0:225:20e3:3ba6 with SMTP id o4-20020a5d4a84000000b0022520e33ba6mr1676826wrq.306.1661418952858;
        Thu, 25 Aug 2022 02:15:52 -0700 (PDT)
Received: from felia.fritz.box (200116b8261c340005cd4c2b92078212.dip.versatel-1u1.de. [2001:16b8:261c:3400:5cd:4c2b:9207:8212])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a603fbad5bsm4950821wmq.45.2022.08.25.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 02:15:52 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andi Kleen <ak@linux.intel.com>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scripts: remove obsolete gcc-ld script
Date:   Thu, 25 Aug 2022 11:15:17 +0200
Message-Id: <20220825091517.30842-1-lukas.bulwahn@gmail.com>
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

Since commit 8564ed2b3888 ("Kbuild, lto: Add a gcc-ld script to let run gcc
as ld") in 2014, there was not specific work on this the gcc-ld script
other than treewide clean-ups.

There are no users within the kernel tree, and probably no out-of-tree
users either, and there is no dedicated maintainer in MAINTAINERS.

Delete this obsolete gcc-ld script.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
If there are no objections, I would like to get this patch included
through the kbuild tree.

Masahiro-san, please pick this patch.

 scripts/gcc-ld | 30 ------------------------------
 1 file changed, 30 deletions(-)
 delete mode 100755 scripts/gcc-ld

diff --git a/scripts/gcc-ld b/scripts/gcc-ld
deleted file mode 100755
index 997b818c3962..000000000000
--- a/scripts/gcc-ld
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# run gcc with ld options
-# used as a wrapper to execute link time optimizations
-# yes virginia, this is not pretty
-
-ARGS="-nostdlib"
-
-while [ "$1" != "" ] ; do
-	case "$1" in
-	-save-temps|-m32|-m64) N="$1" ;;
-	-r) N="$1" ;;
-	-[Wg]*) N="$1" ;;
-	-[olv]|-[Ofd]*|-nostdlib) N="$1" ;;
-	--end-group|--start-group)
-		 N="-Wl,$1" ;;
-	-[RTFGhIezcbyYu]*|\
---script|--defsym|-init|-Map|--oformat|-rpath|\
--rpath-link|--sort-section|--section-start|-Tbss|-Tdata|-Ttext|\
---version-script|--dynamic-list|--version-exports-symbol|--wrap|-m)
-		A="$1" ; shift ; N="-Wl,$A,$1" ;;
-	-[m]*) N="$1" ;;
-	-*) N="-Wl,$1" ;;
-	*)  N="$1" ;;
-	esac
-	ARGS="$ARGS $N"
-	shift
-done
-
-exec $CC $ARGS
-- 
2.17.1

