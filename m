Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D64F7156
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiDGB2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiDGBUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:20:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C51864BE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 18:16:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x3-20020a17090a6c0300b001cab7230b41so2580392pjj.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXF/n8xvBk0FaoqPxko9Blx99fwDwCfccorRyyHCGmI=;
        b=Ku987wK6rt+m7eJsyZLO6atNDPGpbqe4iAXnvp/z+wT4OAEoeg5o3OAlVCchPx2L90
         102SSaR5cOkN6fP9KK1z++y2/yupbiYjbDvWjD2Qece4MWsVopP3FCXHX4y/zHjbpWC1
         gPOj/Frc3z6/rMyZik2wcjHitIQ4/twgDnejS7ftwlIb7sbfGEUikTJBplt2AK2+GVaZ
         07sKnoPUR6sFzjL+MzpauXdv8UdFJexw9xi8RG6979lRl0UQdLY95bXFxQyCZdMoIbFU
         0VtliYgcNZH8l/+6VtdO2QrethSXUAVc7WRMaO/7ps9olTMrNkeZKKeVqELA9bxuRt6C
         2ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXF/n8xvBk0FaoqPxko9Blx99fwDwCfccorRyyHCGmI=;
        b=clB213SGUMLm5wLi0e1ccGoJKTnTYPS5m5P8uKIfS8juTUnsqiGBxKKDl8mf+64UiR
         SehVS19Hy1sIPlUWQdsAHHNDOUNI5+y5Hfr7vHWvvg8fAEjFtBgh0owiflVGXFfguNGK
         KluTMcefPXPX1nvBWVW5J132h+FDXvs5x0SeTf/eVslI0eRTYXemxgWDNKWuf3n8pgf1
         Slzrce51O2T35VLUC3ecbkUX30kHkCZfgPGswW47oMLjgK1B2OgXRxZrrKU/ah6OErwx
         XiW+n/f9fiVxQYULbZZ9S/T1g2x27CkWFn7tk92W8bFzpdUeW61nrELp1uNXGuYTLltU
         EEug==
X-Gm-Message-State: AOAM53044A1ZW4HOe6ilgVig5D/KIIfhb45gmLGpp4hX82JqW4iNJNNl
        7nT1ghsxqtAy99izMDQoKL0Qx9FyjAlF
X-Google-Smtp-Source: ABdhPJw2dezSQVSintcsyWAePk4VuF7JuHzdsneJX2UxM+MFRSiIefC4mvBoj4uqrdxw8cb/zhGbCkzWilbb
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6a00:440c:b0:4fa:da3f:251c with SMTP
 id br12-20020a056a00440c00b004fada3f251cmr11599625pfb.73.1649294181092; Wed,
 06 Apr 2022 18:16:21 -0700 (PDT)
Date:   Thu,  7 Apr 2022 01:16:00 +0000
In-Reply-To: <20220407011605.1966778-1-rananta@google.com>
Message-Id: <20220407011605.1966778-6-rananta@google.com>
Mime-Version: 1.0
References: <20220407011605.1966778-1-rananta@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v5 05/10] Docs: KVM: Rename psci.rst to hypercalls.rst
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

Since the doc also covers general hypercalls' details,
rather than just PSCI, and the fact that the bitmap firmware
registers' details will be added to this doc, rename the file
to a more appropriate name- hypercalls.rst.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
---
 Documentation/virt/kvm/arm/{psci.rst => hypercalls.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/virt/kvm/arm/{psci.rst => hypercalls.rst} (100%)

diff --git a/Documentation/virt/kvm/arm/psci.rst b/Documentation/virt/kvm/arm/hypercalls.rst
similarity index 100%
rename from Documentation/virt/kvm/arm/psci.rst
rename to Documentation/virt/kvm/arm/hypercalls.rst
-- 
2.35.1.1094.g7c7d902a7c-goog

