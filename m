Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE74D877A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbiCNOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiCNOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:54:25 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 981FA255B3;
        Mon, 14 Mar 2022 07:53:14 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nTm4O-0006nG-02; Mon, 14 Mar 2022 15:53:12 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 6D6BDC2E31; Mon, 14 Mar 2022 15:52:34 +0100 (CET)
Date:   Mon, 14 Mar 2022 15:52:34 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: cdmm: Fix refcount leak in mips_cdmm_phys_base
Message-ID: <20220314145234.GE13438@alpha.franken.de>
References: <20220309091711.3850-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309091711.3850-1-linmq006@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:17:10AM +0000, Miaoqian Lin wrote:
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> Fixes: 2121aa3e2312 ("mips: cdmm: Add mti,mips-cdmm dtb node support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/bus/mips_cdmm.c | 1 +
>  1 file changed, 1 insertion(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
