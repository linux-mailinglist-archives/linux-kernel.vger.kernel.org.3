Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954FC4D8774
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiCNOy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiCNOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:54:25 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9840825C5C;
        Mon, 14 Mar 2022 07:53:14 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nTm4N-0006nG-00; Mon, 14 Mar 2022 15:53:11 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7F643C2E2F; Mon, 14 Mar 2022 15:50:49 +0100 (CET)
Date:   Mon, 14 Mar 2022 15:50:49 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MIPS: Clean up device_tree_init()
Message-ID: <20220314145049.GA13438@alpha.franken.de>
References: <1646895012-3143-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646895012-3143-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 02:50:09PM +0800, Tiezhu Yang wrote:
> Tiezhu Yang (3):
>   MIPS: Remove redundant check in device_tree_init()
>   MIPS: Remove redundant definitions of device_tree_init()
>   MIPS: Fix wrong comments in asm/prom.h
> 
>  arch/mips/ath79/setup.c          |  5 -----
>  arch/mips/include/asm/prom.h     |  4 ++--
>  arch/mips/kernel/prom.c          |  5 +++++
>  arch/mips/lantiq/prom.c          |  5 -----
>  arch/mips/loongson64/setup.c     |  8 --------
>  arch/mips/mti-malta/Makefile     |  1 -
>  arch/mips/mti-malta/malta-dt.c   | 15 ---------------
>  arch/mips/pic32/pic32mzda/init.c |  8 --------
>  arch/mips/ralink/of.c            |  5 -----
>  9 files changed, 7 insertions(+), 49 deletions(-)
>  delete mode 100644 arch/mips/mti-malta/malta-dt.c

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
