Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAF58F9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiHKJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20F11C0F;
        Thu, 11 Aug 2022 02:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1D4615B8;
        Thu, 11 Aug 2022 09:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B494C433D6;
        Thu, 11 Aug 2022 09:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660209127;
        bh=TiiyYRlsZds05edxZzrfUjsJ5IkMPA6XiiaHQ0Nzm1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwrqAwEhiyd031bVDQWmvRR7xqClsVK828Td0UlMcJUj82bsxKTAWjJrRNgo3lvLE
         y1Wc7i8kWy2GhEbWt2XhHXYZl2i/4wVm3xQIZYcGMBVW3fDNhdKaKMChVQhj5RtFRz
         cnLBmQsNdqe6i1RsnsSV7WN+E5mHN83BwV0Misa4=
Date:   Thu, 11 Aug 2022 11:12:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou jie <zhoujie@nfschina.com>
Cc:     johan@kernel.org, kernel@nfschina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb/serial:Repair function return value
Message-ID: <YvTH5LfF4ZZdIjuY@kroah.com>
References: <YvTDCpjrqxxK46Us@kroah.com>
 <20220811090501.6999-1-zhoujie@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811090501.6999-1-zhoujie@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 05:05:00PM +0800, Zhou jie wrote:
> 
> The return value processing has been done in the write_mos_reg() function, no additional operations are required here, just return the result directly.
> Also the indentation of the second line is now incorrect? What's wrong?
> 

I have no context for this email and do not understand it at all, sorry
:(
