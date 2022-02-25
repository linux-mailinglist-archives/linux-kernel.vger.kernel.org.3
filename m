Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E1C4C4D96
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiBYSXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiBYSXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:23:25 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E66E78C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:22:52 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g72-20020a62524b000000b004f3e21965e8so426063pfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=tEpUVd4jPoK9N2ecaXKtLW2f0KgIvioRCgiZkrx72eI=;
        b=OWOv2+M6YRuwOcezy+sXd6L23PlvZMFz0Dr8BW1S+7jDP5EiWUOkGH/ETk1JZyA7um
         qWXPDYWwxfky114NKGB3NXrOuVafjRsJ4REWEfm1SmqED4mNeo9TQbCr+PMnVm/LIB6M
         spWJ2y/b0Zj4/vMcD1BpCka8UERO/EGcTZT78DxcIuBAyZKjxc/NwCgUU65BEYDGFJUv
         lGlYYG5/tZZzwWoMXF9XWalPdoHPTZhqkb557RJl/vaHBT23v5q4IYfBebf86Llmos7q
         BAiIFGIjV/Q7Ev9uiF/tWhjt/okkT8Fg9jbhysn5iGxXLfjALWqOxeqSgBZCsXIfHvqz
         T0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=tEpUVd4jPoK9N2ecaXKtLW2f0KgIvioRCgiZkrx72eI=;
        b=hm/cA/Sx3IC9oSocboy2xXbdB1/r0DYM2GbdAdLcn48bdutXopwgxjz7PhK1n8uq+f
         c3zebs4Ei8nLWRVG+TCU5U+FUVddEgu42IbDzs8PNOwHNCPeZIy7Sh0hjMlhggfawUIL
         oBO92BU3yDn5sp2KWD3NnBY483EsEbe53WxZBqN59KjENhll2Y6805SCJqoY+gnHkOiL
         IRPo/PAU0nxrmW4bcNp3zJgYV2Ab8WxZ2J2vqLxiEVql55nvemB6MpVbSi/xsLmx+bF3
         RyuPf9VTNxHCv2jSeqjP9xj+wWwFQ4BRkzDtLBKbqRT9c/7r5biM2kcwmEPuqnu9c/h4
         737w==
X-Gm-Message-State: AOAM533mgi3oaL/jKBN6nEDqw7xHwEaAQmyRTU68ZJZIprqfAe7nGLuE
        aNZDSCNWd8fHSEb+32nurm19HCgKcxY=
X-Google-Smtp-Source: ABdhPJzPC25kc1BUDo4Eqxg1mvuOtgWUpXZtFNWPs1qsLhYYWgU6hsM2J1mzu+ugmnwlNkFsi0Yuc/ZEMjc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:9382:0:b0:4e0:cf48:e564 with SMTP id
 t2-20020aa79382000000b004e0cf48e564mr632110pfe.15.1645813371930; Fri, 25 Feb
 2022 10:22:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 25 Feb 2022 18:22:42 +0000
In-Reply-To: <20220225182248.3812651-1-seanjc@google.com>
Message-Id: <20220225182248.3812651-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220225182248.3812651-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 1/7] KVM: x86: Remove spurious whitespaces from kvm_post_set_cr4()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
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

Remove leading spaces that snuck into kvm_post_set_cr4(), fixing the
KVM_REQ_TLB_FLUSH_CURRENT request in particular is helpful as it unaligns
the body of the if-statement from the condition check.

Fixes: f4bc051fc91a ("KVM: x86: flush TLB separately from MMU reset")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6552360d8888..2157284d05b0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1089,7 +1089,7 @@ void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned lon
 	 */
 	if (((cr4 ^ old_cr4) & X86_CR4_PGE) ||
 	    (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
-		 kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 
 	/*
 	 * The TLB has to be flushed for the current PCID if any of the
@@ -1099,7 +1099,7 @@ void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned lon
 	 */
 	else if (((cr4 ^ old_cr4) & X86_CR4_PAE) ||
 		 ((cr4 & X86_CR4_SMEP) && !(old_cr4 & X86_CR4_SMEP)))
-		 kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 
 }
 EXPORT_SYMBOL_GPL(kvm_post_set_cr4);
-- 
2.35.1.574.g5d30c73bfb-goog

