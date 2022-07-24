Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB29E57F426
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiGXIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:40:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D27140D5;
        Sun, 24 Jul 2022 01:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 619CFB80D17;
        Sun, 24 Jul 2022 08:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1022AC3411E;
        Sun, 24 Jul 2022 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658652054;
        bh=geZDnhQN0JqHvu8hmttukiCncgxnvnvKVBmeNXsnVnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOgwtLNBWGM1vPT4bySBecq9IwdfGY5cmzBxD14i05KWjZUcBAyLOhp52jwXgidA9
         /1hn9FRw1A6AYx5htACyj/r6AChc03kRcyJu6P+uQXvlCNNF3mih9IVvIMfugA64yz
         QDTTzjivjQ7b6FQdj+VIijMbcP35yO2051N9iSI99Nvrq+sJvAPFBylaVGvw9/REIr
         rVfMV8loSr3vKdCYvji1013xA7Jf9HbmGLCegECLD4fGgQqERIvMAIfDdqI6V1B3ny
         1sudJqKB6Olbj33YjRaYDe2OES5DaBsP2NcUvEX+n813gKy11rj4vUmOqNa5XdujVx
         7FDu45Sscm7PQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFXAc-0000mZ-6v; Sun, 24 Jul 2022 10:41:02 +0200
Date:   Sun, 24 Jul 2022 10:41:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel EM060K modem
Message-ID: <Yt0FnnVh47y8aMtn@hovoldconsulting.com>
References: <MEYP282MB23740DC78FB0DE954C59D3DEFD8F9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB23740DC78FB0DE954C59D3DEFD8F9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:28:00PM +0800, Yonglin Tan wrote:
> Add usb product id entry for the Quectel EM060K module.
> 
> "MBIM mode": DIAG + NMEA + AT + MODEM + MBIM
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=030b Rev= 5.04
> S:  Manufacturer=Quectel
> S:  Product=EM060K-GL
> S:  SerialNumber=89fb57db
> C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=500mA
> A:  FirstIf#= 8 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 8 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 9 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:* If#= 9 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#=12 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

What's this last interface used for?

Johan
