Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00434DD8B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiCRLJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbiCRLJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:09:19 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B3160694
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:07:56 -0700 (PDT)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id D99401208D5;
        Fri, 18 Mar 2022 11:07:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 7DE6A2000D;
        Fri, 18 Mar 2022 11:07:53 +0000 (UTC)
Message-ID: <176f485c00e3c6c03ff794dc47f23702fc592a4f.camel@perches.com>
Subject: Re: [PATCH] mm: fix typos in comments
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Richard Henderson <rth@twiddle.net>
Cc:     kernel-janitors@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 18 Mar 2022 04:07:52 -0700
In-Reply-To: <20220318103729.157574-19-Julia.Lawall@inria.fr>
References: <20220318103729.157574-19-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: x7ke1aw8edz91no8i5thucyw4zq3zu8b
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7DE6A2000D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19c3Gj+9w+SnUdOlsv8MpJuj/ml9126C9w=
X-HE-Tag: 1647601673-641712
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-18 at 11:37 +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
[]
> diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
[]
> @@ -148,7 +148,7 @@ eiger_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  
>  	/* The SRM console has already calculated out the IRQ value's for
>  	   option cards. As this works lets just read in the value already
> -	   set and change it to a useable value by Linux.
> +	   set and change it to a usable value by Linux.

generally accepted alternative spelling.

https://www.dictionary.com/browse/useable


