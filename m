Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5950DB77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbiDYIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiDYIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:45:09 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0636683016
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:42:04 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 63031C000D;
        Mon, 25 Apr 2022 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650876122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deyfR/jFFfSBZAa0aePAr9OXuLMhTGf/khYat66l9nE=;
        b=B1oL6rmENQ72/SO9FbFEtrSqvb0mn0UOX1/nlYSe+iAiItjxoRxrTLNwejSIBrY8ThjN6b
        2wF9/5bhzFLCdlT3vp0GyhUrZlUp24Dusz4zHo3F3tCqFWfy4vnWI9fsZt5ArERQm1otKf
        DbVpDwimXO45kxpzB2/FEqH7GBQL7Gy/PiiYGKU9hogp5iy1bqkdmJvWYeHARX7QrKplHI
        9bqP/GRx0c+7a1SSfKcf1hfLgFDjktn/I4fpB4VupT1DEay2KDy2eONAA+i9omibGWB0Ou
        wd9QLAf7P2BJGGyq33+EKNyehQ/vY7iWeLj1IXXNzI60fpiCFIY3wBJIfAKSVw==
Date:   Mon, 25 Apr 2022 10:42:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mtd: mtdoops: Add timestamp to the dumped oops
 header.
Message-ID: <20220425104201.173e65fa@xps13>
In-Reply-To: <20220421234244.2172003-1-jmeurin@google.com>
References: <20220415001321.252848-1-jmeurin@google.com>
        <20220421234244.2172003-1-jmeurin@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Marc,

jmeurin@google.com wrote on Thu, 21 Apr 2022 16:42:41 -0700:

> The current header consists of 2 32-bit values which makes it difficult
> and error prone to expand. This creates a structure for the header.
> 
> Some oops only have time relative to boot, this adds an absolute timestamp.
> 
> Changelog since v3:
>   Fix the printk format for sizeof to %zu.
> 
> Changelog since v2:
> - Add a timestamp to the header.
> 
> Changelog since v1:
> - Create a header structure to simplify code.
> - Patches in series.
> - Patch prefix.
> 
> Jean-Marc Eurin (3):
>   mtd: mtdoops: Fix the size of the header read buffer.
>   mtd: mtdoops: Create a header structure for the saved mtdoops.
>   mtd: mtdoops: Add a timestamp to the mtdoops header.

Looks like the last patch was not sent to the list?

