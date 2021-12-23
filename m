Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197C847E93B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350397AbhLWV4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350360AbhLWV4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:56:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F79AC061401;
        Thu, 23 Dec 2021 13:56:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48DDC61DF1;
        Thu, 23 Dec 2021 21:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06346C36AE5;
        Thu, 23 Dec 2021 21:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640296559;
        bh=dr7iVkk0LkwcDcx/bOyQpEUgPSkNDbhiM8ZpQoQDc7U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SiEbRSIjWiVgUYMZWSaX6jGvqtMgeVnC8EWeOotCHKOtmkqiCUTl+M84gYJnbsJjY
         1MXwWdPhmMk+W+207p+H4QMR1aPHemvvuQXIrwWC/7/u/N3xFRiIUBuiEktw7EAKFg
         8h8wALf996Z0MqsdiKNSZLEG0L7qdL6vVQRRUhkS5uOfUH4Mepj1D8xnCuXtdKPglu
         b0MOnqf11OVWqPlMzNc/OXH36DhrX/DKHOWJRNCi/ehMbOziFwJAGBa64eagiCxE6J
         ArmLBgS5XDkC2SUvyM1SP6YZCWxFOHx5vDgpJ9chKY4icVB5/NQ/aunGo6RS7oc6m/
         rnvd8MKduyB8g==
Subject: Re: linux-next: manual merge of the nand tree with the drivers-memory
 tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211223104704.35fa3a41@canb.auug.org.au>
 <ce08a9b7-4fc5-2cc7-2a5a-dbab6eabea14@canonical.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <e189f3c2-7b3d-39d6-6717-ad6558638a1b@kernel.org>
Date:   Thu, 23 Dec 2021 23:55:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ce08a9b7-4fc5-2cc7-2a5a-dbab6eabea14@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/12/2021 23:17, Krzysztof Kozlowski wrote:
> On 23/12/2021 00:47, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the nand tree got a conflict in:
>>
>>   drivers/mtd/nand/raw/omap2.c
>>
>> between commit:
>>
>>   f2f8115fe8b3 ("memory: omap-gpmc: Use a compatible match table when checking for NAND controller")
>>
>> from the drivers-memory tree and commit:
>>
>>   0137c74ad873 ("mtd: rawnand: omap2: Add compatible for AM64 SoC")
>>
>> from the nand tree.
>>
>> I fixed it up (I used the former version and added the following patch)
>> and can carry the fix as necessary. This is now fixed as far as linux-next
>> is concerned, but any non trivial conflicts should be mentioned to your
>> upstream maintainer when your tree is submitted for merging.  You may
>> also want to consider cooperating with the maintainer of the conflicting
>> tree to minimise any particularly complex conflicts.
>>
> 
> Thanks Stephen, the fix looks correct.
> 
> Roger,
> It seems you sent two separate patches touching exactly the same files
> recently for two different trees. One for memory controllers moving the
> NAND ids and second for MTD tree with adding new compatible.
> Please don't, instead second should base on the other and these should
> go via one tree. This is a non-trivial conflict which could be avoided.

Thanks Stephen and Krzysztof.

Sorry for the trouble. I will be more careful next time.

cheers,
-roger
