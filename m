Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF3F4F4F78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838265AbiDFAu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449096AbiDEPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:49:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D3CF1AC43F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:32:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2948A1474;
        Tue,  5 Apr 2022 07:32:57 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 744A93F5A1;
        Tue,  5 Apr 2022 07:32:56 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Remove clear channel call on the TX channel
Date:   Tue,  5 Apr 2022 15:32:54 +0100
Message-Id: <164916896263.1245964.13994276768127037329.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224152404.12877-1-cristian.marussi@arm.com>
References: <20220224152404.12877-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 15:24:04 +0000, Cristian Marussi wrote:
> On SCMI transports whose channels are based on a shared resource the TX
> channel area has to be acquired by the agent before placing the desired
> command into the channel and it will be then relinquished by the platform
> once the related reply has been made available into the channel.
> On an RX channel the logic is reversed with the platform acquiring the
> channel area and the agent reliquishing it once done by calling the
> scmi_clear_channel() helper.
> 
> [...]

Applied to sudeep.holla/linux (fixes/scmi), thanks!

[1/1] firmware: arm_scmi: Remove clear channel call on the TX channel
      https://git.kernel.org/sudeep.holla/c/98f0d68f94

--
Regards,
Sudeep

