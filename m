Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49450B2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445491AbiDVIdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445358AbiDVIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:33:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116F43ACA;
        Fri, 22 Apr 2022 01:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58435B82AF4;
        Fri, 22 Apr 2022 08:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB77C385AA;
        Fri, 22 Apr 2022 08:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650616248;
        bh=v3qc3Jp8/D1KnStL7QppBc+djqqkmTre4elQmmoX9dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wG8Tp+cMXh78xXaf5MC4tyFse6a+IKwY/1RwifYCWRmxv9nFiASkHaBkA/VGFEio9
         8gxfJgdvvxwLQ36q3hxwXK5RzMpNsYBbF8nM0fBNGoiTbpT5bL2D2MGYCKaP7hZ3nQ
         WYjtkoW6H0+g2w/lUTy1LpUrZmUvGoDbxaotgh9Q=
Date:   Fri, 22 Apr 2022 10:30:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     hminas@synopsys.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, paul@crapouillou.net,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: Re: [PATCH v4 0/3] Add OTG support for Ingenic SoCs.
Message-ID: <YmJntZ7RYpPVaxhm@kroah.com>
References: <1650561308-54704-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1650561308-54704-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:15:05AM +0800, 周琰杰 (Zhou Yanjie) wrote:
> 1.Add OTG support for the JZ4775 SoC, the JZ4780 SoC, the X1000
>   SoC, the X1600 SoC, the X1830 SoC, and the X2000 SoC.
> 2.Introduce support for disable Ingenic overcurrent detection,
>   once selected it enables GOTGCTL register bits VbvalidOvEn
>   and VbvalidOvVal to disable the VBUS overcurrent detection.
> 
> v1->v2:
> 1.Add Rob Herring's Acked-by.
> 2.Add Minas Harutyunyan's Acked-by.
> 3.Use "activate_ingenic_overcurrent_detection" instead
>   "deactivate_ingenic_overcurrent_detection" as Greg's suggestion.
> 
> v2->v3:
> Refresh USB nodes in device tree files, remove "snps,dwc2" since
> it is nolonger needed.
> 
> v3->v4:
> Remove the compatible string of X1700 since it could use the X1600
> string　as the fallback.

I already applied v3, so can you just provide a fixup patch for the
difference between v3 and v4?

thanks,

greg k-h
