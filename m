Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19C046B3D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhLGHad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:30:33 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:33086 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhLGHac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:30:32 -0500
Received: from [10.0.30.193] (unknown [10.0.30.193])
        by uho.ysoft.cz (Postfix) with ESMTP id C172BA08B1;
        Tue,  7 Dec 2021 08:27:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1638862020;
        bh=C58YyNfQVrg3hSPONSqJPFf4psftHxj/u7tAtyQjnQE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sse4SzVEGMHGmqme5VBtwAakjMaPG4gAGb/eGBi6ijBnuvLtnjsmw0xDgNszU6DNO
         Ib+G33dhHe15hq1317xXWgjKBWIkawppshI4eswCHCqsu1C3J08wa1AeewmcWfYAej
         zb6Fovr9nTFwqWxXfUzHKQ/taaqm7Fvyfnkei/Rw=
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211207091014.06063422@canb.auug.org.au>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <74bc4baa-96df-f41d-2838-c18be52a5051@ysoft.com>
Date:   Tue, 7 Dec 2021 08:27:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211207091014.06063422@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 12. 21 23:10, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> Error: arch/arm/boot/dts/imx6q-yapp4-crux.dts:24.1-7 Label or path codec not found
> Error: arch/arm/boot/dts/imx6q-yapp4-crux.dts:52.1-7 Label or path sound not found
> FATAL ERROR: Syntax error parsing input tree
> Error: arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts:24.1-7 Label or path codec not found
> Error: arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts:52.1-7 Label or path sound not found
> FATAL ERROR: Syntax error parsing input tree
> 
> Caused by commit
> 
>    a4d744ac2bab ("ARM: dts: imx6dl-yapp4: Add Y Soft IOTA Crux/Crux+ board")
> 
> I have used the imx-mxs tree from next-20211206 for today.
> 

Hi Stephen,
I already send a patch for this yesterday short time after
the kernel test robot reported the same failure. It is on
the devicetree mailing list:

https://www.spinics.net/lists/devicetree/msg461729.html

Sorry for my mistake though,
Michal
