Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0003B52B74F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiERKL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiERKLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:11:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C0EA258
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:11:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26AB523A;
        Wed, 18 May 2022 03:11:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58E493F718;
        Wed, 18 May 2022 03:11:12 -0700 (PDT)
Date:   Wed, 18 May 2022 11:11:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Gyorgy Szing <Gyorgy.Szing@arm.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] tee: Add Arm FF-A TEE driver
Message-ID: <20220518101109.xdmiuj5gjqg3drhm@bogus>
References: <20220408134144.1532704-1-sudeep.holla@arm.com>
 <CAFA6WYNbwqNqK89ZCWWpAT5HCR59A+J873_5Odyjyb9qu00nsg@mail.gmail.com>
 <20220426144545.6qkn6iwayuwpvi7g@bogus>
 <CAFA6WYMCTn-YQrA-GixYu6OG8Qr_xsZ7xuk4LfFA-1PHgus3RQ@mail.gmail.com>
 <AS8PR08MB5895E2E79F48D5CBF939C45391CE9@AS8PR08MB5895.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR08MB5895E2E79F48D5CBF939C45391CE9@AS8PR08MB5895.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 06:55:47PM +0100, Gyorgy Szing wrote:
> Hi Sumit,
> 
> The best way to test the driver is to use the PSA SPs from Trusted Services
> similarly as described on the wiki page above. We have merged the TEE driver
> enablement patches to integration branch of TS recently, and as a result the
> set-up and build instructions above will build an end-to-end config using
> the TEE driver.
> The TEE driver integration needs to be changed though. Instead of building
> the TEE driver as an out of tree module from our fork [2], you might want to
> change the config to use the driver posted by Sudeep. If you wish to use the
> op-tee build flow, the makefiles in OP-TEE/build repo part of the above
> set-up need modification too.

Correct I have done something similar when testing as a module.

> TS will build multiple test executables targeting the Linux user-space. For
> TEE driver testing any of these targeting the "arm-linux" environment will
> do, but I suggest using the "ts-service-test".
> 
> AFAIK Sudeep is testing with TS too using a similar set-up.
>

Indeed. I just made couple of minor changes to the way app checks the presence
of the driver and dropped the version check.
Ref: ffarpc_caller_check_version in components/rpc/ffarpc/caller/linux/ffarpc_caller.c
to make progress.

> [2] https://gitlab.arm.com/linux-arm/linux-trusted-services
> 

-- 
Regards,
Sudeep
