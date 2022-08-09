Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B7B58DB7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbiHIP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244829AbiHIP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:58:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628EF1839A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B86612A5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6BCC433D6;
        Tue,  9 Aug 2022 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660060714;
        bh=BUuiGJQJ+4x9pC3fv3ORCJp3j2Y5CtBRj3fEisBvXrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AniPZ1ZD62FXbF9VXUeajJeBjY3Q+TbRCekB0EVb2T2r97xBGWVQTUZVITZwEl1vj
         XyQadcLce/TZsPLpTNnZV20mu0ha7M+EGEyEvY/UYMpUqIwtk7qa9anRpOfGaviduJ
         b1tGiXdvuN+v3gDiTCbn+SmkE3XofUQXCbuWHPT0=
Date:   Tue, 9 Aug 2022 17:58:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simone Serra <serrazimone@gmail.com>
Cc:     fabioaiuto83@gmail.com, soumya.negi97@gmail.com,
        hdegoede@redhat.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes compilation errors after checkpatch warnings
Message-ID: <YvKEJ+kvcQhRNW7I@kroah.com>
References: <20220809143743.742636-1-serrazimone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809143743.742636-1-serrazimone@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 04:37:43PM +0200, Simone Serra wrote:
> This patch fixes compilation errors produced by the previous commit that resolved a number of checkpatch warnings and errors
> 
> Signed-off-by: Simone Serra <serrazimone@gmail.com>

Sorry, but as you have ignored the previous recommendations on how to
correctly submit patches like this, I'm going to have to reject and
ignore this as well.

best of luck,

greg k-h
