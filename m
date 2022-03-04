Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACFC4CD9E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiCDRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbiCDRPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:15:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC6251B371E;
        Fri,  4 Mar 2022 09:14:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ADF81478;
        Fri,  4 Mar 2022 09:14:12 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C07083F73D;
        Fri,  4 Mar 2022 09:14:11 -0800 (PST)
Date:   Fri, 4 Mar 2022 17:14:09 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ACPI flow for reserved memory
Message-ID: <YiJI4fe0tYDj96ob@bogus>
References: <BY5PR02MB6947E939600E244DDDCFF341A5049@BY5PR02MB6947.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB6947E939600E244DDDCFF341A5049@BY5PR02MB6947.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

I am not UEFI expert but I was sure there would be some options for this.
Checking with Sami(cc-ed), confirmed the same.

On Thu, Mar 03, 2022 at 11:07:54AM +0000, Bharat Kumar Gogada wrote:
> Hi All,
> 
> In device tree we have several ways to 
> reserve memory (https://github.com/Xilinx/linux-xlnx/blob/master/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt).   
> 
> Can anyone please help equivalent flow for ACPI.

@Sami, please share any details you may have.

-- 
Regards,
Sudeep
