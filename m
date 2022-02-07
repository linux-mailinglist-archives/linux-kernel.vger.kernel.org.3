Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5024AC88D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiBGSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiBGS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:27:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7C51C0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:27:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9D5311B3;
        Mon,  7 Feb 2022 10:27:16 -0800 (PST)
Received: from bogus (unknown [10.57.41.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 573D73F718;
        Mon,  7 Feb 2022 10:27:15 -0800 (PST)
Date:   Mon, 7 Feb 2022 18:26:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix MODULE_ALIAS
Message-ID: <20220207182628.wzfgby6juawvsqih@bogus>
References: <20220104125145.1654647-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104125145.1654647-1-hi@alyssa.is>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 12:51:43PM +0000, Alyssa Ross wrote:
> modprobe can't handle spaces in aliases.
> 

Can you please repost this ? Either something is wrong with your "To:" and
"Cc:" address as you might have copied everything. Even Cristian's reply
got dropped, and same happened to me. I fixed it manually. I don't see your
message in lore archieve, hence request to repost with proper list addresses.

-- 
Regards,
Sudeep
