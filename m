Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65B05573E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiFWH0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiFWH0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:26:07 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E54616E;
        Thu, 23 Jun 2022 00:26:05 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id z19so10372571edb.11;
        Thu, 23 Jun 2022 00:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R6a8DdfHxenCBzF3dq4dxp9GwEChi5fgdNd/WHlOcfQ=;
        b=6ZxWpcTZSMX39xQf2PFfMxawrP+XWoPjPdoXOYMTmeNEVL1B4NaJ7wpV+s3dZfwR4A
         eGOk0IQ8p7bm8tejznIDpqAC4g9GnFQD1UhPxaXtMLPg/Z5Cc27r04bgbjxDUFBThpmc
         /4SSRaZUzbsQrj3Nj5BS7hwJ34TRazJEUNl/myNAMEi2BVobeQ3UkcIlZqNZRvjuIboA
         en67RvfwirfArqcMH6wC+DxMO83QCI+C8L85vl8OjzsyLDPe0goiBRHguGAWjXWZBWc4
         1YfcrwIJXx9FYTmOoFVC4ysf0mhxhKLvij2GziKda681LCQdH6QFkE4MfTzh0xJVH0+a
         xKpA==
X-Gm-Message-State: AJIora+Vp6n2wuLS91xutWB7F6+EkMBzpzH3acYy7LcZdQZOjkHGGpxW
        5NpCpW9ZXt8EjhDNYiOHNJo=
X-Google-Smtp-Source: AGRyM1tvWz9FgM1YUo4FSxo1ULZmBptXI2Y2wXjouVQNxsHbgsiomjt6JjYIFtvNC42sJOR9KGY70Q==
X-Received: by 2002:a50:cb8b:0:b0:435:68a3:4d40 with SMTP id k11-20020a50cb8b000000b0043568a34d40mr9038890edi.394.1655969163690;
        Thu, 23 Jun 2022 00:26:03 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id lb21-20020a170907785500b007219c20dcd8sm7648295ejc.196.2022.06.23.00.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:26:03 -0700 (PDT)
Message-ID: <59ee9f60-06be-573b-24bf-5a6460107c55@kernel.org>
Date:   Thu, 23 Jun 2022 09:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/6] serial: msm: Rename UART_* defines to MSM_UART_*
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-3-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220621124958.3342-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 06. 22, 14:49, Ilpo Järvinen wrote:
> Using UART_* to name defines is a bit problematic. When trying to do
> unrelated cleanup which also involved tweaking header inclusion logic,
> caused UART_CSR from serial_reg.h to leak into msm's namespace which is
> also among msm defines. Thus, rename all UART_* ones to MSM_UART_* to
> avoid eliminate possibility of collisions.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


-- 
js
suse labs
