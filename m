Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391EA55FCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiF2KFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiF2KFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:05:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5C8A3DA4D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:05:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBC81152B;
        Wed, 29 Jun 2022 03:05:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADF763F792;
        Wed, 29 Jun 2022 03:05:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cristian.marussi@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        etienne.carriere@linaro.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] scmi/optee: fix response size warning
Date:   Wed, 29 Jun 2022 11:05:06 +0100
Message-Id: <165649686859.1115844.6856307867092196404.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220624074549.3298-1-vincent.guittot@linaro.org>
References: <20220624074549.3298-1-vincent.guittot@linaro.org>
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

On Fri, 24 Jun 2022 09:45:49 +0200, Vincent Guittot wrote:
> Some protocols check the response size with the expected value but optee
> shared memory doesn't return such size whereas it is available in the
> optee output buffer.
> 
> As an example, the base protocol compares the response size with the
> expected result when requesting the list of protocol which triggers a
> warning with optee shared memory:
> 
> [...]

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] scmi/optee: fix response size warning
      https://git.kernel.org/sudeep.holla/c/75c8f430d8

--
Regards,
Sudeep

