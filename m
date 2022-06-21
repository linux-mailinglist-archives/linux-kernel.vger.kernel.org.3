Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266EF553A86
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353865AbiFUT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353480AbiFUT1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:27:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41D3B25C52
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:27:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A20165C;
        Tue, 21 Jun 2022 12:27:33 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D81213F792;
        Tue, 21 Jun 2022 12:27:31 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, vincent.guittot@linaro.org,
        nicola.mazzucato@arm.com, robin.murphy@arm.com,
        f.fainelli@gmail.com
Subject: Re: [PATCH] firmware: arm_scmi: Relax CLOCK_DESCRIBE_RATES out-of-spec checks
Date:   Tue, 21 Jun 2022 20:27:29 +0100
Message-Id: <165583954166.3333585.2295158486736398663.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616170347.2800771-1-cristian.marussi@arm.com>
References: <20220616170347.2800771-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 18:03:47 +0100, Cristian Marussi wrote:
> A reply to CLOCK_DESCRIBE_RATES issued against a non rate-discrete clock
> should be composed of a triplet of rates descriptors (min/max/step)
> returned all in one reply message.
> 
> This is not always the case when dealing with some SCMI server deployed in
> the wild: relax such constraint while maintaining memory safety by checking
> carefully the returned payload size.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Relax CLOCK_DESCRIBE_RATES out-of-spec checks
      https://git.kernel.org/sudeep.holla/c/754f04cac3

--
Regards,
Sudeep

