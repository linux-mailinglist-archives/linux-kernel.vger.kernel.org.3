Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B770053EBBC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiFFOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiFFOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:51:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 578CC18C079
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:51:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CADA1480;
        Mon,  6 Jun 2022 07:51:47 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BD5F3F73B;
        Mon,  6 Jun 2022 07:51:46 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Remove unused local variables
Date:   Mon,  6 Jun 2022 15:51:42 +0100
Message-Id: <165452690982.3957918.9251759630196988162.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530115237.277077-1-cristian.marussi@arm.com>
References: <20220530115237.277077-1-cristian.marussi@arm.com>
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

On Mon, 30 May 2022 12:52:36 +0100, Cristian Marussi wrote:
> While using SCMI iterators helpers a few local automatic variables are
> defined but then used only as input for sizeof operators.
> 
> cppcheck is fooled to complain about this with:
> 
> drivers/firmware/arm_scmi/sensors.c:341:48: warning: Variable 'msg' is not assigned a value. [unassignedVariable]
>  struct scmi_msg_sensor_list_update_intervals *msg;
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/2] firmware: arm_scmi: Remove unused local variables
      https://git.kernel.org/sudeep.holla/c/d0c94bef70

--
Regards,
Sudeep

