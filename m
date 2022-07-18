Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699A577C36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiGRHMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiGRHMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:12:36 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D717A86;
        Mon, 18 Jul 2022 00:12:32 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id r14so15711586wrg.1;
        Mon, 18 Jul 2022 00:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jq+ERgHLXjd99Gt//WGSWsvGDeg+4Vpzw3ae5fqcZd0=;
        b=qQUc2w6grL4384+um1BW4h2jSKqJyXWxQesrpsUEFp64War6tc015XB2P7v8nkRRhp
         l7VxpaZYVlXYtz+iKMqAJGrKTckWYqTgt002hk4NIc/DP3OwZCwcIxkGoEhUGWG48CB1
         kqquwnDuKaoLafRQ6J/56NJTlJbAgb0OBf+rYkBv2AWNdNwkY31LarCl/37q4Gz6ZGbA
         zcEQGioSVvHWrTbPCFGew55vgjLNxsSQsSI+vNEHBLguu3l7c8nBils2g2qak4pBfF1r
         jDbFDZmYva1XxKVAz8akFG/tS8adpDdDoYoCZClxQ4PQqfxdd8LU1vLeSEjLrw9MZPO1
         oxrA==
X-Gm-Message-State: AJIora+dApVM/CC06vuOL3qC4RIF9LCGZQHVf6ja0rpXSL8S8a5boAFg
        ewfTGV0pZCpATYRZ2inL4TQkmSxg8+A=
X-Google-Smtp-Source: AGRyM1vuCuHClwlRREYmL4N9K/orvP2tFDDUyl37081RiZs1RADzqbgP5a7pWfTHCG9hGrL+f5OTjw==
X-Received: by 2002:a05:6000:185:b0:21d:7ffc:4916 with SMTP id p5-20020a056000018500b0021d7ffc4916mr21851821wrx.692.1658128350735;
        Mon, 18 Jul 2022 00:12:30 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id id15-20020a05600ca18f00b003a31f1edfa7sm627887wmb.41.2022.07.18.00.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 00:12:30 -0700 (PDT)
Message-ID: <d0e692ed-e28b-2fff-b870-3640ef5009bb@kernel.org>
Date:   Mon, 18 Jul 2022 09:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] serial: remove VR41XX serial driver
Content-Language: en-US
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220715140322.135825-1-tsbogend@alpha.franken.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220715140322.135825-1-tsbogend@alpha.franken.de>
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

On 15. 07. 22, 16:03, Thomas Bogendoerfer wrote:
> Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> for MIPS VR41xx platform, so remove exclusive drivers for this
> platform, too.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

...
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -124,10 +124,6 @@
>   /* TXX9 type number */
>   #define PORT_TXX9	64
>   
> -/* NEC VR4100 series SIU/DSIU */
> -#define PORT_VR41XX_SIU		65
> -#define PORT_VR41XX_DSIU	66

I didn't find any userspace users, so hopefully nothing breaks.

thanks,
-- 
js
suse labs
