Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD73F4FF034
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiDMG4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiDMG4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:56:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8527FE6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BFE0B82022
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D39C385A4;
        Wed, 13 Apr 2022 06:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649832826;
        bh=0I72LaNEy81sBYN4sBltxcvkm4ZSShxeclxpZ+4r0iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qVO0SpIxtRYnK2KxnSqScWNEnjkYkPfMXlwzV5oQtmHBH1PTvF76qA2JTcYZEWXg
         ISJEkpVcTbyNU7NUgjl3dAOYJztu982VlEEX9Y66UZIRvkQjXOtFosEDFL4WTSS73E
         sAQb9p6x9zPk1N7toJgwuxglvqpkvOERypFwdhxo=
Date:   Wed, 13 Apr 2022 08:53:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] staging: r8188eu: rename parameter of block_write()
Message-ID: <YlZzeEOn6VC4Tmre@kroah.com>
References: <20220412185754.8695-1-straube.linux@gmail.com>
 <20220412185754.8695-3-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412185754.8695-3-straube.linux@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:57:50PM +0200, Michael Straube wrote:
> Rename the parameter buffSize of block_write() to avoid camel case.
> 
> buffSize -> size

How about "buffSize -> buffer_size"?

That makes more sense, right?

thanks,

greg k-h
