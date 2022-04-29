Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB90514CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbiD2O1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376827AbiD2O12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:27:28 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BF891356;
        Fri, 29 Apr 2022 07:24:10 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nkRXR-001viz-GH; Fri, 29 Apr 2022 16:24:05 +0200
Received: from p5b13aa55.dip0.t-ipconnect.de ([91.19.170.85] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nkRXR-000gNQ-9t; Fri, 29 Apr 2022 16:24:05 +0200
Message-ID: <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
Date:   Fri, 29 Apr 2022 16:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.85
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey!

On 4/27/22 20:46, Sergey Shtylyov wrote:
> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
> at 0 -- modify that code to start the IRQ #s from 16 instead.
> 
> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...

Maybe try getting it landed through Andrew Morton's tree?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

