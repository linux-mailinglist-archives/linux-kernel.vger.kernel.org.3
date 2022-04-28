Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46C1512B95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiD1Ge5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiD1Ge4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:34:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02A1CFE5;
        Wed, 27 Apr 2022 23:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC7F61D3C;
        Thu, 28 Apr 2022 06:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F207AC385A9;
        Thu, 28 Apr 2022 06:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651127501;
        bh=JMr9PTcjMxeBEFB8nzwYTd7Bd4VsMMN0rxZhIErp5jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jq0ERMh1ye7q8VfsUlAeptXViglPHOUdA9EomXhhL5WR5jo9+dWE75LnZxZFQ9T6W
         fag6okPPufRMPP+2WVOEwBLY9D1vdptX0WG5QBi6glitMc/ZJdOl6/23W6kg5wFvZf
         YQ5HnL/CzfUZrHdrQO4p7JP95ncu/niQBZm+JZ5M=
Date:   Thu, 28 Apr 2022 08:31:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     surong pang <surong.pang@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        mathias.nyman@intel.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Orson.Zhai@unisoc.com,
        yunguo.wu@unisoc.com
Subject: Re: [PATCH V2] usb/host: Let usb phy shutdown later
Message-ID: <Ymo0ydI2jvd10J4n@kroah.com>
References: <e05ec742-c3dc-df7c-c5d7-29358d0a7081@linux.intel.com>
 <20220424015757.21993-1-surong.pang@gmail.com>
 <YmfdN97xtmwSOo59@kroah.com>
 <CAEDbmAQmYQdMNY8sANnSuauBcsemrV1MFR3bB83JJ7cHNdWGmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEDbmAQmYQdMNY8sANnSuauBcsemrV1MFR3bB83JJ7cHNdWGmA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Apr 28, 2022 at 02:26:27PM +0800, surong pang wrote:
> Dear Greg,
> No,  It's just a patch to call usb_phy_shutdown later.

I do not understand this response, sorry, as I have no context here.

Also, please fix your email client to not send html email, the mailing
lists reject mail written that way.

thanks,

greg k-h
