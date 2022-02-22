Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BE4C0550
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiBVXYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiBVXYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:24:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D304295A03;
        Tue, 22 Feb 2022 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=KLbxFu/hMsIEsxiY3WX/nJy2YULpkcfwVlHObJmcgDA=; b=ZAN+7rap+fI9+4YwqL536u7dHt
        v771RDrsQTZR5IBDrptBuO/0dvwVgfxMfr887dUfniBdZ5o+P1HpkapmI4gfiNFL5A1eHieQnKDp0
        Smhf+SVxXbGSHjlsYrfhXQe9zExNRSfN+NchhkIWwaaj2GiHAVx6aKCJi9FO6pVZJmcW0i13wYM+v
        dVzc88H84YPD25/gPQvYtbeFPbS7LXnnFZRCNZqcqE2RRiYA+t3K/NcvhqXIaUQbr1sjKrmx3of+P
        YcYiSFM8TbQisR5C0uLKCOCHvlFEbEXLOTbZxEM46fwHRygpW5zu1rnonCGBc15iWDI3KBxwdrwjp
        YiFidfNQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMeW1-003ERM-GX; Tue, 22 Feb 2022 23:24:17 +0000
Message-ID: <f94fc06e-c0ff-103b-789a-87af52c53e11@infradead.org>
Date:   Tue, 22 Feb 2022 15:24:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: blocksize 4096 even for floppy and CDROM?
Content-Language: en-US
To:     JPT <j-p-t@gmx.net>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <e4ab39cb-fbe7-1148-8d8a-5cd46866159f@gmx.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e4ab39cb-fbe7-1148-8d8a-5cd46866159f@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding the linux-block mailing list]


On 2/22/22 12:08, JPT wrote:
> Hi,
> 
> sorry for bothering. I fear I need help by a block device pro ;)
> 
> I try to read several bad floppies and DVDs using safecopy.
> 
> I wonder why safecopy always says
> Reported hw blocksize: 4096
> Reported low level blocksize: 4096
> 
> even if the medium is floppy (512) or CDROM (2048)
> 
> is this a kernel issue always assuming min 4k block size?
> 
> Does anybody have an idea if there is a Unix out there that doesn't have
> this limitation?
> 
> or which Linux version dropped support for smaller sectors?
> 
> Or is this simply safecopy's fault?
> 
> 
> thank you very much for your help.
> 
> Jan

-- 
~Randy
