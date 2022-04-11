Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92F4FC665
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiDKVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350106AbiDKVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:13:12 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E282B1BD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:10:53 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q13-20020a638c4d000000b003821725ad66so9429484pgn.23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dXlFBD0LldYOfRc7OaKD0wMXPzi3maZCvF8rPD26eTI=;
        b=od645DgDIiqdxXTXIqTecH/cdEHvdo6xF2qu5T02FMQ19MQNLm9xVN/ZO9o0v93qEW
         6kpH4zKRGD2sT+LExaIzj5l4Hp7CRMRF8bLpq6s5ihDNFvAbSv4zOT9ywEHYI53vyLTR
         jCz9NWc9KdYyem5akZTphuk/sjQ6Tde/iYyfxkuxBjXqop1zMCiSZo7KfPuJm6MACxQU
         oglTlvRr2XBhY42HCju5FgQRrDnZAsCB7vq3ca9jbt2wTTIBNWEM6zvV3lTVHmQOJ7Dy
         uYZ4A4QY+6CqedZGz+Q5ng6Q9du0pBMjStji3X/hcVlUKbT3KfYkLQUsCvdH/R4Ku66X
         4gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dXlFBD0LldYOfRc7OaKD0wMXPzi3maZCvF8rPD26eTI=;
        b=w6jEbkSlkLpVWwhD0fo/MM11zMMHUMZOq2hlaGDyc0iL42seP6u/dkpfnXQBe2IteV
         Qml3b/FjJB9eLGazfDXuG0BLEK9Q3FKFyLRCnZ8uS4A4ZpA+K8G0+wjYLhCc/PgjAKMe
         hMMuEFcP1STJkGyITEyOrGquWUQeMKNrGjkIj5ZaJCoz1rzH8uw9ApRmm3Vpyz9Gdlzl
         ANORu1tPxn+jU6O3EXvOAkFDpon5zoM19oyrmchF2IzEZdxc4FyDFP/2851xD4o3Eak2
         m6QcW+7Q3S0ilgdXInuUYBMzNPT495RnAj7vdi/phAjVEo+HXy/ZnRb0fdYapI8u/5D7
         9GYg==
X-Gm-Message-State: AOAM532LHsNBbXg+6qR9MS7lHQdhF15FjX4tSGwByDAkyQsC5Ig9s7pI
        TLQNizsO6hLOw8yTVG+4fqNAUELFQoIYLnSuidX1qK8+8RN97OuzFgrnxajHXA28YuHp7H3Kskg
        EWbOGubvY5lHaojX9IQ3KY0EuZEnmhRHsky50qyqQD39KA7K0WW2zyp3HqvF2yiI7MeSYOgbL
X-Google-Smtp-Source: ABdhPJxRBDuMX+1iIQMZOMQEGWUuODV9pdUUYDXB5DzdeWHVI/JBHhK3LPtoD+bM0n1KR1cloYlAQTXVNNqc
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:a2d0:faec:7d8b:2e0b])
 (user=bgardon job=sendgmr) by 2002:a17:90b:1c87:b0:1ca:f4e:4fbe with SMTP id
 oo7-20020a17090b1c8700b001ca0f4e4fbemr1168462pjb.159.1649711452989; Mon, 11
 Apr 2022 14:10:52 -0700 (PDT)
Date:   Mon, 11 Apr 2022 14:10:14 -0700
In-Reply-To: <20220411211015.3091615-1-bgardon@google.com>
Message-Id: <20220411211015.3091615-10-bgardon@google.com>
Mime-Version: 1.0
References: <20220411211015.3091615-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v4 09/10] KVM: x86/MMU: Require reboot permission to disable
 NX hugepages
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        David Dunn <daviddunn@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jing Zhang <jingzhangos@google.com>,
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

Ensure that the userspace actor attempting to disable NX hugepages has
permission to reboot the system. Since disabling NX hugepages would
allow a guest to crash the system, it is similar to reboot permissions.

This approach is the simplest permission gating, but passing a file
descriptor opened for write for the module parameter would also work
well and be more precise.
The latter approach was suggested by Sean Christopherson.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 Documentation/virt/kvm/api.rst | 2 ++
 arch/x86/kvm/x86.c             | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 31fb002632bb..021452a9fa91 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7861,6 +7861,8 @@ should adjust CPUID leaf 0xA to reflect that the PMU is disabled.
 :Capability KVM_CAP_PMU_CAPABILITY
 :Architectures: x86
 :Type: vm
+:Returns 0 on success, -EPERM if the userspace process does not
+	 have CAP_SYS_BOOT
 
 This capability disables the NX huge pages mitigation for iTLB MULTIHIT.
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index de1d211f8aa3..8d3d6c48c5ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6081,6 +6081,15 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
+		/*
+		 * Since the risk of disabling NX hugepages is a guest crashing
+		 * the system, ensure the userspace process has permission to
+		 * reboot the system.
+		 */
+		if (!capable(CAP_SYS_BOOT)) {
+			r = -EPERM;
+			break;
+		}
 		kvm->arch.disable_nx_huge_pages = true;
 		kvm_update_nx_huge_pages(kvm);
 		r = 0;
-- 
2.35.1.1178.g4f1659d476-goog

