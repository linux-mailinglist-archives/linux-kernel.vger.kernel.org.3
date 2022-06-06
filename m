Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3A53EBB9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiFFOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbiFFOvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:51:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B866C644E9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:51:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 364D11480;
        Mon,  6 Jun 2022 07:51:31 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D0063F73B;
        Mon,  6 Jun 2022 07:51:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Relax BASE protocol sanity checks on protocol list
Date:   Mon,  6 Jun 2022 15:51:06 +0100
Message-Id: <165452690983.3957918.16899232286285510282.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220523171559.472112-1-cristian.marussi@arm.com>
References: <20220523171559.472112-1-cristian.marussi@arm.com>
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

On Mon, 23 May 2022 18:15:59 +0100, Cristian Marussi wrote:
> Even though malformed replies from firmware must be treated carefully to
> avoid memory corruption Kernel side, some out-of-spec SCMI replies can
> be tolerated to avoid breaking existing deployed system, as long as they
> won't cause memory issues.
>

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Relax BASE protocol sanity checks on protocol list
      https://git.kernel.org/sudeep.holla/c/122839b58a

--
Regards,
Sudeep

