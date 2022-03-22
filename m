Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738934E3C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiCVK1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiCVK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:27:01 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F920F50;
        Tue, 22 Mar 2022 03:25:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nWbhj-0002lV-KV; Tue, 22 Mar 2022 11:25:31 +0100
Date:   Tue, 22 Mar 2022 11:25:31 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        kernel@openvz.org
Subject: Re: [PATCH v2] memcg: enable accounting for nft objects
Message-ID: <20220322102531.GC24574@breakpoint.cc>
References: <20220228122429.GC26547@breakpoint.cc>
 <f359be78-c95d-555a-67ec-f665f90e93b8@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f359be78-c95d-555a-67ec-f665f90e93b8@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vasily.averin@linux.dev> wrote:
> nftables replaces iptables, but it lacks memcg accounting.
> 
> This patch account most of the memory allocation associated with nft
> and should protect the host from misusing nft inside a memcg restricted
> container.

LGTM.

Acked-by: Florian Westphal <fw@strlen.de>
