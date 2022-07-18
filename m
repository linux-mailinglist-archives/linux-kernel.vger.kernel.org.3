Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95933577CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiGRHjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiGRHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:39:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9EE6256
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:39:11 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8C4CE2222E;
        Mon, 18 Jul 2022 09:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658129949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/DWlXv3hCjUIcmrUZpOnkgU0ztlcQ5rZy7MZpY0AIIs=;
        b=YEEl9cddWINhI5mgUcL0kP9WS9XEQ4z1GUP8KG0gZlBnxY85Xb/Mi8tZOXTLYMsKDbj4J6
        6pDFJKXOhk/zfBb9w5oU5ZPs3dmyCHbVqq/lpjfNAlK+rnRGyWklkL8qXcthy2fsxU1+Gl
        KQFqw/T93Et3FyvyBWN9fxeNUvlwG5o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Jul 2022 09:39:08 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, ben.dooks@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: spi-nor: issi: is25wp256: Enable Quad Input Page
 Program
In-Reply-To: <20220712163823.428126-4-sudip.mukherjee@sifive.com>
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-4-sudip.mukherjee@sifive.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d918c4d3d91adac247ebae6418b409b7@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-12 18:38, schrieb Sudip Mukherjee:
> The flash chip is25wp256 supports Quad Input Page Program. Enable it
> in its no_sfdp_flags flags.

Are you sure, that chip doesn't have SFDP? Even the oldest datasheet
I've found [1] mention SFDP.

[1] https://datasheetspdf.com/pdf-file/1303587/ISSI/IS25WP256/1

-michael
