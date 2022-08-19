Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C525996D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbiHSINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347517AbiHSINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B025D1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57EC3616EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B148C433C1;
        Fri, 19 Aug 2022 08:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660896813;
        bh=GIl6W2lxa8WtRY1EPibkIaCU0DHIioGipI0m1u+Nhss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFjZSaRfP2oTjxLw7WZApQg+Qk2v6LGfRSorRbmq6xt9jh2EDs7mluh+/D4FgPF6/
         4Dt7b0zX7FYuxumxcE3P8YeUx4FoX1P1dqYHttu+Bk24rVC29eOjOHYapVS4xGcG9r
         mqZsRzKL8gnYTlDIfosmQ/CQU1h58bjlhgqsq6gw=
Date:   Fri, 19 Aug 2022 10:13:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        phil@philpotter.co.uk, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com
Subject: Re: [PATCH] staging: r8188eu: remove unused function declarations
Message-ID: <Yv9GKm11nugjOAW0@kroah.com>
References: <20220819073725.8263-1-namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819073725.8263-1-namcaov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 09:37:26AM +0200, Nam Cao wrote:
> Remove some function declarations because they are neither used nor
> have definitions.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>

One function removal at a time please, break this up into a patch series
to make it obvious what you are doing.

thanks,

greg k-h
