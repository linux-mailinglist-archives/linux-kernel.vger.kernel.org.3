Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4127D4E4D40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbiCWHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbiCWHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:22:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E7472E3B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4DA3B81DCA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57B3C340E8;
        Wed, 23 Mar 2022 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648020069;
        bh=sYxSu5/bfDXj7FsvWXtBf/8EP6Ot0zMAJbThntnZjws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfDdcm/9czplooPicGjuLCFqRFOT82mWF49r50nnpzQfRJL5fuyHuJzcAsrAX7BeT
         2aN/eiQ0E1FcHq/B31mKnwxFFTOFRHRs22s8s14rVUDaw0kyvffCGvBuA/CAA1vBZI
         yDwc7GZ1GgerN4Da7q7nlTZovEUqA4u7buf2u2JM=
Date:   Wed, 23 Mar 2022 08:21:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Won Chung <wonchung@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] driver core: Add sysfs support for physical location
 of a device
Message-ID: <YjrKYcta2SUjn3Pk@kroah.com>
References: <20220314195458.271430-1-wonchung@google.com>
 <CAOvb9yguWiJgeYBb1eTnAUpNQ-f5f-tQDnDNw+XzBXRx0H156g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvb9yguWiJgeYBb1eTnAUpNQ-f5f-tQDnDNw+XzBXRx0H156g@mail.gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:36:02AM -0700, Won Chung wrote:
> On Mon, Mar 14, 2022 at 12:55 PM Won Chung <wonchung@google.com> wrote:
> I am sorry to keep bothering you with this, but can you take a look at
> this patch for a review when you have time? Thank you very much!

It is the middle of the merge window now, and I will look at this after
5.18-rc1 is out.  Due to all of the constant churn in this (and you only
fixing the memory leak in the last submission), I had put this on the
bottom of my review queue.

Also, I don't see an actual user of these new attributes anywhere, so
even if this was accepted, who is going to use it?

thanks,

greg k-h
