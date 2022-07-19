Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B15792CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiGSFxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiGSFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:52:58 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF539BAA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:52:57 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id DgABomHIq5qT4DgABojGE8; Tue, 19 Jul 2022 07:52:56 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 19 Jul 2022 07:52:56 +0200
X-ME-IP: 90.11.190.129
Message-ID: <d573956a-c257-0bda-b78b-75d8e0a1c982@wanadoo.fr>
Date:   Tue, 19 Jul 2022 07:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] s390/pci: Use the bitmap API to allocate bitmaps
Content-Language: fr
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <8d35e482f710889a45d46f808155738ef87d46c4.1657383052.git.christophe.jaillet@wanadoo.fr>
 <Ys+n+wU8GyQzR+xk@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Ys+n+wU8GyQzR+xk@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/07/2022 à 07:22, Alexander Gordeev a écrit :
> On Sat, Jul 09, 2022 at 06:11:28PM +0200, Christophe JAILLET wrote:
>> I don't know why commit c506fff3d3a8 ("s390/pci: resize iomap") has turned
>> this bitmap from a statically defined bitmap to a runtime-allocated one.
> 
> c506fff3d3a8 commit message:
> 
>      This reduces the size of the iomap from 256K to less than 4K
>      (using the defconfig).
> 

Hi,

IIUC, going from ZPCI_IOMAP_MAX_ENTRIES to ZPCI_IOMAP_ENTRIES reduced 
the size, not going from DECLARE_BITMAP() to kcalloc().

CJ
