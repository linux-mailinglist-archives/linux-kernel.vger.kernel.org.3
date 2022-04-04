Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B314F1EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382525AbiDDWJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378948AbiDDQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:07:16 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75E13F42;
        Mon,  4 Apr 2022 09:05:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8A62D41F28;
        Mon,  4 Apr 2022 16:05:11 +0000 (UTC)
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
 <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
 <20220404155924.GA9764@lst.de>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <216d4bde-9463-a7c7-7d0a-57ea157aa280@marcan.st>
Date:   Tue, 5 Apr 2022 01:05:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220404155924.GA9764@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 00.59, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 12:57:33AM +0900, Hector Martin wrote:
>> The kernel hard limit is 100-character lines, not 80-character lines.
>> Maintainers for existing drivers are certainly free to stick to 80 chars
>> if they like it that way, but I don't see why we should still be
>> enforcing that for new code. See bdc48fa11e46.
> 
> Because 100 is completely utterly unreadable if is not for individual
> lines like strings, and that is actually how Linus stated it in CodingStyle.
> 
> Your code as-is is completely unreadable and will not go into
> drivers/nvme/ in that form.

That line is 81 characters. I'm sure Sven doesn't mind fixing it, but
"your code as-is is completely unreadable" seems uncalled for here, and
rather unreasonable.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
