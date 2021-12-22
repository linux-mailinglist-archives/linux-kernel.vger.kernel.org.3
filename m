Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADAF47D08B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbhLVLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:11:45 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:34678 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244418AbhLVLLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:11:43 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mzzWz-000AHl-4O; Wed, 22 Dec 2021 11:11:39 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mzzWu-00AAhH-VX; Wed, 22 Dec 2021 11:11:35 +0000
Subject: Re: [PATCH] um: virtio_uml: allow probing from devicetree
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>, kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211221090447.1567-1-vincent.whitchurch@axis.com>
 <5f104044649ec60ba93648e68c3df2183e032072.camel@sipsolutions.net>
 <20211222103417.GB25135@axis.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <38342157-f9c5-42dd-db04-3a13756bd70b@cambridgegreys.com>
Date:   Wed, 22 Dec 2021 11:11:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211222103417.GB25135@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2021 10:34, Vincent Whitchurch wrote:
> On Tue, Dec 21, 2021 at 09:48:26PM +0100, Johannes Berg wrote:
>> On Tue, 2021-12-21 at 10:04 +0100, Vincent Whitchurch wrote:
>>> Allow the virtio_uml device to be probed from the devicetree so that
>>> sub-devices can be specified using the standard virtio bindings, for
>>> example:
>>>
>>>    virtio@1 {
>>>      compatible = "virtio,uml";
>>>      socket-path = "i2c.sock";
>>>      virtio-device-id = <0x22>;
>>>
>>
>> Given this, maybe it should modify
>> Documentation/devicetree/bindings/virtio/virtio-device.yaml? Or actually
>> add a new Documentation/devicetree/bindings/virtio/uml.yaml I guess?
>>
>> +Rob, because I'm not really into any of this.
>>
>> Also, I'm not even sure we should/need to document the DT bits that are
>> basically only used for testing in the first place?
> 
> I wasn't sure either, but Rob was OK with not documenting some other
> bindings which are only used for testing[0], so I assumed that that
> applied here too:
> 
>   [0] https://lore.kernel.org/all/5baa1ae6.1c69fb81.847f2.3ab1@mx.google.com/
> 
> Also, DT bindings are supposed to be generic and based on what the
> hardware has, but here we have no hardware and something very Linux and
> UML-specific.

This will probably need to be added to the general UML documentation. I 
will take care of that once the patches are in the tree.

Brgds,

> 
>> Code looks good to me.
> 
> Thanks!
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
