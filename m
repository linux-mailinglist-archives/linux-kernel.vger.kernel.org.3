Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428734BF2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiBVH0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:26:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiBVH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:26:42 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBFC50046
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:26:17 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8FEE422175;
        Tue, 22 Feb 2022 08:26:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645514776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WUE5F/B9ycxc5hgcNoeXQ3HZv9EjcmdgJCeELwpIrnQ=;
        b=o0JP7nlcZRESyarpSG4EVGLYl0hEnE63QsIFXcUonf4FAjldBidIvh7ylCHbYMREhBE9RO
        siCLgIivV/wflU87Zlr8KX7ttfx9veiKymz5w2Px1dZnUNtt1WKzD3gRlDjKycwDzyYuxX
        PHMoZ/qwRgdpayj1AeoyrdfX3D67M9s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Feb 2022 08:26:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com
Subject: Re: [PATCH v4 01/32] mtd: spi-nor: atmel: unify function names
In-Reply-To: <20220222072314.tk4bw5sngwnk6zwr@ti.com>
References: <20220221120809.1531502-1-michael@walle.cc>
 <20220221120809.1531502-2-michael@walle.cc>
 <20220222072314.tk4bw5sngwnk6zwr@ti.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <338bfd692a372450d1210a333994c31e@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-22 08:23, schrieb Pratyush Yadav:
> On 21/02/22 01:07PM, Michael Walle wrote:
>> To avoid name clashes unify all the function and static object names 
>> and
>> use one of the following prefixes which should be sufficiently unique:
>>  - <vendor>_nor_
>>  - <flash_family>_nor_
>>  - <flash_part>_
> 
> Shouldn't this be "<flash_part>_nor_"?

No, a part name is already unique and its the same "style" as spi nand
is doing it.

-michael
