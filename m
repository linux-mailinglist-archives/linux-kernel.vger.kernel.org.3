Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D487C546B21
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbiFJRA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344239AbiFJRAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:00:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D31738BF0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:59:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566B012FC;
        Fri, 10 Jun 2022 09:59:43 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83FE23F766;
        Fri, 10 Jun 2022 09:59:42 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/3] firmware: arm_scmi: Review BASE protocol string-buffers sizes
Date:   Fri, 10 Jun 2022 17:59:31 +0100
Message-Id: <165488021406.462190.1740470149843111137.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608095530.497879-1-cristian.marussi@arm.com>
References: <20220608095530.497879-1-cristian.marussi@arm.com>
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

On Wed, 8 Jun 2022 10:55:28 +0100, Cristian Marussi wrote:
> SCMI Base protocol agent_name/vendor_id/sub_vendor_id are defined by the
> specification as NULL-terminated ASCII strings up to 16-bytes in length.
> 
> The underlying buffers and message descriptors are currently bigger than
> needed; resize them to fit only the strictly needed 16 bytes.
> 
> While at that, convert Base protocol strings handling routines to use the
> preferred strscpy.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/3] firmware: arm_scmi: Review BASE protocol string-buffers sizes
      https://git.kernel.org/sudeep.holla/c/4314f9f4f8
[2/3] firmware: arm_scmi: Fix SENSOR_AXIS_NAME_GET behaviour when unsupported
      https://git.kernel.org/sudeep.holla/c/8e60294c80
[3/3] firmware: arm_scmi: Use preferred strscpy to handle strings
      Merged in 1/3 to avoid any possible bisection issues, since they both
      deal with the same issue.

--
Regards,
Sudeep

