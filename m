Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8734EB9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242684AbiC3FEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiC3FEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:04:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E826C6819;
        Tue, 29 Mar 2022 22:02:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADC4867373; Wed, 30 Mar 2022 07:02:23 +0200 (CEST)
Date:   Wed, 30 Mar 2022 07:02:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop: fix ioctl calls using compat_loop_info
Message-ID: <20220330050223.GA24395@lst.de>
References: <20220329201815.1347500-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329201815.1347500-1-cmllamas@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 08:18:15PM +0000, Carlos Llamas wrote:
> Support for cryptoloop was deleted in commit 47e9624616c8 ("block:
> remove support for cryptoloop and the xor transfer"), making the usage
> of loop_info->lo_encrypt_type obsolete. However, this member was also
> removed from the compat_loop_info definition and this breaks userspace
> ioctl calls for 32-bit binaries and CONFIG_COMPAT=y.
> 
> This patch restores the compat_loop_info->lo_encrypt_type member and
> marks it obsolete as well as in the uapi header definitions.
> 
> Fixes: 47e9624616c8 ("block: remove support for cryptoloop and the xor transfer")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Ooops.  The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
