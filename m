Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A190E4B2F25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353639AbiBKVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:14:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353587AbiBKVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:14:50 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D0C49;
        Fri, 11 Feb 2022 13:14:48 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nIdFc-0026N1-Gd; Fri, 11 Feb 2022 22:14:44 +0100
Received: from p57ae5b61.dip0.t-ipconnect.de ([87.174.91.97] helo=[192.168.178.35])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nIdFb-002Ii9-QC; Fri, 11 Feb 2022 22:14:44 +0100
Message-ID: <fee23207-4d72-197c-3e95-a5e88ade5ccf@physik.fu-berlin.de>
Date:   Fri, 11 Feb 2022 22:14:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>
References: <2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru>
 <63f06bf0-fc7b-3c5c-8af9-5adfd7628354@omp.ru>
 <dde846f0-1324-7fde-ef92-eb72d4200b50@physik.fu-berlin.de>
 <e4c1aec0-e8a0-4577-d12b-8e4efedbf7e6@omp.ru>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <e4c1aec0-e8a0-4577-d12b-8e4efedbf7e6@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.174.91.97
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 21:46, Sergey Shtylyov wrote:
>> I can test your revised patch next week on my SH7785LCR.
> 
>    Please do, although testing on the AP-SH4A* bords would be a bit more
> interesting, as they actually use IRQ0 for the SMSC911x chip...
>    Maybe you have SH7786 base board, by chance? 

Unfortunately not. I think Oleg Endo might have one but my memory might be wrong here.

I think there was also someone on the J-Core list mentioning he had an Alpha Project
board [1], but I don't remember which one.

Adrian

> [1] https://www.apnet.co.jp/product/superh/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

