Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779474F087C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355820AbiDCIwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 04:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiDCIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 04:52:43 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CDDB7C2;
        Sun,  3 Apr 2022 01:50:47 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru B6B542093D12
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] usb: Prepare cleanup of powerpc's asm/prom.h
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <d9193539d7d079d70fc3480afb1b413f4694ddd1.1648833420.git.christophe.leroy@csgroup.eu>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <86bf7aa0-cfcd-33f3-30c5-a944883325b3@omp.ru>
Date:   Sun, 3 Apr 2022 11:50:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d9193539d7d079d70fc3480afb1b413f4694ddd1.1648833420.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 4/2/22 1:21 PM, Christophe Leroy wrote:

> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h

   I'm not seeing any headers added in this patch?

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/usb/core/hcd-pci.c     | 1 -
>  drivers/usb/host/ohci-ppc-of.c | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 8176bc81a635..f192925f74f7 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -15,7 +15,6 @@
>  #ifdef CONFIG_PPC_PMAC
>  #include <asm/machdep.h>
>  #include <asm/pmac_feature.h>
> -#include <asm/prom.h>
>  #endif
>  
>  #include "usb.h"
> diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
> index 45f7cceb6df3..1960b8dfdba5 100644
> --- a/drivers/usb/host/ohci-ppc-of.c
> +++ b/drivers/usb/host/ohci-ppc-of.c
> @@ -19,9 +19,6 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  
> -#include <asm/prom.h>
> -
> -
>  static int
>  ohci_ppc_of_start(struct usb_hcd *hcd)
>  {

MBR, Sergey
