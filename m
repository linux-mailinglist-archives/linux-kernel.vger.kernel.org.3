Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4225793B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiGSHC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiGSHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:02:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920DE2F652
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:02:20 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BCB73221D4;
        Tue, 19 Jul 2022 09:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658214136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skNvbr0j+hofl85iaW0RxTSkg4nCkrhF2c8S2PwWoOI=;
        b=o1dSZePGRZbzDk6KrzIUHkbRZAp5Dk2ol0SUVc2agfL0dYMs3F7HoxmZDqak/0Gdgg6W0I
        VtnvJnPHsoqndhE8wy7lK9GotFyrXWOVb36a9FXsR0YMNHMC4tZp9r3h7+R07Jue55zGdY
        QM1plMP8yV8CaJagu+ln5ZMxD+e6eDg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jul 2022 09:02:08 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
In-Reply-To: <3e018ae9-66b0-0699-1121-e55c88f37570@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-3-michael@walle.cc>
 <735a88af-c4f1-a6b3-3f85-ea532b3f39c7@microchip.com>
 <305d3c9cf8a2362ad23a87f6ea92c6b4@walle.cc>
 <3e018ae9-66b0-0699-1121-e55c88f37570@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4ac08f08010a71e288b0114fc02d47a4@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-19 08:00, schrieb Tudor.Ambarus@microchip.com:
> On 7/18/22 10:25, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2022-07-12 10:40, schrieb Tudor.Ambarus@microchip.com:
>>> Shaik, can we have your Tested-by tag on this?
>> 
>> Sigh. His email address bounces with "The email address you
>> entered couldn't be found." So don't expect a Tested-by: here.
>> 
> 
> Would you drop this and pick the other patches that use your SNOR_ID3
> and submit them all in a single patch set?

I can collect the other patches, but why drop this if we know
for a fact that the flash will work? (Because it is the same
as the w25q512nwq)

-michael
