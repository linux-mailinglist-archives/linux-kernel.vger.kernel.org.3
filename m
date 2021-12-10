Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36546FDED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhLJJkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:40:31 -0500
Received: from mail.xenproject.org ([104.130.215.37]:39942 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhLJJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:40:30 -0500
X-Greylist: delayed 1643 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Dec 2021 04:40:30 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID;
        bh=XIPmTl0d5WI5yvmsZC68H9GM8X6AE8QmvYsZDuBAoEE=; b=DAsHt0iao8iLhh+rTn9mpAfBR+
        AlLZ/wBMxCdmwsRKyhB2ak8N1Pesu0q5DVqhjJHM6lzepefJrqh3NcuTpZgRMcoeoWoJ6sKYlGCax
        KdArgvFYGwopIskFjLPr2NI+KzYJahIpPds+HfgTUK074fsfdXfkzXCnbyUJKmLpOUdU=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1mvbuF-0001k0-U0; Fri, 10 Dec 2021 09:09:31 +0000
Received: from [54.239.6.184] (helo=[192.168.9.67])
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1mvbuF-0001kj-Ns; Fri, 10 Dec 2021 09:09:31 +0000
Message-ID: <669d3f56-13b8-f159-2053-b39f1ba4222f@xen.org>
Date:   Fri, 10 Dec 2021 09:09:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH V4 6/6] dt-bindings: xen: Clarify "reg" purpose
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
 <1639080336-26573-7-git-send-email-olekstysh@gmail.com>
From:   Julien Grall <julien@xen.org>
In-Reply-To: <1639080336-26573-7-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On 09/12/2021 20:05, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Xen on Arm has gained new support recently to calculate and report
> extended regions (unused address space) safe to use for external
> mappings. These regions are reported via "reg" property under
> "hypervisor" node in the guest device-tree. As region 0 is reserved
> for grant table space (always present), the indexes for extended
> regions are 1...N.
> 
> No device-tree bindings update is needed (except clarifying the text)
> as guest infers the presence of extended regions from the number
> of regions in "reg" property.
> 
> While at it, remove the following sentence:
> "This property is unnecessary when booting Dom0 using ACPI."
> for "reg" and "interrupts" properties as the initialization is not
> done via device-tree "hypervisor" node in that case anyway.
You sent a similar patch for Xen and have already commented there [1] . 
In short, the OS will be using the node to discover whether it is 
running on Xen for both ACPI and DT. The hypervisor node also contain 
the UEFI information for dom0.

Cheers,

[1] 
https://lore.kernel.org/xen-devel/9602b019-6c20-cdc7-23f3-9e4f8fd720f6@xen.org/T/#t

-- 
Julien Grall
