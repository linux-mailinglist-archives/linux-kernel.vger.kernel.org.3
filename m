Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1950928E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353562AbiDTWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352286AbiDTWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:17:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236226F4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:14:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650492890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ead/YMvyvsbhwiIrAHSzJyHf5pO11gW3CKY6Tx6jNqI=;
        b=vH5jOkHaqNvBZaFZkshk2HyAh+9Usxyo4qtXrvr9eOkn7teVC+Sx99w+WEQrnJfd3j07Lp
        XNxzf7wWN4RSIyFCYa0nMvps+wFUn61zFj2RlI/pDigXGthMPE4zX7d4cFECAq6u9i2qiV
        a+k9KOYzvOq3q4GlkhZkcrRE4LW94Zz4a8g2pBAIe1cO2DmyTKspSUu2jjisZ/+yWkB+23
        46h1598pnXxGzWVEO1T9hcARClZyksCv8O6s2ug7gMSJbwxgRVwcpstcfy1CmyAhx+r6Gn
        p9XactkiVqzorBYi4DJIzINVMvbyJYw++az1fz9ZJ6ZxNdrpJaPQncwpmazQsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650492890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ead/YMvyvsbhwiIrAHSzJyHf5pO11gW3CKY6Tx6jNqI=;
        b=UQtYjtAFaO+Q0T4TynT9hmylWWILMxkVciJ4UkRMFGM95WySzamFyzAvIy780m2Zcku51t
        5g2GrycwTii1/OAg==
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     tarumizu.kohei@fujitsu.com
Subject: Re: [PATCH v3 4/9] soc: fujitsu: Add Kconfig/Makefile to build
 hardware prefetch control driver
In-Reply-To: <20220420030223.689259-5-tarumizu.kohei@fujitsu.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-5-tarumizu.kohei@fujitsu.com>
Date:   Thu, 21 Apr 2022 00:14:49 +0200
Message-ID: <87ee1rtnae.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20 2022 at 12:02, Kohei Tarumizu wrote:
> +
> +menu "Fujitsu SoC drivers"
> +
> +config A64FX_HWPF_CONTROL
> +	tristate "A64FX Hardware Prefetch Control driver"
> +	depends on ARM64 || HWPF_CONTROL

  && HWPF_CONTROL

No point in enabling this on x86.

Thanks,

        tglx
