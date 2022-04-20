Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795D6508D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380575AbiDTQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379855AbiDTQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:31:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D34840E7C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BDC2B82043
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F719C385A0;
        Wed, 20 Apr 2022 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650472127;
        bh=1NrwORl7TpAJ23BH9sDvu1Q+P5kuqJUNPzBg+nFEQeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEWj9WpK1NklvjCLRgMxfOYs1q+9GpPzyuvNkoKun3XgUhGWx/s4oOvUa6q2BkaId
         ekFPz1DAg+mTh3SHUFBjXdON9HjfCobQa7CcvtnhinS4gwVWZwgSYa9kGrdu5VDXyy
         Hr0g2TYQW7EecOz8n7PjoMLV+IWq4Ftis6ZTVMVc=
Date:   Wed, 20 Apr 2022 18:28:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     vaibhav.sr@gmail.com, dan.carpenter@oracle.com,
        mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] greybus: audio_codec: initialize data to silence
 static checker warnings
Message-ID: <YmA0vHtvNmv9PNi9@kroah.com>
References: <20220414084219.13501-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414084219.13501-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 04:42:19PM +0800, Xiaomeng Tong wrote:
> These three declares are here:
> 	struct gbaudio_data_connection *data;
> 
> Since all three of these functions check for if the codec->module_list is
> empty at the start of the function so these are not real bugs to bypass
> 'if (!data) {'. To avoid static checker warnings like Smatch, initialize
> the data with NULL.

We do not work around broken tools, we ask that the tools be fixed.

thanks,

greg k-h
