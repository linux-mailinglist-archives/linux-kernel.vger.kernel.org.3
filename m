Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B8592C29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbiHOJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiHOJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:19:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE922509;
        Mon, 15 Aug 2022 02:19:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 13B02203A1;
        Mon, 15 Aug 2022 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660555181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=byKdBkOnKfm6xsv9HwlPy69qW+GlO+5qPV3VOpbs2VQ=;
        b=2qeZ/Y8/zNtKp27jzySFLrrSLQMeqBQU7VcKXub/oHUAmRwd0Xm3iErK2gwzvclGvQb7j0
        rwsXH5tiPhkJHLoiFeucY4ICOc3oCp8O58OyY7ytHHIzgiALmWJp72L0ss6L2jAmZOvfcS
        loolqbyBo+pPsSZs+vF8bamSSAAXHr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660555181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=byKdBkOnKfm6xsv9HwlPy69qW+GlO+5qPV3VOpbs2VQ=;
        b=A5z92i2c6IZb38CR8RIR7ZdIQx7x+eqEJYIhGyFJuHcKprGXvTC1i8HIRpzvCduq8mWTbD
        0iBO6opzudAnmkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E723A13A93;
        Mon, 15 Aug 2022 09:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B2EdN6wP+mKyVQAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 15 Aug 2022 09:19:40 +0000
Message-ID: <49253b17-738d-795e-f539-55857fdaee64@suse.cz>
Date:   Mon, 15 Aug 2022 11:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] docs/arm64: elf_hwcaps: Unify HWCAP lists as description
 lists
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     broonie@kernel.org, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extends what was changed in 94bdaa7d9a9d778d893c670d494c06d8e007c1cd.

Add a series of blank lines to this document to get consistend rendering as
an RST description list.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 Documentation/arm64/elf_hwcaps.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 52b75a25c205..311021f2e560 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -242,44 +242,34 @@ HWCAP2_MTE3
     by Documentation/arm64/memory-tagging-extension.rst.
 
 HWCAP2_SME
-
     Functionality implied by ID_AA64PFR1_EL1.SME == 0b0001, as described
     by Documentation/arm64/sme.rst.
 
 HWCAP2_SME_I16I64
-
     Functionality implied by ID_AA64SMFR0_EL1.I16I64 == 0b1111.
 
 HWCAP2_SME_F64F64
-
     Functionality implied by ID_AA64SMFR0_EL1.F64F64 == 0b1.
 
 HWCAP2_SME_I8I32
-
     Functionality implied by ID_AA64SMFR0_EL1.I8I32 == 0b1111.
 
 HWCAP2_SME_F16F32
-
     Functionality implied by ID_AA64SMFR0_EL1.F16F32 == 0b1.
 
 HWCAP2_SME_B16F32
-
     Functionality implied by ID_AA64SMFR0_EL1.B16F32 == 0b1.
 
 HWCAP2_SME_F32F32
-
     Functionality implied by ID_AA64SMFR0_EL1.F32F32 == 0b1.
 
 HWCAP2_SME_FA64
-
     Functionality implied by ID_AA64SMFR0_EL1.FA64 == 0b1.
 
 HWCAP2_WFXT
-
     Functionality implied by ID_AA64ISAR2_EL1.WFXT == 0b0010.
 
 HWCAP2_EBF16
-
     Functionality implied by ID_AA64ISAR1_EL1.BF16 == 0b0010.
 
 4. Unused AT_HWCAP bits
-- 
2.37.1

