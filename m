Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C495260C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379800AbiEMLLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379798AbiEMLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:11:18 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6DE5A5B2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:11:17 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E8EDB221D4;
        Fri, 13 May 2022 13:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652440275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9pV4ceZp2jBzmUpp2ZHmANTNVPZNX+S/qtaNuz/v8JU=;
        b=rDLw+uO7mxnfh6PH1ONHS1YDxUz4UVpEUka9QoM0qVf0lttGaNZJ2nZqi8qa8GBqX+HS2v
        oihlqaATznXfoDhAwwgXq8eDqu8EHRir1NhFr/lpQM6kXGelXOEpFvY1GsMm7LmAlj/MVT
        ugKmU5Gl6v/74YvYSorP0qDGsUHxaX8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 May 2022 13:11:14 +0200
From:   Michael Walle <michael@walle.cc>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Support Dual and Quad Read on Macronix
 mx25u25635f
In-Reply-To: <20220513094759.44185-1-alexander.sverdlin@nokia.com>
References: <20220513094759.44185-1-alexander.sverdlin@nokia.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <34eccc66cc75dd0ffbf8a77780b6f8a7@walle.cc>
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

Hi,

Am 2022-05-13 11:47, schrieb Alexander A Sverdlin:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> According to datasheet both Dual and Quad Read is supported. The read 
> test
> shows x3.8 speed gain.

Does it have SFDP? Try adding PARSE_SFDP instead of the
NO_SFDP_FLAGS.

Please post an SFDP dump of this flash [1].

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
