Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BBD4DB229
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354020AbiCPOJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiCPOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259AA3C490
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B55B761209
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F6EC340E9;
        Wed, 16 Mar 2022 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647439704;
        bh=bTEAVJzNEOhI/lKmrR9+/svr6T+tjoocmNyfraD9/PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1yWEwnlFH9tmeVTqd6TZBfZ1MWs508WLTvjXcidNx2MtgliNe3BaY+owDlxLfYke
         nlw+vGKNgkCtwnxIYzZOm24cpf2hJNJCNGk1A7UNWGyzmiYZ+5kYmugCiBPAsquuf4
         sdmKn4DdZCk3RROL2vmCS+fgwUV5HOOfWVddMKYA=
Date:   Wed, 16 Mar 2022 15:08:20 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     "dan.carpenter" <dan.carpenter@oracle.com>,
        nsaenz <nsaenz@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-staging <linux-staging@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: mmal-vchiq: add a check for the return of
 vmalloc()
Message-ID: <YjHvVM3kug3ritca@kroah.com>
References: <tencent_7F2A8AAFF05125C6FF159033E69B5C108E07@qq.com>
 <YjCwagaijyA2oO8r@kroah.com>
 <tencent_84264ACEFF062098CC35B9C01C7A1464E108@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_84264ACEFF062098CC35B9C01C7A1464E108@qq.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:23:05AM +0800, Xiaoke Wang wrote:
> On Tue, 15 Mar 2022 16:27:38 +0100, Greg KH wrote:
> &gt; Your change just crashed the kernel :(
> &gt;
> &gt; Please be more careful
> 
> I am sorry. I ever been told that vfree(NULL) or kfree(NULL) is safe,

Sorry, you are right, I was thinking that there would be an error value
there.  My mistake.

greg k-h
