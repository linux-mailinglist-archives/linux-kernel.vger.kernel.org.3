Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90F4C33AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiBXR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiBXR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:27:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30116279447
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:26:29 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b6-20020a621b06000000b004e1453487efso1605523pfb.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/yI+1iHLFKapqIM71Fi477KtJQIbrAd1wE7m0DoVTrg=;
        b=BX44DBoUoT7DxSh0J1USD87fHZhHxbcIv+UIN+p9yTigBQ9rkC70b9lUdxzXby4YQD
         KMd52RGWYjaaW1mHhmPX5yT+JeYaFygpZY0qhfH1XvQg4NW+V/3WQmadTFO0LuyUmjqI
         Lf4X1oVugf+w+6UILacWvqCQD699Y1sZ4jHxPCht5kQp0Z7gmZzjkNCEjNdcP+9Z/PgR
         xKtXomjP+kvoY2+igh5Qgl1oXuX44weeSxLg17woXyG242n2H2rrMhMI9uPz0uyVFxom
         j9u76QtEXmUQj2ImKEWLR1zsNdb+nKTskysG+XXZFqOdlVy/AMw05nrczKv2DjXofDpL
         i+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/yI+1iHLFKapqIM71Fi477KtJQIbrAd1wE7m0DoVTrg=;
        b=1+6w7TVLAmnrcFgQQthcHZ2qY0p5wOUC9hllb5DD8PrIgbnPM+Hx0rJLSPFsFxImFG
         1FzHttJg+tsEtZT8ljNbbwY11d2ZuG92PLhHHrz7HpnKViZsTJEuki2qvCjgFEbyjlto
         Ism4DsZFMJlPk7JerqEXadyk+W5SySSk/8dF1WJNFqLV2CQ9YMTgTJBJoNwzd0TXMOqJ
         ezUNoFbIVLfCF/oPcBM7wPloo6F3DOOmaABLJF9XaM0scH7ltGNCfU4A3OpVWMaI2VfL
         oGjLy55xCQoG5h5SRptNZqFXDN1ElYye6+LnVjseie1x46G/qY4JKhl/doK7l/JyU6YB
         6Btw==
X-Gm-Message-State: AOAM5310GhFCTSib+TiHuRL/9zNZGayJj59IVVpnQwfPKXsx8whB/TKE
        P6+UMogT3ZxD0OXleIlMffPENzGZMW9I
X-Google-Smtp-Source: ABdhPJyekDaVQfujrpGwc51nGDLUID+Ox5wvRHROwF3BH9GvfkusWzxxeNEpolKSk+8ZEG7ImKIZOKSGzN1P
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:700b:b0:148:ee33:70fe with SMTP id
 y11-20020a170902700b00b00148ee3370femr3741547plk.38.1645723588637; Thu, 24
 Feb 2022 09:26:28 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:25:55 +0000
In-Reply-To: <20220224172559.4170192-1-rananta@google.com>
Message-Id: <20220224172559.4170192-10-rananta@google.com>
Mime-Version: 1.0
References: <20220224172559.4170192-1-rananta@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 09/13] Docs: KVM: Rename psci.rst to hypercalls.rst
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

Since the doc now covers more of general hypercalls'
details, rather than just PSCI, rename the file to a
more appropriate name- hypercalls.rst.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 Documentation/virt/kvm/arm/{psci.rst => hypercalls.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/virt/kvm/arm/{psci.rst => hypercalls.rst} (100%)

diff --git a/Documentation/virt/kvm/arm/psci.rst b/Documentation/virt/kvm/arm/hypercalls.rst
similarity index 100%
rename from Documentation/virt/kvm/arm/psci.rst
rename to Documentation/virt/kvm/arm/hypercalls.rst
-- 
2.35.1.473.g83b2b277ed-goog

