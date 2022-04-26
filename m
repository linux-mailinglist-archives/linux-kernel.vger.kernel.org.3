Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECA51027C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352759AbiDZQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352776AbiDZQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:04:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD6093A5CF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:01:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4F0023A;
        Tue, 26 Apr 2022 09:01:30 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AD663F73B;
        Tue, 26 Apr 2022 09:01:29 -0700 (PDT)
Date:   Tue, 26 Apr 2022 17:01:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH 0/8] stackleak: fixes and rework
Message-ID: <YmgXVwaYQ1Kn5+b0@lakrids>
References: <20220425115603.781311-1-mark.rutland@arm.com>
 <202204251551.0CFE01DF4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204251551.0CFE01DF4@keescook>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:54:00PM -0700, Kees Cook wrote:
> On Mon, Apr 25, 2022 at 12:55:55PM +0100, Mark Rutland wrote:
> > This series reworks the stackleak code. The first patch fixes some
> > latent issues on arm64, and the subsequent patches improve the code to
> > improve clarity and permit better code generation.
> 
> This looks nice; thanks! I'll put this through build testing and get it
> applied shortly...

FWIW, looking at testing I've spotted a fencepost error, so I'll spin a
v2 with that fixed (and with updates to the LKDTM test).

Thanks,
Mark.
