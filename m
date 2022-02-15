Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423284B73A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiBOPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:11:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiBOPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:11:45 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A98F5DF9A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:11:32 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nJzUH-0001XZ-00; Tue, 15 Feb 2022 16:11:29 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B0FB9C24F4; Tue, 15 Feb 2022 16:03:00 +0100 (CET)
Date:   Tue, 15 Feb 2022 16:03:00 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <20220215150300.GA23034@alpha.franken.de>
References: <202202130432.4tPqXRgn-lkp@intel.com>
 <20220214080429.GA18136@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214080429.GA18136@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 09:04:29AM +0100, Christoph Hellwig wrote:
> Thomas, can you find someone who cares about the sibyte support to
> fix up the address space annotations in this code?

I'll have a look.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
