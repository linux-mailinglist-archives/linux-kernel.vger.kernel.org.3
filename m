Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE055D245
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiF0KsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiF0KsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582AC6253
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97B86134E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F215CC3411D;
        Mon, 27 Jun 2022 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656326896;
        bh=6YwiWUB4xl60O/EG7C+hAu7k64BcsUbkhf2YOp0uNTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3bvRJy/FqAAgRVAGd9axiCQVEkIdaIM0aJtonpQyyln/nbLtfIs27txHVTWPIxyi
         dE7+oSBlz8Mn89j/eM5khLDB/TmO8AiWW8CBod40G50MIkDdaYDBervqVYe8HSCWHh
         Ai9NBvfdNjco7mmOxmrQk8xQXhM/txrK2Xv74diY=
Date:   Mon, 27 Jun 2022 12:47:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangxi Xiang <xyangxi5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the
 buffer
Message-ID: <YrmKvSFSvPpT7Q3O@kroah.com>
References: <20220627102940.23232-1-xyangxi5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627102940.23232-1-xyangxi5@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 06:29:40PM +0800, Yangxi Xiang wrote:
> A memory overlapping copy occurs when deleting a long line. Fix it by
> using scr_memmovew.
> 
> Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>

What commit does this fix?  how was this tested?

thanks,

greg k-h
