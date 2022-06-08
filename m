Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0719542CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiFHKQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiFHKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:12:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3D5F68;
        Wed,  8 Jun 2022 02:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6700CCE2748;
        Wed,  8 Jun 2022 09:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730E6C3411C;
        Wed,  8 Jun 2022 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654682293;
        bh=FcJ8Di2tEi7J9mL1kUYDLPSlQ/etsnhAYzuqiYLHspg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oLv93pnlM5mEtu4/ho0CsYmNpR45IoFG+CHaYiZnEe9m4CBxPEmqOFnVYN1wqBDEx
         jjCb2oe0VCEO752zZTkl7gSY5ImbSbk14KoQ4YQVkyw8oCLL6is66rwycRV6bjLPFQ
         eHnMG6+t0yArDfiWTGi1kHqGw/XmcOVdGzsiO0TPb+b+/ncL54MqF7htThYUFpl/SC
         JHhrx3l/erbi+nRH6BrmX7nXhhuUju2zCRvgYYtCQy6mLjO+vmNw8eqah70qhheZ8K
         O4LMY6injcdWA15JGvYU5bVxzl7K9M/xU6t2sXg7tueNhL0kgU0KlX7Vr516jzBK7u
         uBKYI0WHx/eIw==
Date:   Wed, 8 Jun 2022 11:58:09 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     linux-doc@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        llvm@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: uclogic: properly format kernel-doc comment for
 hid_dbg() wrappers
In-Reply-To: <20220604020711.252312-1-bagasdotme@gmail.com>
Message-ID: <nycvar.YFH.7.76.2206081157590.10851@cbobk.fhfr.pm>
References: <20220604020711.252312-1-bagasdotme@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2022, Bagas Sanjaya wrote:

> Running kernel-doc script on drivers/hid/hid-uclogic-params.c, it found
> 6 warnings for hid_dbg() wrapper functions below:
> 
> drivers/hid/hid-uclogic-params.c:48: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
> drivers/hid/hid-uclogic-params.c:48: warning: missing initial short description on line:
>  * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
> drivers/hid/hid-uclogic-params.c:48: info: Scanning doc for function Dump
> drivers/hid/hid-uclogic-params.c:80: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Dump tablet interface frame parameters with hid_dbg(), indented with two
> drivers/hid/hid-uclogic-params.c:80: warning: missing initial short description on line:
>  * Dump tablet interface frame parameters with hid_dbg(), indented with two
> drivers/hid/hid-uclogic-params.c:80: info: Scanning doc for function Dump
> drivers/hid/hid-uclogic-params.c:105: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Dump tablet interface parameters with hid_dbg().
> drivers/hid/hid-uclogic-params.c:105: warning: missing initial short description on line:
>  * Dump tablet interface parameters with hid_dbg().
> 
> One of them is reported by kernel test robot.
> 
> Fix these warnings by properly format kernel-doc comment for these
> functions.
> 
> Link: https://lore.kernel.org/linux-doc/202205272033.XFYlYj8k-lkp@intel.com/
> Fixes: a228809fa6f39c ("HID: uclogic: Move param printing to a function")
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: José Expósito <jose.exposito89@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nikolai Kondrashov <spbnick@gmail.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: llvm@lists.linux.dev
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

