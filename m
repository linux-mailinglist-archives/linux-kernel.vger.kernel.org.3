Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C145006E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiDNHdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbiDNHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:33:04 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD6F5418B;
        Thu, 14 Apr 2022 00:30:38 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1netw2-001Q8x-MV; Thu, 14 Apr 2022 09:30:34 +0200
Received: from p57bd9a34.dip0.t-ipconnect.de ([87.189.154.52] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1netw2-002qc5-7P; Thu, 14 Apr 2022 09:30:34 +0200
Message-ID: <aa1e5107-22b6-3225-bad0-a2036782ce61@physik.fu-berlin.de>
Date:   Thu, 14 Apr 2022 09:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PING^3][PATCH] Alpha: Remove redundant local asm header
 redirections
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk>
 <alpine.DEB.2.21.2204132104530.9383@angie.orcam.me.uk>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <alpine.DEB.2.21.2204132104530.9383@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.154.52
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej!

On 4/14/22 00:53, Maciej W. Rozycki wrote:
> On Sun, 13 Feb 2022, Maciej W. Rozycki wrote:
> 
>> Remove a number of asm headers locally redirected to the respective 
>> generic or generated versions.
> 
>  Ping for:
> <https://lore.kernel.org/lkml/alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk/>

Maybe Andrew Morton could pick the fix up if the original maintainer is currently
not responding?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

