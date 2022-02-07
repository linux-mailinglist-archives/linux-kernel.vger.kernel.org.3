Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C34AC8A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiBGSfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiBGScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:32:04 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE40C0401DF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:32:04 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mz22-20020a17090b379600b001b863f7a846so7268798pjb.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=S5r7fnqeDy+mkjZQN4h4voFdDc0GV+XZLPB3/vK2BOk=;
        b=aCiYn/Ji6EoB3DdBgLs2L5HeMojNwVbv+p28zibQLL/3F9XbD3Lzp1ufLuITgHINsZ
         BvcUIO1KlLVwXMb2H7E9NfgwvyHV47qt4YZVb5Le2IrOdIlgphyH0KtEeAVq/xHybiK/
         BtC8X3Dw0eutmyTCEFH1BPc3yXUkUJxxd55QCZ3TbgCieFKOm6PkItqy12CjDp487j0R
         ciwswkfANlJPav+oI8IZbnvGz/WPRbwjDOmNVvIQ5QDQ7i0IJYfMplALClGa0em3n28B
         ni5awbGtUaAMjpVkyZ+nEJfPqICHpisdC2pZbyJfjed3F1mdZ7HqG0t9n5BpNgNBE/Aa
         L4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=S5r7fnqeDy+mkjZQN4h4voFdDc0GV+XZLPB3/vK2BOk=;
        b=Y9r/Z955koiARHXdd4kxZjKIRwf4bTmDwrMBj4SSDGqWlPLCdO1sa2MI1yEN88kTpM
         LgJV1iYta6Hd68C2VsxkXIbTHTBFzrQpKnm5e+VrmD+vCUh/LXrjB5fHOr2gkLADvpOp
         9oPtBXnHcij9OCUUd3vrovh6MrgonZ5+YV66Zw6k+wxSAoKa4H08a6OsWyI8taKFxKU4
         VaCxXozG35/9eBTOf8FqwB+hn4kjtesDtWpmytezlyxJ/ogNj4eT8+AT+4uFOouPiSn9
         7CBA/TiccQY8n4xH5IwGrT1T1nv6a3P2YDZAF3g9afPmgL0h6lAtEH92WLopHbbDegwm
         kf/Q==
X-Gm-Message-State: AOAM533D+Rb3KCMKEUTvdLwy3rzWK9YjHfguAZDtIqyULqN6Bn3mynbC
        OWreRWh9NnlS7cTfVeeA6+T3yqbetjtn
X-Google-Smtp-Source: ABdhPJxcKq2dEI5NXB5GHj0brCLFSKHkA6D4MuUXxnx2zPwa3jitNwWBvjFX/9uQ/jtLm+pjtB1upIGEBzWf
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:903:2290:: with SMTP id
 b16mr853365plh.103.1644258723718; Mon, 07 Feb 2022 10:32:03 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon,  7 Feb 2022 18:31:44 +0000
Message-Id: <20220207183144.1148652-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH] KVM: fix trailing spaces and incorrect indent in function parameter.
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trailing spaces and incorrect spaces within function defintions makes it
incovenient to submit new patches to the code, as they are always
'irrelevant' changes.

So, fix the space issue in virt/kvm/kvm_main.c in a separate commit.

Cc: David Matlack <dmatlack@google.com>

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 virt/kvm/kvm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 034c567a680c..37606b61a28d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2514,7 +2514,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 	 * tail pages of non-compound higher order allocations, which
 	 * would then underflow the refcount when the caller does the
 	 * required put_page. Don't allow those pages here.
-	 */ 
+	 */
 	if (!kvm_try_get_pfn(pfn))
 		r = -EFAULT;
 
@@ -2932,7 +2932,7 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
 static int __kvm_write_guest_page(struct kvm *kvm,
 				  struct kvm_memory_slot *memslot, gfn_t gfn,
-			          const void *data, int offset, int len)
+				  const void *data, int offset, int len)
 {
 	int r;
 	unsigned long addr;
-- 
2.35.0.263.gb82422642f-goog

