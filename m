Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA42530FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiEWMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiEWMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:18:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4599219005;
        Mon, 23 May 2022 05:18:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01C8D1F8BE;
        Mon, 23 May 2022 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653308287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0qnrRinaC3F4JUVaGGq2M9nBMqIOMymX1KLqQ5hWL4=;
        b=xLv7ViaCFvoX6Zk6EFp59EDHmQurp9hgKcRToy8fIVK920P7wxXZ8qu7PYL6fRnJ8dXU0K
        +3sJu6bKb56SIiJLyjC6BIj/DJ1v8KutNS7sWS9rU18j0a6FUtqJnk7cPpbExXKLpceveU
        f3R+vp8UnQmB/oOl3t7ajiQ7mZpzlWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653308287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0qnrRinaC3F4JUVaGGq2M9nBMqIOMymX1KLqQ5hWL4=;
        b=7pz37GRwpYXcWrfrugejAbXMulvvJxbFKRWkjGTSE1VfQTYUoPgAPxSns1dcNNbotSJPGP
        RVQ1oms0Iw1remDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5F7013AA5;
        Mon, 23 May 2022 12:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fAz5Kn57i2LiNgAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 23 May 2022 12:18:06 +0000
Message-ID: <d0e576ab-6121-b7d7-da5b-7750f05ca7f4@suse.cz>
Date:   Mon, 23 May 2022 14:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH v3] docs/arm64: elf_hwcaps: Unify HWCAP lists as description
 lists
To:     akiyks@gmail.com
Cc:     bagasdotme@gmail.com, catalin.marinas@arm.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mliska@suse.cz, will@kernel.org
References: <0846c96d-62fa-555f-b0ab-1f5ec33fd5fb@gmail.com>
Content-Language: en-US
In-Reply-To: <0846c96d-62fa-555f-b0ab-1f5ec33fd5fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

