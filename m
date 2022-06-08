Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1CB542849
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiFHHqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiFHHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:42:03 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FBC229A48;
        Wed,  8 Jun 2022 00:06:51 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nyplE-002o4y-CQ; Wed, 08 Jun 2022 09:05:48 +0200
Received: from p57bd968f.dip0.t-ipconnect.de ([87.189.150.143] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nyplE-003Qpw-5p; Wed, 08 Jun 2022 09:05:48 +0200
Message-ID: <db5505e5-811e-0572-7614-8443c864b5e6@physik.fu-berlin.de>
Date:   Wed, 8 Jun 2022 09:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] sh: cast away __iomem to remove sparse warning
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Rob Landley <rob@landley.net>,
        akpm@linux-foundation.org
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220507013411.74277-1-bhe@redhat.com>
 <YpS0C8tVG2E5jGSV@MiWiFi-R3L-srv>
 <c24579a3-74e4-1dbb-6237-d9e1a01e6e09@landley.net>
 <Yp/3Lq03+UVs9Bpv@MiWiFi-R3L-srv>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <Yp/3Lq03+UVs9Bpv@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.143
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 6/8/22 03:11, Baoquan He wrote:
> I guess SuperH arch has been in status of no maintenance, however some
> generic code change may involve correspondant ARCH change so that we
> have to touch arch/sh/.

It is actually actively maintained by Rich Felker but he is often slow to
respond at the moment. I have already offered Rich my help and maybe we
can work something out that I can help him with the maintenance.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

