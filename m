Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4584F138B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353742AbiDDLBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiDDLBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:01:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B65922BEE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:59:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02D2AD6E;
        Mon,  4 Apr 2022 03:59:42 -0700 (PDT)
Received: from bogus (unknown [10.57.43.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF1873F718;
        Mon,  4 Apr 2022 03:59:40 -0700 (PDT)
Date:   Mon, 4 Apr 2022 11:59:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix incorrect type in optee transport
Message-ID: <20220404105938.dfhpniy7sugl5dd4@bogus>
References: <20220404101722.27986-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404101722.27986-1-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:17:22PM +0200, Etienne Carriere wrote:
> Correct struct scmi_shared_mem references that should have __iomem
> attribute. The issue was reported by kernel test robot:
> 
> drivers/firmware/arm_scmi/optee.c:428:20: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct scmi_shared_mem * @@     got struct scmi_shared_mem [noderef] __iomem *shmem @@
> drivers/firmware/arm_scmi/optee.c:440:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct scmi_shared_mem [noderef] __iomem *shmem @@     got struct scmi_shared_mem *shmem @@
>

We seem to have crossed each other when we posted this. I hadn't got this
patch before I posted. Sorry for that.

-- 
Regards,
Sudeep
