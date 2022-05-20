Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6360052EDB4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350059AbiETOBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiETOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:01:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF433EA4;
        Fri, 20 May 2022 07:01:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E04B21C11;
        Fri, 20 May 2022 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653055294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ifkBDPmstF/lxN/46BBzeV0w6iyELzk8Cp7r/DoBMk=;
        b=ff6uaV5nbJXi5BDCVjly6dPlTd1fGKv+bhX0dZMjXppP/a4WhLHsJ6W2RXxNdlU1POVOCi
        hNhJpqlYeLA86gx15m8+MJVG0bBpZ9lchs7KMyFXJkyM7eesCxZ1aC97HAy32leyhxTwuu
        6ROY3xQ6Vy5kmDW1CP8IsYX7wWmXOJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653055294;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ifkBDPmstF/lxN/46BBzeV0w6iyELzk8Cp7r/DoBMk=;
        b=2AKVElWEM6IV++eMGKjmx53sInFEebgFzT04J6E7IPUeOKRlMwYs9JA0vN512o+8fkUOCY
        9IiKqzGetf0RWsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 261A013A5F;
        Fri, 20 May 2022 14:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KGVtCD6fh2IzcwAAMHmgww
        (envelope-from <mliska@suse.cz>); Fri, 20 May 2022 14:01:34 +0000
Message-ID: <e3921517-f903-3ad5-afa4-d7959051e5dd@suse.cz>
Date:   Fri, 20 May 2022 16:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] arm64: Unify vertical spacing in HWCAPS
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, bagasdotme@gmail.com
References: <4752814a-091c-9dd5-762c-6fd1a476c4bb@gmail.com>
Content-Language: en-US
In-Reply-To: <4752814a-091c-9dd5-762c-6fd1a476c4bb@gmail.com>
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

Promote headings by removing intermediate blank lines.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 Documentation/arm64/elf_hwcaps.rst | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index a8f30963e550..1e79044f51a2 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -171,96 +171,73 @@ HWCAP_PACG
     Documentation/arm64/pointer-authentication.rst.
 
 HWCAP2_DCPODP
-
     Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
 
 HWCAP2_SVE2
-
     Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.
 
 HWCAP2_SVEAES
-
     Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.
 
 HWCAP2_SVEPMULL
-
     Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0010.
 
 HWCAP2_SVEBITPERM
-
     Functionality implied by ID_AA64ZFR0_EL1.BitPerm == 0b0001.
 
 HWCAP2_SVESHA3
-
     Functionality implied by ID_AA64ZFR0_EL1.SHA3 == 0b0001.
 
 HWCAP2_SVESM4
-
     Functionality implied by ID_AA64ZFR0_EL1.SM4 == 0b0001.
 
 HWCAP2_FLAGM2
-
     Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0010.
 
 HWCAP2_FRINT
-
     Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
 
 HWCAP2_SVEI8MM
-
     Functionality implied by ID_AA64ZFR0_EL1.I8MM == 0b0001.
 
 HWCAP2_SVEF32MM
-
     Functionality implied by ID_AA64ZFR0_EL1.F32MM == 0b0001.
 
 HWCAP2_SVEF64MM
-
     Functionality implied by ID_AA64ZFR0_EL1.F64MM == 0b0001.
 
 HWCAP2_SVEBF16
-
     Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.
 
 HWCAP2_I8MM
-
     Functionality implied by ID_AA64ISAR1_EL1.I8MM == 0b0001.
 
 HWCAP2_BF16
-
     Functionality implied by ID_AA64ISAR1_EL1.BF16 == 0b0001.
 
 HWCAP2_DGH
-
     Functionality implied by ID_AA64ISAR1_EL1.DGH == 0b0001.
 
 HWCAP2_RNG
-
     Functionality implied by ID_AA64ISAR0_EL1.RNDR == 0b0001.
 
 HWCAP2_BTI
-
     Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
 
 HWCAP2_MTE
-
     Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
     by Documentation/arm64/memory-tagging-extension.rst.
 
 HWCAP2_ECV
-
     Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.
 
 HWCAP2_AFP
-
     Functionality implied by ID_AA64MFR1_EL1.AFP == 0b0001.
 
 HWCAP2_RPRES
-
     Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.
 
 HWCAP2_MTE3
-
     Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0011, as described
     by Documentation/arm64/memory-tagging-extension.rst.
 
-- 
2.36.1

