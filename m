Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C644F47CFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbhLVKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:22:43 -0500
Received: from 18.mo583.mail-out.ovh.net ([178.33.45.10]:42941 "EHLO
        18.mo583.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbhLVKWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:22:34 -0500
X-Greylist: delayed 2140 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Dec 2021 05:22:34 EST
Received: from player789.ha.ovh.net (unknown [10.108.16.31])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4278B24120
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:46:50 +0000 (UTC)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player789.ha.ovh.net (Postfix) with ESMTPSA id 679C025A4F648;
        Wed, 22 Dec 2021 09:46:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R0019a5307bb-0ab5-4ee7-8c4b-437becc1f6e8,
                    6227138D1A59C2D5CB218EB48BA84448E8ED8D0D) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <64fe4338-4dc8-8846-0731-e67e9d197068@milecki.pl>
Date:   Wed, 22 Dec 2021 10:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register() error
 path
To:     Johan Hovold <johan@kernel.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com> <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com> <YcLkA0e48+xuGsHk@hovoldconsulting.com>
 <52a2a318-0efe-94af-b8b9-308c2fbb1fab@gmail.com>
 <YcLrHEoOy3iRSkFp@hovoldconsulting.com>
 <c5b76d10-c270-21e5-e528-9aa20b1384ef@milecki.pl>
 <YcLvY5tJJcxusM0a@hovoldconsulting.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <YcLvY5tJJcxusM0a@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17584867695968693211
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepvdelledtjeehvdetffejjeeuteeiveduudejledvjeeiuedvfeehteduhfeivdetnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 10:26, Johan Hovold wrote:
> device_initialize() is special, and everyone just needs to learn that.

Understood :) Thank you
