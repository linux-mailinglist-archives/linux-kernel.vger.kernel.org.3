Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79CE504950
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 21:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiDQTeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 15:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiDQTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 15:34:05 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E0B643D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 12:31:28 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C3C4222238;
        Sun, 17 Apr 2022 21:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650223886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pq6hLMQv4hPuNqosqBP+KVPlfDr1hbO5mSyBKH9f6cs=;
        b=qmXyC2SARbSt+czEPUlY1pJZ9nDT6eLGSPs/0vKSr8y2GSR9v7RoZl9+2YEeG137aWSPVr
        T+GU2UktPP/q/eIhjCuGYvucipw0XtD/sHjaYwFre3PwB9GamOxgCSpbUA7VhcmvmsSQJg
        cjXCJn7bvleMfc4LsskUwkS25DbUgrg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Apr 2022 21:31:25 +0200
From:   Michael Walle <michael@walle.cc>
To:     niravkumar.l.rabara@intel.com
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: issi: Add IS25WP512 device
In-Reply-To: <d805708b94dc4a00b854f3769c5013b1@walle.cc>
References: <20220414130004.945924-1-niravkumar.l.rabara@intel.com>
 <d805708b94dc4a00b854f3769c5013b1@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <24c324e4f57c896bd289c367bdd5f9a8@walle.cc>
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

Am 2022-04-14 12:09, schrieb Michael Walle:
>> +is25xx_post_bfpt_fixups(struct spi_nor *nor,
> 
> Please use is25_post_bfpt_fixups.

Sorry, this should be is25_nor_post_bfpt_fixups.

-michael
