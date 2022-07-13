Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A48573996
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiGMPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGMPE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:04:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A45663C8FE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:04:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3F5C143D;
        Wed, 13 Jul 2022 08:04:58 -0700 (PDT)
Received: from bogus (unknown [10.57.7.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2CCC3F73D;
        Wed, 13 Jul 2022 08:04:55 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:04:52 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] amba: Remove deferred device addition
Message-ID: <20220713150452.faprhd6vx66n5oqv@bogus>
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
 <20220705083934.3974140-1-saravanak@google.com>
 <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
 <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com>
 <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
 <CAGETcx8spsUv57AFURZHiTX_j5jaLQ=5fStsc3=GhRJ9ti9xJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8spsUv57AFURZHiTX_j5jaLQ=5fStsc3=GhRJ9ti9xJQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:53:20PM -0700, Saravana Kannan wrote:
> Sudeep,
> 
> Is there a DTS (not dtsi) file that corresponds to the board you were
> testing this on?
> 

arch/arm64/boot/dts/arm/juno-r2-scmi.dts

-- 
Regards,
Sudeep
