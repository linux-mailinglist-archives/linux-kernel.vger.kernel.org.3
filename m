Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E582A5AD4D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiIEOa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiIEOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:30:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86653D5BE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:30:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2EC911F9ED;
        Mon,  5 Sep 2022 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662388251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZY74CtrE2fNgBYPVcD9k7Aap6fAvNiS5mnQBJZXgfk=;
        b=Y/sqvnNEb0jqjQip4GXS88Ch8H/DcZq7iVMHNE55WU6sJEmuy80sE2hSUZzklm47Vud7Tv
        GaYLg9C/znmcnt40i6HNIirNichH0DDFmZcJstBQk+KznnSIlSLtXNKh3gqFQcM23c3YHM
        usntVtX+azNzsWOe/Vhq5X+Pl62xyVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662388251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZY74CtrE2fNgBYPVcD9k7Aap6fAvNiS5mnQBJZXgfk=;
        b=JuuVPbKcN+146YtgSa5ELPUX+CWIK61n5BXmhJTwNDw/+cjRDPry6M5iM0kdQR1lmidbGQ
        c+VZXhF3nKuL3SCg==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 83EC32C141;
        Mon,  5 Sep 2022 14:30:50 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 92308444AFD; Mon,  5 Sep 2022 16:30:48 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com
Subject: Re: [PATCH v3] drivers/perf: riscv_pmu_sbi: add support for PMU
 variant on T-Head C9xx cores
References: <20220905141644.2468891-1-heiko@sntech.de>
X-Yow:  Everybody gets free BORSCHT!
Date:   Mon, 05 Sep 2022 16:30:48 +0200
In-Reply-To: <20220905141644.2468891-1-heiko@sntech.de> (Heiko Stuebner's
        message of "Mon, 5 Sep 2022 16:16:44 +0200")
Message-ID: <mvm4jxlao6f.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 05 2022, Heiko Stuebner wrote:

> To work properly, this requires a matching change in SBI, though the actual
> interface between kernel and SBI does not change.

What happens if you mix different kernel and SBI versions?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
