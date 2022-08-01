Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED315866C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiHAJQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiHAJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:16:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3221928B;
        Mon,  1 Aug 2022 02:16:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so11167782wrd.5;
        Mon, 01 Aug 2022 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=Tja2EFPyR9iUy4sMrbNy5to4k8GjJT+Iqt2a+ErBpQA=;
        b=RNjdWdTQnqA+kebxOhQ5HcdRkjHgz+MNIIvVy8F8eoO5eqhXky9IrC+7nP1kJuHcs6
         1YweMHre0ez39ofM4CRIH/R5EyND3ZEecr0sWh/3zleGtFaAG0/srG8zjcI+q4paSIbS
         OzrP6/x8OXFcxy69dDiMoEa5vHPZDmDAJkZMepyhdZFNM0Ab6kQoxIcbZx+MpcVRNIwm
         OwISfMLblyJbhC36kOWBsGkFhrcVyT04xUEMfZLgtZDici/hL6qMhV+kPAJfT8Vd2c9+
         sSFwxXhsmRFm7AEDFDheSHEBEYtiAl90IQlMpxiN3jldTY2PNO4HwkPEVUCuQTOWEVQr
         B2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=Tja2EFPyR9iUy4sMrbNy5to4k8GjJT+Iqt2a+ErBpQA=;
        b=fVyYYGEedq9BrJOIjxMdfU08FJaiA/qP5jgYY34h1ipih+BW/h4Qx1sGJ0QZ5DQT/p
         6h3l4v9G3kK1Xfo1qlTniVhOfzH9H1PnO2GajtyBitLlUZ9FkkQ3VNHxERlR715Nsnw3
         gGJSrm6rXmODip0DLnQwDMr4tIqZmoMczugmM1rXOsXxLHcb/0DMUEwhhM2p+kyD8P1T
         v55wwiVdR4YWbbS2yXrawcEquML7Nm9uHrXpMpAFKn1/q9tx11emNy99NcFexXhBeMka
         e8pocBk29ipxaVKTnkmNY5kKb70p3Xkq7kdhKGV7IiVNvKKpymr5qLu1vdharBhqIT27
         T59g==
X-Gm-Message-State: ACgBeo393Y68/cBrxkr6P7vuWweWfSJN7IAo7NKmy/VvDybgjFxWocRI
        i6ICEYm8GklUxHE6T4KY4ew=
X-Google-Smtp-Source: AA6agR5jObBw61r1YAVTh8d/hD+OVUCxxp2UOweoA/p2sxcm1ChkdM6elCJIxvT5KlVuLtdb6qB5LA==
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id v18-20020a5d6b12000000b0021f1568c7e1mr8145250wrw.532.1659345366272;
        Mon, 01 Aug 2022 02:16:06 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a326ba4e99sm14500266wmb.34.2022.08.01.02.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 02:16:05 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [RESEND PATCH] Documentation: ABI: Mention retbleed vulnerability info file for sysfs
Date:   Mon,  1 Aug 2022 11:15:30 +0200
Message-Id: <20220801091529.325327-1-carnil@debian.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reporting for the AMD retbleed vulnerability was added in
6b80b59b3555 ("x86/bugs: Report AMD retbleed vulnerability") the new
sysfs file was not mentioned so far in the ABI documentation for
sysfs-devices-system-cpu.

Fixes: 6b80b59b3555 ("x86/bugs: Report AMD retbleed vulnerability")
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index bcc974d276dc..3cda940108f6 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -527,6 +527,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
 		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/retbleed
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
-- 
2.36.1

