Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7F4D5A06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbiCKEuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346517AbiCKEud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:50:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A1EF0A9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:49:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE64617B5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85350C340EC;
        Fri, 11 Mar 2022 04:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646974158;
        bh=ieKn790GjrKSPuQn2caaZWrzBmooKYSB6PRk5jmqHFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RiCFEZwBuQmmlgqHA+kqM/K6eJdBD9xlftp7cCJ5OGOGTeIyz87Fuq0iGjyKcsQBL
         vBl7/JIVlxHBbL5/2DwFurRmzUKDbDDJDSAgMikQ8N1XkICyckwdAugEPNVo1fpCdR
         wy5s2Gdn/tqDbRW9VclshFIYtN0XHH7w6epPguo8=
Date:   Thu, 10 Mar 2022 20:49:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 00/14] Convert powerpc to default topdown mmap layout
 (v8)
Message-Id: <20220310204917.3d42e6cf3088f7cf1c7fe7a6@linux-foundation.org>
In-Reply-To: <877d91m7wd.fsf@mpe.ellerman.id.au>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
        <ddfed61b-e387-4554-eb88-6654b391d1a4@csgroup.eu>
        <877d91m7wd.fsf@mpe.ellerman.id.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 15:26:42 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:

> > What will be the merge strategy ? I guess it's a bit late to get it 
> > through powerpc tree, so I was just wondering whether we could get 
> > patches 2 to 5 in mm this cycle, and the powerpc ones next cycle ?
> 
> Yeah I didn't pick it up because the mm changes don't have many acks and
> I'm always nervous about carrying generic mm changes.
> 
> It would be my preference if Andrew could take 2-5 through mm for v5.18,
> but it is quite late, so I'm not sure how he will feel about that.

5.18 isn't a problem.  Perhaps you meant 5.17, which would be real tough.

Can we take a look after 5.18-rc1?
