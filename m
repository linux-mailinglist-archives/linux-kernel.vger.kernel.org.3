Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331374AC7E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351435AbiBGRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379246AbiBGRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:40:28 -0500
X-Greylist: delayed 76 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 09:40:26 PST
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0302C0401D9;
        Mon,  7 Feb 2022 09:40:26 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nH7yl-0006Gx-03; Mon, 07 Feb 2022 18:39:07 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C3FBDC2116; Mon,  7 Feb 2022 18:36:39 +0100 (CET)
Date:   Mon, 7 Feb 2022 18:36:39 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dragan.mladjenovic@syrmia.com
Subject: Re: [PATCH] mips: Enable KCSAN
Message-ID: <20220207173639.GD16822@alpha.franken.de>
References: <20220131101709.17434-1-nemanja.rakovic@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131101709.17434-1-nemanja.rakovic@syrmia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:17:09AM +0100, Nemanja Rakovic wrote:
> This patch enables KCSAN for the 64-bit version. Updated rules
> for the incompatible compilation units (vdso, boot/compressed).
> 
> Signed-off-by: Nemanja Rakovic <nemanja.rakovic@syrmia.com>
> ---
>  arch/mips/Kconfig                  | 1 +
>  arch/mips/boot/compressed/Makefile | 1 +
>  arch/mips/vdso/Makefile            | 3 +++
>  3 files changed, 5 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
