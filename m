Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265DD5655DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiGDMt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiGDMt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:49:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDAE3101E3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:49:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA5D23A;
        Mon,  4 Jul 2022 05:49:56 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48AA53F66F;
        Mon,  4 Jul 2022 05:49:54 -0700 (PDT)
Date:   Mon, 4 Jul 2022 13:48:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        huhai <huhai@kylinos.cn>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: next-20220704: juno-r2: Unable to handle kernel NULL pointer
 dereference at virtual address - scpi_send_message
Message-ID: <20220704124843.nu5jvdomxwwry35g@bogus>
References: <CA+G9fYu0CajqiX5bQq-zmp1rpOW2eniH=fcPaJA+Wwi_XmKCWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu0CajqiX5bQq-zmp1rpOW2eniH=fcPaJA+Wwi_XmKCWQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Mon, Jul 04, 2022 at 05:23:53PM +0530, Naresh Kamboju wrote:
> [please ignore this if it is already reported]
> 
> Following kernel crash noticed on arm64 juno-r2 device while booting
> the Linux next-20220704 kernel.
> 

Thanks for the report. It is just me not pushing the right version of a
particular patch. I will update it after testing once again.

-- 
Regards,
Sudeep
