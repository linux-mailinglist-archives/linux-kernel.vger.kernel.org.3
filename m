Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD958A5DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiHEGX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHEGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:23:54 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC385A3D8;
        Thu,  4 Aug 2022 23:23:53 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id b96so2242642edf.0;
        Thu, 04 Aug 2022 23:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lSzazp4IeqQAxjSxCTiM6IIef8FSwkAGeIFyEp8bbW8=;
        b=sapD9pwzfamCAD+TEEnV3hUFmBzJJfELbnw2+NYTEIyqsPhDuzdi4D5QwdB+0mZx4O
         bGxV999O87BLabWc6n6NBpIjkiB7vGyZgwwvOQ1mtCZPtOLFcz1g0x4eGWEgbH8+PGUO
         CHLxZXSLG9uvNMjl+QSXElLsCQXBJPngJJaYxU494QrhvCPuTMaKyFAhh1LGiTktBX5Z
         hV7saG7J3xfr/dIEKilTTishxQHisrrWAsJMfUDMuY2IC4U7erhegX2rIWJYh+SB3CKm
         sYxza4+KulSbcd/Ga2OkkKmii8pilz584VIxvLetnUM/SXFLP/qWq9mwEnidZisj4oIs
         HsFw==
X-Gm-Message-State: ACgBeo1i55VwumWC2Yukrig3Znxl7TN0abRNBhOd/2fK0nQ8/aZfKr22
        mqV0MHqPztVg+atVlCidARQ=
X-Google-Smtp-Source: AA6agR7JfOIsUi61tf8PKiHiROvK+umLKkQHpRB7QosKc1O4XZoIWJizrdKe41LiNuqThsOTc1rg1Q==
X-Received: by 2002:a05:6402:4442:b0:43b:c866:21be with SMTP id o2-20020a056402444200b0043bc86621bemr5373348edb.28.1659680632342;
        Thu, 04 Aug 2022 23:23:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906538600b0072b609d9a36sm1242446ejo.16.2022.08.04.23.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 23:23:51 -0700 (PDT)
Message-ID: <f0cb47c3-04b8-7bef-ed84-8aa7a9b05ec3@kernel.org>
Date:   Fri, 5 Aug 2022 08:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [EXT] Re: [PATCH 1/1] serial: fsl_lpuart: RS485 RTS polariy is
 inverse
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Nicolas Diaz <nicolas.diaz@nxp.com>
References: <20220802163854.1055323-1-shenwei.wang@nxp.com>
 <c63877d8-4df2-778e-7e3d-2fdd0e14d4e1@kernel.org>
 <AM9PR04MB8274F4B0895FF2BA4467DA90899F9@AM9PR04MB8274.eurprd04.prod.outlook.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <AM9PR04MB8274F4B0895FF2BA4467DA90899F9@AM9PR04MB8274.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 08. 22, 16:35, Shenwei Wang wrote:
>> On 02. 08. 22, 18:38, Shenwei Wang wrote:
>>> The setting of RS485 RTS polarity is inverse in the current driver.
>>>
>>> When the property of 'rs485-rts-active-low' is enabled in the dts
>>> node, the RTS signal should be LOW during sending. Otherwise, if there
>>> is no such a property, the RTS should be HIGH during sending.
>>
>> What commit this fixes? I.e. I am missing a Fixes tag below.
> 
> It is a fix for the following commit:
> Fixes: 03895cf41d18 ("tty: serial: fsl_lpuart: Add support for RS-485")
> 
> Should I send out a new version to update it?

It's up to Greg, but I guess so.

-- 
js
suse labs
