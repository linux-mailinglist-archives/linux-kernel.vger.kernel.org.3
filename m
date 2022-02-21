Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFD4BDF63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380890AbiBUQnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:43:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380788AbiBUQnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:43:16 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 380B4220C6;
        Mon, 21 Feb 2022 08:42:53 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 79B1E92009C; Mon, 21 Feb 2022 17:42:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6B0B592009B;
        Mon, 21 Feb 2022 16:42:52 +0000 (GMT)
Date:   Mon, 21 Feb 2022 16:42:52 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org, tsbogend@alpha.franken.de
Subject: Re: [RFC PATCH 2/3] MIPS: io.h use barrier terminology from
 asm-generic
In-Reply-To: <20220221145531.10479-3-jiaxun.yang@flygoat.com>
Message-ID: <alpine.DEB.2.21.2202211628570.56785@angie.orcam.me.uk>
References: <20220221145531.10479-1-jiaxun.yang@flygoat.com> <20220221145531.10479-3-jiaxun.yang@flygoat.com>
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

> So we can share understanding of those barriers with other archs
> and hopefully one day we will be able to switch asm-generic.

 You're mixing the ordering of DMA WRT MMIO here with the ordering of MMIO 
WRT itself, and this single line of justification does not explain why it 
is a change worth making.  You're free to define additional DMA barriers 
if we're missing some.

  Maciej
