Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C8D50E1B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiDYNd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiDYNb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:31:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80EE940A1F;
        Mon, 25 Apr 2022 06:28:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D2CD1FB;
        Mon, 25 Apr 2022 06:28:24 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D94123F774;
        Mon, 25 Apr 2022 06:28:22 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Diego Sueiro <diego.sueiro@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, nd@arm.com, liviu.dudau@arm.com
Subject: Re: [PATCH] arm64: dts: fvp: Add virtio-rng support
Date:   Mon, 25 Apr 2022 14:28:02 +0100
Message-Id: <165089291072.1036016.16110407620491114248.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <ac3be672c636091ee1e079cadce776b1fb7e0b2e.1650543392.git.diego.sueiro@arm.com>
References: <ac3be672c636091ee1e079cadce776b1fb7e0b2e.1650543392.git.diego.sueiro@arm.com>
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

On Thu, 21 Apr 2022 15:35:21 +0100, Diego Sueiro wrote:
> The virtio-rng is available from FVP_Base_RevC-2xAEMvA version 11.17, so add
> the devicetree node to support it.
> 
> 

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] arm64: dts: fvp: Add virtio-rng support
      https://git.kernel.org/sudeep.holla/c/5393158f00

--
Regards,
Sudeep

