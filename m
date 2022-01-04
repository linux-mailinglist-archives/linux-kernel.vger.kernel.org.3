Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E68C4848EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiADTuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiADTts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:49:48 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3427BC061799
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:49:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id n4-20020aa79044000000b004bcd447b6easo784393pfo.22
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 11:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T6hXHkZPRWaJl03x2QXMcgYQnVlGJ4p7Dp80AmXpDqA=;
        b=AJ0bPZ1NpwYWYRZhLndCTSqogOo7XiUaZ/UjLqVU7cHLs9Mdi7SUhYWX2x/576gx2r
         tCLIGd6Pr6yHqtDaYDXsqcwF6ITe6QPsyRqxaOReY21N7Kl6+Sx0+V0uK2csFJY6XybX
         0xVsPtfmN+qRC5kGYfgt0H1p8vYf+hx+DY3VgQn157Yrt9QxI7PwsTwKW/eYXwq/OMsP
         Se9XKtz2lEF3/2kC0pimss9ZxccQiX4bCZtcruP4575qQvSGJySRVLFi2vqkcLM772ha
         kFILLe4Btz7d++g14WBdW4sIHMdzE6yJ71iPC6HdvWb7M4xW8tOAl5X7Pubxi3+fJov5
         AKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T6hXHkZPRWaJl03x2QXMcgYQnVlGJ4p7Dp80AmXpDqA=;
        b=NwISXiu4nclNEXZ9tkO2F8txHksc7VVHd3bDdqWnP22dlp04m4jmfb+i2EBqycCdLE
         kKYcWnnRaVVxkerlUNFth8ILiXjOCtGnAc+4uWXP0UJ5yf3rpChC8QO/g6hndqKfJwve
         F39zvblIiIwO/kWNOaAhCx6KVKdJ2v7UqJwsBLEqGkv58KGsl7772pkxGWIX8vKiS2oZ
         L5Kd8Mq+aPTHvYxJO3Rh0A43tit4eqAkfXRFK1amlJ5sE0E7s4/Fpms0AhWIvXa6fBJF
         evyQMvDKn7HAkq/BAQDh4SXo88wd18mPmcyUOfF52UInyahxPFose01DWk5pUppv/852
         h8lQ==
X-Gm-Message-State: AOAM530QkW7zNZus7aVLTsZwUkWEg7qbjgsZKNE0khks0yISAi3WSfyJ
        +JGLhcoYYEzDXwNm4HSHqXTjC3J3RDLt
X-Google-Smtp-Source: ABdhPJwQF9Sh0A8e10VxttETJKJYLzfkIBz9hQW4ADfKatROuxTA+/JgjcWs4dTYR/RUwb0w/HuKzInAFEzp
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6a00:139b:b0:4ba:a476:364e with SMTP
 id t27-20020a056a00139b00b004baa476364emr52491553pfg.59.1641325787730; Tue,
 04 Jan 2022 11:49:47 -0800 (PST)
Date:   Tue,  4 Jan 2022 19:49:15 +0000
In-Reply-To: <20220104194918.373612-1-rananta@google.com>
Message-Id: <20220104194918.373612-9-rananta@google.com>
Mime-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [RFC PATCH v3 08/11] Docs: KVM: Rename psci.rst to hypercalls.rst
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
2.34.1.448.ga2b2bfdf31-goog

