Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA759BF78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiHVM0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiHVM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648252AC5C;
        Mon, 22 Aug 2022 05:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F396C60F54;
        Mon, 22 Aug 2022 12:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B52BC433C1;
        Mon, 22 Aug 2022 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661171170;
        bh=Ri26gF7yUd8i7s+mQIJeKN0Kh94Q0DOYvnDj0MwMB8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAOxOBHt69sGX5JQD1T0NjIlmtUrNXlGSCRAojbKOaA7EpFG3usQHgel8QMAC5DCf
         mzNz3/0K/DuVzM4WamZlM8dcgFmBJry+f7TkC6l9KmaVo8GzecocxUm3Z4tuKk9pCX
         vmNrS/Lg0P7wL3xjGdc75BobaWUPZcKCpqloCKiUQv/roAFh3K2d7+2/OEZc35gX+h
         I76tvEbj3O+PqrGbe+uzK2+Drxj0PmUx/PuceR5S87528zSjenUprWKtGoVRmLERaU
         JGi1MtLPe8TFlQnud4BS2/uG6H+4rIclW+epgTFJ9vXOiHKDGOdyR7/DFQTiw6ERDU
         UkWZR71YBoTaQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ6VL-0001bH-5z; Mon, 22 Aug 2022 14:26:07 +0200
Date:   Mon, 22 Aug 2022 14:26:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?5peg5ZCN?= <yuanjilin@cdjrlc.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb/serial: fix repeated words in comments
Message-ID: <YwN138qeP74YZ9Em@hovoldconsulting.com>
References: <20220821153441.6165-1-yuanjilin@cdjrlc.com>
 <tencent_1AC094251C7AD08A5B832814@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_1AC094251C7AD08A5B832814@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 07:47:39PM +0800, 无名 wrote:
> Replace 'mode' with 'or'

This is not a proper commit message as it only says what you do, not
why. Try to spell it out.

> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com&gt;
> ---

Missing changelog here.

> &nbsp;drivers/usb/serial/mct_u232.h | 4 ++--
> &nbsp;1 file changed, 2 insertions(+), 2 deletions(-)

This patch is corrupt and looks like it was sent as HTML too.

Also look at the git log for this file and use the common Subject
prefix.

It's also customary to CC people that have helped review your patch.

Johan
