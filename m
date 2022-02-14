Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D44B52CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354928AbiBNOHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:07:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354902AbiBNOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:06:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF134A3F6;
        Mon, 14 Feb 2022 06:06:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 350CFB80F52;
        Mon, 14 Feb 2022 14:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72E6C340E9;
        Mon, 14 Feb 2022 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644847604;
        bh=Vvz60zKw0g2+pSSh4OwltBc+hmCFRpz9oaWEv4NziB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBa9WXnBKGsrm9yG/bdHcuUXPRcFS3P/2LpN1IRCIH0ZR4qa0NTLAIFfNkWOoB5M5
         HdUy/7PhKRAmm64xdXJo5OcIR/cTe4GvhJ9ERWr4VsMoeMc/dwoKyJG6vAP0snXKwq
         saLyKWv8nSm72rXmQGOPOt6qDhfALWRzALk36EkSz4I5l2ftqFAIJ0yBw0jQSnqloq
         6QH+0uuuBxaB3vxiOFz0vJ+Zy0J0+aAnJxNed8sEf7F1PNylN3q/ESQR1AsqGMRMT7
         KojAB/CfBtmXppGMp4OMm0Gsnkm0PfXKVqCiisSLCl809dXXiaDXET2oGRirJLVtgP
         Ycr8gGifh+SqA==
Received: by pali.im (Postfix)
        id 11EBACAA; Mon, 14 Feb 2022 15:06:42 +0100 (CET)
Date:   Mon, 14 Feb 2022 15:06:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Pali =?utf-8?B?Um9ow6E=?= =?utf-8?Q?r?=
 as mvebu-uart.c maintainer
Message-ID: <20220214140641.v2wlfr43lqgxvw7e@pali>
References: <20220214124808.31971-1-pali@kernel.org>
 <YgpVaR421wQYx9mt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgpVaR421wQYx9mt@kroah.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 February 2022 14:13:13 Greg Kroah-Hartman wrote:
> On Mon, Feb 14, 2022 at 01:48:08PM +0100, Pali Rohár wrote:
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> I can not take patches without any changelog text, sorry.

Well, I'm the only one who has been working on this driver recently and
I have development boards with this UART HW.
