Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE364BDFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380716AbiBUQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:38:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353674AbiBUQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:38:39 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35BDF21E1B;
        Mon, 21 Feb 2022 08:38:16 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7566E92009C; Mon, 21 Feb 2022 17:38:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6E34892009B;
        Mon, 21 Feb 2022 16:38:15 +0000 (GMT)
Date:   Mon, 21 Feb 2022 16:38:15 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [RFC PATCH 0/3] MIPS: Chaos of barrier misuses
In-Reply-To: <20220221145531.10479-1-jiaxun.yang@flygoat.com>
Message-ID: <alpine.DEB.2.21.2202211602080.56785@angie.orcam.me.uk>
References: <20220221145531.10479-1-jiaxun.yang@flygoat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022, Jiaxun Yang wrote:

> This series clears the chaos of barrier misuse.
> In prepration of light weight barrier series.

 What problem are you trying to solve here?

 The MIPS port currently implements the semantics documented in
Documentation/memory-barriers.txt, in particular the "KERNEL I/O BARRIER 
EFFECTS" section, with extra I/O barriers borrowed from the PowerPC port 
for consistency for platform use, due to the weakly ordered architectural 
MMIO model (implementations are allowed to have a stronger model in place 
of course, and you are free to optimise for them with the respective 
configurations).

 Stating that we have a "chaos of barrier misuse" doesn't say anything 
really in my opinion and isn't particularly constructive either.  This 
area is very fragile and you need to understand all the consequences when 
trying to make any changes here and show it with your submission, that is 
properly describe and justify your changes so that people are convinced 
your changes are correct and good to make.

  Maciej

