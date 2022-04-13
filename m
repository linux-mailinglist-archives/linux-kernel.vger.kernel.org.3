Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4B4FF2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiDMJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiDMJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:06:05 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71A27FC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:03:42 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id ADC7632C;
        Wed, 13 Apr 2022 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1649840621;
        bh=B8/+Q5Rg/0rSicwts1SK29yG4QDu+01MQufsM4qsUdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gClOCyeGYs96fwgpgp/j4LHwum1IXq+xCwwHsdprimUV+ysN+vskRlxDkC25IC4sp
         rhuDkYP4D5qT1GJngfu2TMMc6Ebd7tiE5mqMGtSb1B4CVkWLJkJ0Sa7p17jfhtqXjc
         j4WncKKTp1sK6LrzY2/12WaYCsHBVAX7c1T4qyhQ=
Date:   Wed, 13 Apr 2022 02:03:38 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 2/2] misc: Add power-efuse driver
Message-ID: <YlaR6kfhQHd3b8Ay@hatter.bewilderbeest.net>
References: <20220308011811.10353-1-zev@bewilderbeest.net>
 <20220308011811.10353-3-zev@bewilderbeest.net>
 <YicAzSara5Sr3LQ7@kroah.com>
 <YicSj3ZuetRkYxH1@hatter.bewilderbeest.net>
 <YlSnMVVE63xqGSGa@hatter.bewilderbeest.net>
 <YlUFuoFPveAYRQDm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YlUFuoFPveAYRQDm@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 09:53:14PM PDT, Greg Kroah-Hartman wrote:
>On Mon, Apr 11, 2022 at 03:09:53PM -0700, Zev Weiss wrote:
>>
>> Ping...Mark (or Liam?), any thoughts on an appropriate path forward on this?
>
>Make it a regular regulator driver please.
>

The existing userspace-consumer regulator driver does provide some of 
the functionality I'm looking for (the on/off switch), and I think would 
be pretty easy to extend to provide the rest of it as well.  When I 
previously proposed using it as such though, Mark stated quite firmly 
that that wasn't going to fly [0]; this approach was my attempt at 
implementing a generic, abstracted mechanism as he had suggested later 
in that thread, though I haven't gotten any further feedback from him on 
what he thought of it.

If he's had a change of heart and would be open to the 
userspace-consumer driver taking on a bit of new functionality I'd be 
happy to go that route though.

[0] https://lore.kernel.org/openbmc/20210330174221.GJ4976@sirena.org.uk/


Thanks,
Zev

