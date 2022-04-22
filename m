Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80F250B03B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444220AbiDVGNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444341AbiDVGNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:13:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D844434A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7931B82A81
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C70C385A4;
        Fri, 22 Apr 2022 06:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650607826;
        bh=9TNW3wYfSuM9PlmQpT0Zdgu2dFVulayRiQeg+hNcdms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/M/Zm/veiGwzAWnsYAbWZ3EsXL+XD8/eHzt08OYdJD29uDbKhsYtw+nFcn1MEwcI
         b1gB7rkoz2VswVmnSSnxucsw/DrmoZXjxDvFdTmjNOejpfsCMyULCaPwAAhsE9vUuk
         lCeX8xp9FxfYDOxIDW902QAVIHTwnPo+ucxrHk3o=
Date:   Fri, 22 Apr 2022 08:10:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Message-ID: <YmJGzwA0kD+lFtfN@kroah.com>
References: <20220411102136.14937-1-makvihas@gmail.com>
 <3484215.R56niFO833@leap>
 <20220412151529.GF3293@kadam>
 <3134226.AJdgDx1Vlc@leap>
 <20220413054252.GR12805@kadam>
 <CAH1kMwT0gyQNB1-j62-2ntJD9Lobsmr8-5h6n6-SJ44wykMyHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1kMwT0gyQNB1-j62-2ntJD9Lobsmr8-5h6n6-SJ44wykMyHQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:26:21AM +0530, Vihas Makwana wrote:
> Did this patch series get lost?

What series?  (hint, do not top post).

My queue of staging patches was empty as of a few days ago (it's filled
up since then), so if they were not applied, please resend.

thanks,

greg k-h
