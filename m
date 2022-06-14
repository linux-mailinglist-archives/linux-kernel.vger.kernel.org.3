Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5C54AE08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbiFNKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiFNKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:13:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 366754616B;
        Tue, 14 Jun 2022 03:13:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AA7323A;
        Tue, 14 Jun 2022 03:13:55 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D24723F792;
        Tue, 14 Jun 2022 03:13:53 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm/juno: Drop erroneous 'mbox-name' property
Date:   Tue, 14 Jun 2022 11:13:49 +0100
Message-Id: <165520087950.1030128.14018048495402718658.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610213308.2288094-1-robh@kernel.org>
References: <20220610213308.2288094-1-robh@kernel.org>
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

On Fri, 10 Jun 2022 15:33:07 -0600, Rob Herring wrote:
> The 'mbox-name' property in the Juno mailbox node is undocumented and
> unused. It's the consumer side of the mailbox binding that have
> 'mbox-names' properties.
>

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] arm64: dts: arm/juno: Drop erroneous 'mbox-name' property
      https://git.kernel.org/sudeep.holla/c/c7df8791cd

--
Regards,
Sudeep

