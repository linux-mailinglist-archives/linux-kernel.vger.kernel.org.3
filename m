Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1750E1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiDYNdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242119AbiDYNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:31:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED1B540A0E;
        Mon, 25 Apr 2022 06:28:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9DBD1FB;
        Mon, 25 Apr 2022 06:28:30 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D7FB3F774;
        Mon, 25 Apr 2022 06:28:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, robin.murphy@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Subject: Re: [PATCH] arm64: dts: juno: add CTI entries to device tree
Date:   Mon, 25 Apr 2022 14:28:26 +0100
Message-Id: <165089291072.1036016.3119087905511783640.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220413214925.30359-1-mike.leach@linaro.org>
References: <20220413214925.30359-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 22:49:25 +0100, Mike Leach wrote:
> Add in CTI entries for Juno r0, r1 and r2 to device tree entries.
> 
> Tested on Linux 5.18-rc2
> 
> 

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] arm64: dts: juno: add CTI entries to device tree
      https://git.kernel.org/sudeep.holla/c/e7676a00bc

--
Regards,
Sudeep

