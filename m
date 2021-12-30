Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC1481DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbhL3P6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhL3P6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:58:03 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9084EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:58:02 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id m18so21615057qtk.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JS+FiKSeT5f12gRyVzfSR3kPguW23wtXqyvRjIMFpqI=;
        b=mY4GeSgx7uJKI8pLh6VENQs/UsOw59UxMLfMIP92SxOTvBd3AtvzG84MJMmKy8rQPM
         l6uOY/iTCJ5208cHc8x/gVcl2Sfw0BXV1It7s/zUrRFRlmpQUba1zuur1jHWnHymD7OZ
         MBFDUhLa5hsEr2NPIoX0oYa6bhi4Wkf+qVCA07asQzJIxyXbsNut3qw0GqiCJcH5NHaj
         Ifb0GyPQq06hi9W5IygEOWdFg+ojHEM61XH9WWkShFe+ePHNwnjGJ9euNw23bsJ+mpO6
         9S04byKVRDWja/EJY9/dDdbIQSpWLz4Evr7ATnRNG6sDycKG1IYtWzvLuo1DSrXyfN3W
         qr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JS+FiKSeT5f12gRyVzfSR3kPguW23wtXqyvRjIMFpqI=;
        b=UDib1v7FOtlZueZmQU1GNDd+zFj26vOZxld4AqAuHx/qvtRqTVn4JG0KTPO/wEw12T
         BIq1GpmlympPKYpwhUr4yDw4R0oVK8Pq4fsKh10b+HPyVtJq5KJnsYImthYWKPzu6or0
         w5UHimG0z37pak1ZHZhWq1lhMAQOWgaUOppv59eIR+gjyMKidFgkks3px6GH8POeiPXI
         ul+aBtPFvCq76JNjmdt6uC2WKTULL1ib7hFn6fpfoe61DubdmRp70kx3L0Zv50vw9Vmo
         3X79flrAjF9k0/2hpaN7MqGkmCDWaRgnizmL3dCXzt+oEu7pujQ9H1mWe0bsHVnELr0e
         +u9w==
X-Gm-Message-State: AOAM530Pj4Eyqo0FcTicRkzhmIaP98NFbwLVJDcHPRlqlHuFrN/kPMf/
        qEdsKygtWtPLw4aLSsr0Jr0=
X-Google-Smtp-Source: ABdhPJxcBEOdjQ+MgEJANgHQuPK0IPhBHynueDf+BM9DEl4Um31/Zb9ZnZS3E2MR8vMZpjZjYhXWqg==
X-Received: by 2002:a05:622a:3d1:: with SMTP id k17mr23980588qtx.335.1640879881789;
        Thu, 30 Dec 2021 07:58:01 -0800 (PST)
Received: from localhost.localdomain (071-085-241-167.res.spectrum.com. [71.85.241.167])
        by smtp.gmail.com with ESMTPSA id k9sm20495402qta.48.2021.12.30.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:58:01 -0800 (PST)
From:   hasheddan <georgedanielmangum@gmail.com>
Cc:     georgedanielmangum@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Guo Ren <guoren@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Andreas Schwab <schwab@suse.de>, Zihao Yu <yuzihao@ict.ac.cn>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv/entry: fix misspelling of instruction
Date:   Thu, 30 Dec 2021 10:57:11 -0500
Message-Id: <20211230155714.1019859-1-georgedanielmangum@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes spelling from instruciton to instruction in comment in entry.S.

Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
---
 arch/riscv/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ed29e9c8f660..728c521dcc85 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -568,7 +568,7 @@ ENTRY(excp_vect_table)
 	RISCV_PTR do_trap_ecall_s
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_trap_ecall_m
-	/* instruciton page fault */
+	/* instruction page fault */
 	ALT_PAGE_FAULT(RISCV_PTR do_page_fault)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
-- 
2.25.1

