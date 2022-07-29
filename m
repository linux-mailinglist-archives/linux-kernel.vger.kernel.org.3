Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6037A584D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiG2IU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiG2IUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:20:23 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C24DEA5;
        Fri, 29 Jul 2022 01:20:19 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oHLEG-0006Cq-AA; Fri, 29 Jul 2022 10:20:16 +0200
Message-ID: <075b8d68-93e5-93a3-a247-6811152b35d1@birger-koblitz.de>
Date:   Fri, 29 Jul 2022 10:20:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC v1] spi: realtek-rtl: Fix clearing some register bits
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
References: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
 <be60acab-7dfe-6841-b176-4bd1e875d52e@birger-koblitz.de>
 <CAFBinCB6bJbK2sx+oyCjo97Sv2=ywnCi_4v+E76f78DYMNqJkg@mail.gmail.com>
From:   Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <CAFBinCB6bJbK2sx+oyCjo97Sv2=ywnCi_4v+E76f78DYMNqJkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659082821;edef71fd;
X-HE-SMSGID: 1oHLEG-0006Cq-AA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 7/28/22 17:27, Martin Blumenstingl wrote:
> Your patch actually addresses an issue which I have seen with RTL_SPI_SFCSR_CS.
> Since you seem to have boards with these Realtek SoCs: could you
> please clean up your patch and upstream it (splitting into smaller
> patches if/where needed)? That would be a win-win: upstream gains
> improved SPI support and I won't be confused the next time I look at
> the spi-realtek-rtl driver.

Thanks for suggesting this! I will send a patch-set later today along 
these lines, I first need to set up a linux dev environment as the 
development so far was within OpenWRT.

Cheers,
   Birger
