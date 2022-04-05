Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93D94F511F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1844872AbiDFBw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446287AbiDEPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B4276
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF968B81B18
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2232DC385A0;
        Tue,  5 Apr 2022 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649168012;
        bh=J7HCJkshX2Pc5q0J6hzinjXyY0BZxW6N/Kloo4Faflw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q818vD8EN3d0ohROvuHYNbX5wg5mBo3+SNJYfrLXDUMPJEIsF8m6Z2zx0VRl3Ug5j
         WYIHW8s6fVfSYDRGQ+ouV2E9HrcNo8IKE/fDexSNNURqfwv/qdrmSRFUr3CjPPXcHM
         JOoN0gx17uUW/c8jel0J8DCfjezHp/IJnTb94ObA=
Date:   Tue, 5 Apr 2022 16:13:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: r8188eu: drop redundant if check in
 check_fwstate
Message-ID: <YkxOitByai03u8Qc@kroah.com>
References: <20220405124239.3372-1-makvihas@gmail.com>
 <20220405124239.3372-3-makvihas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405124239.3372-3-makvihas@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:12:39PM +0530, Vihas Makwana wrote:
> The if check is redundant. Drop it and simplify the funciton.
> 
> Also, drop clr_fwstate(), clr_fwstate_ex(), up_scanned_network() and
> down_scanned_network() as they are not used anywhere.

When you write "also" in a changelog text, that's a huge hint that you
should break this up into multiple patches.

Remember, do only one logical thing per change.  This should be split up
into 2 patches.

thanks,

greg k-h
