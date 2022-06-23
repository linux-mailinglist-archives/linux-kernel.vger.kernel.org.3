Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B8558954
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiFWTlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiFWTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2BE4F1F8;
        Thu, 23 Jun 2022 12:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6210B82506;
        Thu, 23 Jun 2022 19:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C9C341C8;
        Thu, 23 Jun 2022 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012734;
        bh=ZdmigUbppH2BlsyCjxD6GHpDlci7DR7Vnz7cHYwiTk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5DIS2LTmt+/GgHw5VG62eMk7RrpspOglhZJN8Rff9zK7AK66U8Js9+9gZBse5qX+
         ExyUuAXgAQg49+vIIrIwAKDeByUlsFauqHSh/Oux5Rhh1UqZnukl/A8+3Q9UuES3ja
         kD7RQlMtFbOlZY+51dMILfmT1aWzUb4rmaFwcFvXH4Az6vcwWwIQ83e+TmYFVQkSoF
         Xibf7HcTozTVLvmDJzwW7iz3ghBcxs6BMnKuV4kBE8fuTAP5+fTSgNucf3Dybs383O
         OQWW6UH5aLdMjb6DKXMtkzWgGvXwBNnufCCnnBh42azusSUhdeiQRdpq35yfdoBoe7
         ry2A126MNxngQ==
From:   Will Deacon <will@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Walle <michael@walle.cc>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: remove generic ARM cpuidle support
Date:   Thu, 23 Jun 2022 20:31:42 +0100
Message-Id: <165599037407.2971163.13182128360037725255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220529181329.2345722-1-michael@walle.cc>
References: <20220529181329.2345722-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 20:13:27 +0200, Michael Walle wrote:
> Playing with an own PSCI implementation, I've noticed that the cpuidle-arm
> driver doesn't work on arm64. It doesn't probe because since commit
> 788961462f34 ("ARM: psci: cpuidle: Enable PSCI CPUidle driver") the
> arm_cpuidle_init() can only return -EOPNOTSUPP, because the commit removed
> the cpu_idle_init and cpu_suspend ops.
> 
> It left me puzzled for quite some time. It seems that the cpuidle-psci is
> the preferred one and this has been the case for quite some time. The
> mentioned commit first appeared in v5.4.
> 
> [...]

Applied to arm64 (for-next/cpuidle), thanks!

[1/2] cpuidle: cpuidle-arm: remove arm64 support
      https://git.kernel.org/arm64/c/51280acad855
[2/2] arm64: cpuidle: remove generic cpuidle support
      https://git.kernel.org/arm64/c/471f80db9ef1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
