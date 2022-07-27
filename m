Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB32582063
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiG0Go5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiG0GoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC4419AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 193F56148C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0543C43142;
        Wed, 27 Jul 2022 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658904230;
        bh=IJf4TgefHFadagzVeTqif8QAQCz24R5RnXBmjOKxUSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RP4nLawu1SjE42GGT2T0CYiFNI88lBUX+ScZxBWJLO0PNbKOfC4o0ofueHOXdOTl5
         8c5lzI5TuuwAhRJWVVM2MYUihNNGv8P93IJqNjTWtSsSpAi/WQp+a+MzOorFpTOytp
         Vhtrpy96W+KoGCIwIMrKQN7K4LV/aZ5mrlap3+cw=
Date:   Wed, 27 Jul 2022 08:43:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: r8188eu: get da from ieee80211_mgmt
Message-ID: <YuDeo4qHOqDkdZy9@kroah.com>
References: <20220724153917.138848-1-martin@kaiser.cx>
 <20220724153917.138848-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724153917.138848-2-martin@kaiser.cx>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 05:39:13PM +0200, Martin Kaiser wrote:
> Define a struct ieee80211_mgmt in the OnAssocRsp function. Read the
> destination address (da) from this struct.

This explains (sortta) what this patch does, but not why you are doing
this.

To me this looks like a step backwards, why is this change needed at
all?

thanks,

greg k-h
