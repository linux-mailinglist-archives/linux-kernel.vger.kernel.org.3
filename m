Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D13563CDA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiGAXoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGAXoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:44:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4F34672;
        Fri,  1 Jul 2022 16:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mez9F7tccYkohKQuva3nCM30jzyfldCTbq2ekG07rFg=; b=CrPO9pEnphkoLCBCUxnyjkpl4i
        zxYpZxzkBnJSaZ6hPUCtJzvpkj9li6qoH36eedj66e/6cS3Je0+hVCeZ3o5OnHZ/JmzIDhDaxRnHz
        MC1VpjdD0gg6CKk6Kk0/sMxBVcgHCkeFb95PyvoktQlavZAHDeTaMraoyOv30+SfJfWLkbqowDiP8
        e+qw861Igi8clAC1uXDYpduPefcZl78o7Bn/jAjVOsFY7MrxrGRp4I3ZW3Qbd7BZVHaVcTeMUyhLH
        L94Xqz1Z/ZrR7+BoxXYenBcBT+gj/xdj7yDX9vbLGbRLhDoKEaMD/EnnQy40cyav6I68jUsddmaD3
        soqRiKUA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7QIw-007RFB-3M; Fri, 01 Jul 2022 23:44:06 +0000
Message-ID: <d4871bfa-f55a-cc77-b3b3-6cf4cb1349ca@infradead.org>
Date:   Fri, 1 Jul 2022 16:44:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] treewide: fix "interruptible" misspellings
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Colin Ian King <colin.king@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220701231737.2474950-1-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220701231737.2474950-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/1/22 16:17, Kees Cook wrote:
> A common misspelling of "interruptible" is "interruptable". This fixes
> them in the tree and adds the most common variation to spelling.txt.
> Note that "uninterruptable" was already in spelling.txt.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Colin Ian King <colin.king@intel.com>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/admin-guide/sysrq.rst                  |  2 +-
>  Documentation/hid/hiddev.rst                         |  2 +-
>  Documentation/scsi/ChangeLog.lpfc                    |  2 +-
>  drivers/firmware/qcom_scm-legacy.c                   |  2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c       |  2 +-
>  drivers/gpu/drm/msm/msm_gem_submit.c                 |  2 +-
>  drivers/gpu/drm/radeon/radeon_fence.c                | 12 ++++++------
>  drivers/input/serio/hil_mlc.c                        |  2 +-
>  drivers/net/ethernet/amd/nmclan_cs.c                 |  4 ++--
>  .../ethernet/chelsio/inline_crypto/chtls/chtls_cm.h  |  4 ++--
>  drivers/scsi/aacraid/commsup.c                       |  2 +-
>  drivers/tee/optee/supp.c                             | 10 +++++-----
>  drivers/tty/serial/mux.c                             |  2 +-
>  fs/ecryptfs/miscdev.c                                |  2 +-
>  scripts/spelling.txt                                 |  1 +
>  sound/soc/intel/atom/sst/sst_pvt.c                   |  2 +-
>  16 files changed, 27 insertions(+), 26 deletions(-)
> 

-- 
~Randy
