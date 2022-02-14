Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417954B4554
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbiBNJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:14:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbiBNJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:14:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6567560078;
        Mon, 14 Feb 2022 01:14:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21CEFB80D8E;
        Mon, 14 Feb 2022 09:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4442C340E9;
        Mon, 14 Feb 2022 09:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644830074;
        bh=E+QOro8f3+YytQ8VYk/ygx78L4mVnH+y/kMzcrkKHLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zeL0+BTKNdOhpH5TK+f7US/o0tKhISI01kL/yd7RJbiRz/RGsn5Vcm+ZBweoYMYZg
         Bst25yc0kUjKHahDoI2lcljg7e+WdNYqQnz3euShMI6NYZ3uhGiVFymhNZ/DYE/BWI
         FQZ6eK1GdU5lyAhFGfsCaKYBXwE4ZpK/50/mhvZA=
Date:   Mon, 14 Feb 2022 10:14:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH v1 1/2] usb: host: ehci-sunplus: Add driver for ehci in
 Sunplus SP7021
Message-ID: <Ygodd+TFQGnhki6A@kroah.com>
References: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
 <1644827562-17244-2-git-send-email-vincent.sunplus@gmail.com>
 <YgoVBv/z1uCsR1Y0@kroah.com>
 <CAPvp3Rhtb-g1A5FG6_1irzX2fG-VACU3T4tST1Xo99cnnL==MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPvp3Rhtb-g1A5FG6_1irzX2fG-VACU3T4tST1Xo99cnnL==MQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 05:03:00PM +0800, 施錕鴻 wrote:
> Hi, Greg
>     About this issue, my colleague Hammer Hsieh has explained it to
> you recently in the mail of "[PATCH v7 2/2] serial: sunplus-uart: Add
> Sunplus
> SoC UART Driver". The ehci driver and uart one are in the same Sunplus Soc.

I do not know what you are referring to, sorry.  Remember we get
thousands of emails a week.

Please be explicit and make the code work properly for each patch you
submit.

thanks,

greg k-h
