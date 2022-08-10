Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BCA58EAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiHJKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiHJKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC180507;
        Wed, 10 Aug 2022 03:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A2E9B81A71;
        Wed, 10 Aug 2022 10:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5B2C433D6;
        Wed, 10 Aug 2022 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660128180;
        bh=VIHJef5BKW47Clj1CM0k5ScxMQqWvRhyfTpzQ0wyG2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pK2Y48PBsmUK00P3zMdkhQVw2qw0SrdxhdAdbhllc6nxiSR5O99FEL/xORchJ8OqL
         Vl5MamvVbi3Ea21iJxBznalB04/vOBmUzF5g99efCr7sOn0GpDsq1VXPJ9prAundca
         Qo0fY4D+68HeFXj9g09N4p0V8oMF7Iuhftkgiraw=
Date:   Wed, 10 Aug 2022 12:42:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: usbtest: Fix typo in comments
Message-ID: <YvOLsmget0hO9MsT@kroah.com>
References: <20220810103000.8721-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810103000.8721-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 06:30:00AM -0400, shaomin Deng wrote:
> Delete the rebundant word "with" in comments.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>

Is your name written on documents as "shaomin Deng" or "Shaomin Deng"?
Please use the correct one if at all possible.

thanks,

greg k-h
