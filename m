Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0FA5B0823
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIGPMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIGPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:11:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223F303D7;
        Wed,  7 Sep 2022 08:11:58 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so10487940otu.3;
        Wed, 07 Sep 2022 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wDtnxWX9qH0SSn7z37VDylIPQhTtMeAWDDFIYde2ERM=;
        b=nZqw9OO01h+bN8a7lUuJNisfk4bwlZA1AnnNYpcpySnF7hBTYT8K36NVMXOm2pEcjw
         0/eWNhoPo/UuX2ho3uPqHee4L1EebC505c3Z9CV8c0QF/kXPbivYvxeUz1Ef+OxXt59o
         l38gmpmYekBNesuAXu9/sM3Ut4VcfjIAqB7glYR/tjsmrJ6q0hNUaOOfezCC4pqh/vHe
         hsNbPguIbqIXsZlwD25n62o6a/LOLwhE92RPW0WWQosX2jVo3puO9bbln6NdiddqyyNN
         YjApCdHlS1O8O582u/rch7EtjRRXUgtv/r+MevTY6rrElqQIwCUGEy6Z/262mtHeXTc8
         /TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wDtnxWX9qH0SSn7z37VDylIPQhTtMeAWDDFIYde2ERM=;
        b=U+BDHMXSWaRkvputIzNh6c2x6bX7n4cm4rYUhWJMrGShvSiPyykSyUFWc2YfEAHx41
         l3Xo/J3Jakm1rKwE5iS4+E6tiPkwjxeSSRTtnNO9wKESSfmh3fibvKiT9w16blDhMswu
         vRHNfgJI314naZUo7ugSpo9LLwpTLor+AhXvsoJWD4OYdMdh/GvV647vsYw0V08McuVC
         QRq8A4u/+f2/xPBf3A/pIATtf3dqLhvCC+VlsAwmZFiEugRjpX2DcVKfsDNQTNi3VP3+
         jkAH2+S0kRBhKKG0yrdZKTOnvBzxD20Y1kWn8ObChC58kJ2USYTrzv0TRy6AgRdtSwkD
         Edbg==
X-Gm-Message-State: ACgBeo1S1v/jPKeZabBPG2uF/YJE0miaitnFaB2CAPLBXCgPF9T3vZpB
        g0LDyFu1OdyRSrU5wlbs5KrPCnQ7pMU=
X-Google-Smtp-Source: AA6agR49JXgz8161h9dV2enWeSGpFBSuIfyjFOTru7WIIt69r/JS20Cv9Xke1P6aRnU8kO1o0Dw+1A==
X-Received: by 2002:a9d:6391:0:b0:651:26ae:3604 with SMTP id w17-20020a9d6391000000b0065126ae3604mr1349204otk.311.1662563517598;
        Wed, 07 Sep 2022 08:11:57 -0700 (PDT)
Received: from [172.31.250.1] ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id 101-20020a9d086e000000b0063696cbb6bdsm7165899oty.62.2022.09.07.08.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:11:57 -0700 (PDT)
Message-ID: <3097d4b8-a9d0-878c-3b95-5499ed943576@gmail.com>
Date:   Wed, 7 Sep 2022 10:11:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v10 0/2] Introduce block device LED trigger
Content-Language: en-US
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
References: <2047607620.67144.1662552964865@office.mailbox.org>
From:   Ian Pilcher <arequipeno@gmail.com>
In-Reply-To: <2047607620.67144.1662552964865@office.mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 07:16, torvic9@mailbox.org wrote:
> Hi Ian,
> 
> with a heavily patched Linux 6.0-rc4 with kfence, kmemleak and slub_debug I get the
> following splat at boot:

Sorry about that!  I'm not sure how that slipped throgh, as I was sure
that I tested the new version before I sent it off.

Basically, I messed up while cleaning up the function parameter names,
so you need to apply this:

--- drivers/leds/trigger/ledtrig-blkdev.c.old   2022-09-07 
10:00:26.194484681 -0500
+++ drivers/leds/trigger/ledtrig-blkdev.c       2022-09-04 
11:36:16.107690614 -0500
@@ -540,7 +540,7 @@
                 return ERR_PTR(-ENOMEM);

         bdev = blkdev_get_by_path(strim(buf), BLKDEV_TRIG_FMODE, 
THIS_MODULE);
-       kfree(path);
+       kfree(buf);
         return bdev;
  }

> I'm not 100% sure if this is an issue with ledtrig_blkdev or something else,
> but I thought I'll let you know about it.
> I have not been able to test this on a vanilla kernel yet.

Defnintely my fault.

> Other than that, I hope this patchset gets included in upstream.
> I have been using it for a long time now and found it very useful.

It's really hard to know if anyone is interested in/using this, so
that's great to hear.

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================

