Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0614ECB00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349526AbiC3RtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349682AbiC3Rsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:48:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AAF10AF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:46:45 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q21-20020a17090a2e1500b001c44f70fd38so10983638pjd.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ul6Ma4gHiGHUUFFN0Ss0kI5gDJJFL1ZbwQGPK0O1vx8=;
        b=B+aRw7sRQQio/NBwKOkSz9cJGEEpCcW4ZWUqJia2kFcmDFmV46Qzc/yLqAP1pNOK8E
         YTV0rUIiKdTazuyodeKKEIRp7/ou9TFv7jTtK6qEbhtHQeWgZDxuWuk1XUWQn4rntsNY
         BEYnODwfph6f/eaaM4am2CynQd/7oUlSMdq9mjZR1xG/DFHcpCGWewISxACP+81cYM5y
         GsNHAitYqp/TIjYTKez0i/yLrmWYZdKmGmIB3yTusNC6rLybEG2hijRcaBYoKjD3ydUU
         /RhPaQjePjGrgMWadc2659Lb7QRgq5BlVItN4xEawWOTviWA2zrl58DXA8jU+bW/DCYt
         lQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ul6Ma4gHiGHUUFFN0Ss0kI5gDJJFL1ZbwQGPK0O1vx8=;
        b=i7oTlg1LKaidBihKtcjwYYnRGzP6WxwoSkCXRtsffXquYmS4G0zoFrGX9bywjEydjZ
         i7XjWF9SFg/ksl4nvkBzkqcZq8iGvk4WhtTqaHDefsk5L0vtjbjSI/923QFnBeGztFan
         XqQjg0oHYeXpJj1cAeAV3p4Ay7/iIpbLKhkCbRndwKYwixWBOXVP9JN84ZSX4XaM6do/
         K17gm1W/j7BFCwDbqrN4An5xKEUXYMbn0Te5AxZlBRRcKH0QQb8ZMnbMjjDSd3zDonCa
         ZhR4csnbrC1LlodDRSDSc6Ny8D7TjIHDrnhZR2NxVbNvaRP/hOrFFDohXZy+jQCqkw9i
         AwJA==
X-Gm-Message-State: AOAM531JvFl0PPh6sNMLUrZHQqbpWksRh/mAl34EPVH3a+jRreDo39zX
        eCK66kjj66KNZ9o3nKnGNaoSMKxithbRvrB2KzU+Q9KcIuu4YiqIIKr9UCHpUyvPWO9CKP+wWyF
        GurUfIQ+8VAmsqJ3OfO754h6pSPwF4oYLKSrKxqKM5QTcyWco3hOBVu6V9PO+H6L/hbxijYsj
X-Google-Smtp-Source: ABdhPJzcHouHj9gB7A88esaOyDgziJ2fn8lhD/UJQGxsQe4Ci/W+GLFIlDJU/LxZkcVtI7kZhSMenwPgiUTT
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:7c53:ec2f:bd26:b69c])
 (user=bgardon job=sendgmr) by 2002:aa7:8d47:0:b0:4f6:a7f9:1ead with SMTP id
 s7-20020aa78d47000000b004f6a7f91eadmr576049pfe.42.1648662405089; Wed, 30 Mar
 2022 10:46:45 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:46:20 -0700
In-Reply-To: <20220330174621.1567317-1-bgardon@google.com>
Message-Id: <20220330174621.1567317-11-bgardon@google.com>
Mime-Version: 1.0
References: <20220330174621.1567317-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v3 10/11] KVM: x86/MMU: Require reboot permission to disable
 NX hugepages
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
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
index b40c3113b14b..ca5674e04474 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7850,6 +7850,8 @@ should adjust CPUID leaf 0xA to reflect that the PMU is disabled.
 :Capability KVM_CAP_PMU_CAPABILITY
 :Architectures: x86
 :Type: vm
+:Returns 0 on success, -EPERM if the userspace process does not
+	 have CAP_SYS_BOOT
 
 This capability disables the NX huge pages mitigation for iTLB MULTIHIT.
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e00dcf19f826..81e7d825639e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6063,6 +6063,15 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
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
2.35.1.1021.g381101b075-goog

