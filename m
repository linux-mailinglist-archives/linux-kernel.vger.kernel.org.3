Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1154AE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352702AbiFNKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351911AbiFNKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:16:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2AFD46CBB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:16:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D94A23A;
        Tue, 14 Jun 2022 03:16:37 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 86A7E3F792;
        Tue, 14 Jun 2022 03:16:36 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?UTF-8?q?Ludvig=20P=C3=A4rsson?= <ludvig.parsson@axis.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, kernel@axis.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix incorrect error propagation
Date:   Tue, 14 Jun 2022 11:16:34 +0100
Message-Id: <165520087950.1030128.11353401621920544992.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610140055.31491-1-ludvig.parsson@axis.com>
References: <20220610140055.31491-1-ludvig.parsson@axis.com>
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

On Fri, 10 Jun 2022 16:00:55 +0200, Ludvig Pärsson wrote:
> scmi_voltage_descriptors_get() will incorrecly return an
> error code if the last iteration of the for loop that
> retrieves the descriptors is skipped due to an error.
> Skipping an iteration in the loop is not an error, but
> the `ret` value from the last iteration will be
> propagated when the function returns.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Fix incorrect error propagation
      https://git.kernel.org/sudeep.holla/c/44dbdf3bb3
--
Regards,
Sudeep

