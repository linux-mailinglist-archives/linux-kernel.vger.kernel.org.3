Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483CD4BA449
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiBQPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:24:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242417AbiBQPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:24:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF252B048B;
        Thu, 17 Feb 2022 07:24:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE45461E95;
        Thu, 17 Feb 2022 15:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD09C340E8;
        Thu, 17 Feb 2022 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645111457;
        bh=FBqwSWBXUXomjXzUKJZlVmUAZw3lBOhKHlaoNTeSfm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZCZUhRRU/AJWb01q+xecMAm9xmz1yzYvju9J4z3GgwqWrxIPDVtlfALC2b5Ji2QK
         4eptDuQsFf91TeGYE+AeRx5Jm2iiS2emQUt9eXJkxbj2kJZWyVA3JKtumlTq/rGLS+
         YBTvDVSSn2u0aps7COr3zprorgYK/27YmjiKvqKs=
Date:   Thu, 17 Feb 2022 16:24:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Leng <3090101217@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>, ruslan.bilovol@gmail.com,
        jbrunet@baylibre.com, pavel.hofman@ivitera.com, pawell@cadence.com,
        jackp@codeaurora.org, balbi@kernel.org, colin.king@intel.com
Subject: Re: [PATCH v3] usb: gadget: f_uac2: fix superspeed transfer
Message-ID: <Yg5onoldRY3ygW7v@kroah.com>
References: <YgpruynyO1AJr7bn@kroah.com>
 <20220217055503.8057-1-3090101217@zju.edu.cn>
 <258cfffe.b20d3.17f064d6977.Coremail.3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258cfffe.b20d3.17f064d6977.Coremail.3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 02:10:10PM +0800, Jing Leng wrote:
> Hi Greg KH,
> 
> 1. Old version kernel can support superspeed transfer, the problem
> was introduced by the following modification:
>  commit eaf6cbe0992052a46d93047dc122fad5126aa3bd
>  Author: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>  Date:   Mon Jul 12 14:55:28 2021 +0200
>  
>      usb: gadget: f_uac2: add volume and mute support

Then put this as a Fixes: tag in the changelog text like the
documentation asks to.

thanks,

greg k-h
