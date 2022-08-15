Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631FF593013
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiHONiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHONiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:38:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD111C11F;
        Mon, 15 Aug 2022 06:38:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3106420B66;
        Mon, 15 Aug 2022 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660570679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcpVYzMEA+H/V7Bf3M24cryWDFacXSnPSeR3co47SUI=;
        b=YzYEszHbR1Ybv4EbUQMxDgHR88k4rwx2F/wSlxXQvL7SZNmgmhrIyaQhLzU8ohMcMeoeTZ
        LtmdgA1IUBSEdtfKrAyVEXGDzOkaFdMpUreTv7nhLrigmFxlx8f0XNaHe13HIvSjhU59j8
        ibHn+jAMcxnzC/sFjxqlL4uYJXnY1ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660570679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcpVYzMEA+H/V7Bf3M24cryWDFacXSnPSeR3co47SUI=;
        b=tOHHAYAJswPRuqLH68rzB9tFUlE0loXwtV/neEIQXppr3fOhfBdtO0gzqEOzoW+obBjjtv
        d9w3nsa9esz08ICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1176513A93;
        Mon, 15 Aug 2022 13:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 28BHAzdM+mLwSgAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 15 Aug 2022 13:37:59 +0000
Message-ID: <2bac83ef-d5a9-b8c4-0fb3-cef4272e7156@suse.cz>
Date:   Mon, 15 Aug 2022 15:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH v2] docs/arm64: elf_hwcaps: unify newlines in HWCAP lists
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     broonie@kernel.org, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org
References: <49253b17-738d-795e-f539-55857fdaee64@suse.cz>
Content-Language: en-US
In-Reply-To: <49253b17-738d-795e-f539-55857fdaee64@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In git revision 94bdaa7d9a9d778d893c670d494c06d8e007c1cd I unified
vertical spaces in a list of features.

Since the revision, another commits added new features that have a different
horizontal spacing.
Fix these extra newlines.

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

