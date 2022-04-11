Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954994FC65D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350114AbiDKVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350092AbiDKVNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:13:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FA2B1AA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:10:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ec0490dc1bso46498837b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5cDHQ7aYk/4WlSHe8abtE794AVjCSbjoziFcjScQIDg=;
        b=EHo4PZTgbcB/cGBBAiyRYVsvxPNAoeEZ5fN/cWjy/KeYesKX7nH4FnJDFlKe21/DM5
         jLs2RPbnHA8OBCDkdCL05fYvofTYE4j2wO1J6+MhUjdP3HiCHMmgToc+a39Nd5xLiyjD
         UO4K/gp66K4tEZNuqVFocRHHlJgLTLzZRHg9XBRDQZRU/k5Dw2XRLvr6YHTkAaW6FICH
         Rda7WzMpBonouqjbqwkXxZkQCF1jJDXTZKqShJJlIn+MMY2fCqkf6yfWN8+kgPySfL2F
         DrTUYHik/1yNic3JcSos6vItGPm5wvzqodPdf0Qkywemw6rXS0uD4B9eLp/F4O78Kw8A
         mKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5cDHQ7aYk/4WlSHe8abtE794AVjCSbjoziFcjScQIDg=;
        b=cv35noDgvJoZ53cGp7qDuReWyL0XWT/VKwqlOQYrSbI3GaSNTjejJfjCDfHhK7jn4f
         YeFoIR/fZ7gboSrLpFu6TZcUX/LUwnojmJEMKLBL/EJG1BFVkyRVDScevXoxYsaC9GbS
         mTDJzWMpZ7q4oYdTqO5BpZie6lps2JA2s+a9f/3kR4SIbFrynmwcNwoVnXCYTYUwLBwD
         Be4xMCVFmjAaZ7jMnZf8mExfEqRKCE1Jjmv1PkccLxHmsce/5RyDKZYbpONzJHwt/dJN
         DpoUvOk6aUgnni26Z0JuaGnjoup9zPEMvS9HGL06/ps+brkC4AROQepe9bAHhyvoVpfF
         lqzQ==
X-Gm-Message-State: AOAM531C3Nmp7BbPxNBC7zdBQNCtbjKtT6EB1+knSOKsgXr/hCk224No
        mwpPl3wJbM9FKrVwKohwsZIO8Xp0vs4zPMIt1DpnSlGqp6jq2N4WlA6bhk5TzHQT3DjfgtvsizJ
        iRjQxq4+97430T2ZFLfU4uQAgCQNf3F1Iydm4fyCoZu183WIBG+wB3xh5xfvvBNy+mhPoWWeg
X-Google-Smtp-Source: ABdhPJzYux8ibwEUBRsQsI9vPNp1Exnwx/91xo77Pgzf9e9e6BbohC6/2rA2NAZ7cIlMzGKrYQCU6X1a0A5t
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:a2d0:faec:7d8b:2e0b])
 (user=bgardon job=sendgmr) by 2002:a81:413:0:b0:2ec:31d7:7e60 with SMTP id
 19-20020a810413000000b002ec31d77e60mr5057689ywe.62.1649711451242; Mon, 11 Apr
 2022 14:10:51 -0700 (PDT)
Date:   Mon, 11 Apr 2022 14:10:13 -0700
In-Reply-To: <20220411211015.3091615-1-bgardon@google.com>
Message-Id: <20220411211015.3091615-9-bgardon@google.com>
Mime-Version: 1.0
References: <20220411211015.3091615-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v4 08/10] KVM: x86: Fix errant brace in KVM capability handling
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The braces around the KVM_CAP_XSAVE2 block also surround the
KVM_CAP_PMU_CAPABILITY block, likely the result of a merge issue. Simply
move the curly brace back to where it belongs.

Fixes: ba7bb663f5547 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b810ea45f965..de1d211f8aa3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4383,10 +4383,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		if (r < sizeof(struct kvm_xsave))
 			r = sizeof(struct kvm_xsave);
 		break;
+	}
 	case KVM_CAP_PMU_CAPABILITY:
 		r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
 		break;
-	}
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = KVM_X86_VALID_QUIRKS;
 		break;
-- 
2.35.1.1178.g4f1659d476-goog

