Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E558F9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiHKJFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiHKJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA0312D04;
        Thu, 11 Aug 2022 02:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BEA66157E;
        Thu, 11 Aug 2022 09:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D5BC433C1;
        Thu, 11 Aug 2022 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660208738;
        bh=/SCX/q2vERRxhLWOWxv9LJNngWD3UTfxgX+Yo/rk0Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TLtCoZipxNdBFzl+fE5YQRXPd1j3bqTMa+BfkODu5fe2Od3XzC1IzaAzQ9D7E1xjQ
         UmepeDkm1rlBF26aZPml6MkoDvoRx3IC4icpRxs2BOi4D8at1dMUS5BszxeAopMlKZ
         LkKOPWbscpQF0NkM6qHWdcRtEymJ1XW1BG1nThEw=
Date:   Thu, 11 Aug 2022 11:05:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou jie <zhoujie@nfschina.com>
Cc:     johan@kernel.org, kernel@nfschina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb/serial:Repair function return value
Message-ID: <YvTGXzWtNddHdfsf@kroah.com>
References: <YvS8AK9apa7tnYOz@kroah.com>
 <20220811084237.6651-1-zhoujie@nfschina.com>
 <20220811084237.6651-2-zhoujie@nfschina.com>
 <YvTDCpjrqxxK46Us@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvTDCpjrqxxK46Us@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:51:22AM +0200, Greg KH wrote:
> On Thu, Aug 11, 2022 at 04:42:37PM +0800, Zhou jie wrote:
> > Repair function return value,The previous return value did not work.
> > 
> > v2:
> >   Modifying function return value type does not work.
> 
> Please put this below the --- line as the documentation asks for.

Also, do not cc: email addresses that do not accept external emails,
that just causes bounces for everyone else when they respond to your
email :(

thanks,

greg k-h
