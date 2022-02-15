Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9ED4B6F20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiBOOjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:39:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiBOOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:38:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2938C102405
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:38:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9E71396;
        Tue, 15 Feb 2022 06:38:48 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2970B3F718;
        Tue, 15 Feb 2022 06:38:48 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Alyssa Ross <hi@alyssa.is>
Subject: Re: [PATCH][REPOST] firmware: arm_scmi: Remove space in MODULE_ALIAS name
Date:   Tue, 15 Feb 2022 14:38:36 +0000
Message-Id: <164485073724.2376958.20415753652688371.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211102704.128354-1-sudeep.holla@arm.com>
References: <20220211102704.128354-1-sudeep.holla@arm.com>
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

On Fri, 11 Feb 2022 10:27:04 +0000, Sudeep Holla wrote:
> From: Alyssa Ross <hi@alyssa.is>
> 
> modprobe can't handle spaces in aliases. Get rid of it to fix the issue.
> 

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Remove space in MODULE_ALIAS name
      https://git.kernel.org/sudeep.holla/c/1ba603f565

--
Regards,
Sudeep

