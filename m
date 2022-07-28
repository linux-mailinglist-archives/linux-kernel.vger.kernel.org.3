Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68F7583A84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiG1Iow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiG1Iou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:44:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B450198
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E247B8234E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC9C433C1;
        Thu, 28 Jul 2022 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658997885;
        bh=kjXvoyrVFqKMyp7gDe2PYIdDOYJl8LQrhNsJ/qwi1MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bn1arOhX5Vh1zIiaStd7UHo9M1Dfp/uNmTh/2atMFY9R2AbHfSVYlbo46Ed6xz8T5
         EfbkjqAiNI/CWBO5NZlfigcRtXfeQSPzVDwyW4tNi5teEBBHvdHOOJpnKPdZfQ3B1b
         DHIEFeQ+wqhL037uDLMVbp4a3YUbrdevGaRMzV7U=
Date:   Thu, 28 Jul 2022 10:44:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rajesh jalisatgi <rajeshjalisatgi@gmail.com>
Cc:     Vishnu Dasa <vdasa@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Message-ID: <YuJMe6WD1eeU2jyW@kroah.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
 <Yt7bfyANrfdPxdS8@kroah.com>
 <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
 <YuAD90UfLnf1Ojso@kroah.com>
 <47D07B41-C327-4908-A383-683FC6C67040@vmware.com>
 <CAJ60do+Lgnx6gfHncckF-=8F=zzn81tCiFNLOmg_8TyuLGUotw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ60do+Lgnx6gfHncckF-=8F=zzn81tCiFNLOmg_8TyuLGUotw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 09:35:54AM -0700, rajesh jalisatgi wrote:

<snip>

This message never made it to any public list as it was sent in HTML
format.  Please resend in a way we can properly access it.

thanks,

greg k-h
