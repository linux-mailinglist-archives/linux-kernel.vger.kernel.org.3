Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476934ECB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349536AbiC3Rst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349577AbiC3RsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:48:18 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC116E4E6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:46:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id h15-20020a17090aa88f00b001c9de032a8cso270774pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G7mURnYKI7dRrG53NXtgG8tZP8CdWVs3UyeZIO2zi1M=;
        b=bto0ku8fPX/RsuABw+KcM/bOv4xzWoMJUrv3symT9fKI9MeqhERoTujsJMHGmnI+1o
         tsvEIUx1+VJrol9JQNkvstaJDIAvLHy/dUT2uqfsxM8+DrGBNyaUR3g8KPtNlm//GZaT
         iYl3fqVebYaFUEkceUd5LaUnhxWP1xJfo+uZrF/x/egJndaSlgpXZPyKvX0Gu4FKO5Z4
         dpWvtUqq1YuB78BW6hwxCvBcuznIJzMKEi62T58YLTxpUO5MPK7Kt5MRPax+K+kMUkxb
         Hsm84jPVi32qy7/vQHTgwLAhJJx4/JXM/v6AcPuP8BpLnlrsF4GID9gJtk1iA3oAbbu3
         PpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G7mURnYKI7dRrG53NXtgG8tZP8CdWVs3UyeZIO2zi1M=;
        b=Oqgww+N2VO3BD9yA7f0srClqCtbnarhIWbtGLWcMblrKM4GaRpjjoBQ+txBHJWSTWr
         vFRrLNvZtJ65Rx2bscbqBnvlmeiYeJ6e/lM52LIUdMgFlFxxmlkb8AOvz1Ow80HxKgJz
         3vH/0rGXUYX/bKcrc5jNpZggW3FQXmgZWJVPijj4AGbMzPvl1WQ8iRQsefZi3vmNC/wS
         o6JLmodFJfaWsIrBu8fSRDblN/qf2pTEd6b3KTfCc07h9PGBKk35p+QgfDYAGjJKaXpY
         ayAMjM75dMU/4lyamfWM/fUgM2gIcYI01plrny70EGRjH2YGyXQO9Fhfa4g19r0ddkMz
         3pDQ==
X-Gm-Message-State: AOAM533YuH+PI6Cbx/6TaysWnj8FFuxgUJTQMpN7dBlj7pkrt2mFxoY0
        9q/6DrUgrQ+5KdRlfgWNGp7qoGGrF4jFTa1cQLc1yC8Kg1ODuTawrOzMLwezb5va9ZREiZzq7zs
        BiihoI6M5HFofudJOZcbxiYBMpgCy3nUkp3IIkc8h/apjkfxYgRMg9N++BKxWjRxUeEHtRe4J
X-Google-Smtp-Source: ABdhPJyD3QZFLlqDOF+D/6iopbTk4S9ZSWHSUEZlNqnwQxs2YQe11jlstOCanvRochFbn6+tbn8tRSi2zW+Y
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:7c53:ec2f:bd26:b69c])
 (user=bgardon job=sendgmr) by 2002:a17:902:dccc:b0:153:a902:e542 with SMTP id
 t12-20020a170902dccc00b00153a902e542mr520918pll.16.1648662388507; Wed, 30 Mar
 2022 10:46:28 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:46:11 -0700
In-Reply-To: <20220330174621.1567317-1-bgardon@google.com>
Message-Id: <20220330174621.1567317-2-bgardon@google.com>
Mime-Version: 1.0
References: <20220330174621.1567317-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v3 01/11] KVM: selftests: Add vm_alloc_page_table_in_memslot
 library function
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Koller <ricarkol@google.com>

Add a library function to allocate a page-table physical page in a
particular memslot.  The default behavior is to create new page-table
pages in memslot 0.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 92cef0ffb19e..976aaaba8769 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -311,6 +311,7 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 			      vm_paddr_t paddr_min, uint32_t memslot);
 vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
+vm_paddr_t vm_alloc_page_table_in_memslot(struct kvm_vm *vm, uint32_t pt_memslot);
 
 /*
  * Create a VM with reasonable defaults
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1665a220abcb..11a692cf4570 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2425,9 +2425,15 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 /* Arbitrary minimum physical address used for virtual translation tables. */
 #define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
 
+vm_paddr_t vm_alloc_page_table_in_memslot(struct kvm_vm *vm, uint32_t pt_memslot)
+{
+	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+			pt_memslot);
+}
+
 vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
 {
-	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+	return vm_alloc_page_table_in_memslot(vm, 0);
 }
 
 /*
-- 
2.35.1.1021.g381101b075-goog

