Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB064DC201
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiCQI5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiCQI5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:57:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE851CCAC3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:56:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w4so5672701edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4ZlWGxIpVMVSY4V9SoW9sLygWbw7lhRyEfpNfhcyNy0=;
        b=WZo0NpgYpZQKUgwmEdn2MTli/3WmlFymvJyM+baA8S8m5W0189q68tTkoAVejAc4ah
         OBa4dH/8SCDYAgZj5ldxQN8dJOFsr/d/PJHDDJcehCod9DI920z16UHkDFV+dXdZa0+N
         uJjGZpAsvxLZwXFZ4LxUHEKM7Z9x9R1kMXSnhC5t9WCL89OfPbwNTxAW79YOXnRS8xLt
         oha28QETzSbjcQ1HcSpPF2X4YHbs7vVg/KDYh2nnMSKfz65hmNfaq22eF0pKPilRccaE
         CexkcWcZ6Q3B11iTQxj4Cbips/qWNoSDGwCl3wzuAoitX6JULlgPxsCW5l8t3Qzs/L60
         vmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ZlWGxIpVMVSY4V9SoW9sLygWbw7lhRyEfpNfhcyNy0=;
        b=wyk4RCuqVkl0wrHa+2SwYsMFSfyHRdp6Dj5BM2N2DmDsBU6flmvWNj+G2gfVMliebe
         NE0Y6QhUENyUQmGbXvAmbHKPHYz1wUMQwNruMfUJOOQ694VaImLDh2Y6qnPpcyKqJFJN
         xNqQ4FMnsAEyebkI922d3inbWEcyQORSbd7VHbENZH/7VzpDo+G4nlOUdy/NFcoBtf8J
         8BPDPL7cxbqmzDk1Qu50scirAr9a8HrtBfFGLQzI07rrdETOigq9rHHacT7rJKkF9Y6C
         gd5Lo1vWcofzmURzi3npsHLYvWuN/IC1WD1WZqBbx/xjsnv9BciWtIW8B2soP5GwQDVP
         35NA==
X-Gm-Message-State: AOAM533JzO1oc9WdjD9VRYu1iYlk1erBvXtIGGeOIqMmfhc61Bft5fei
        K/iRujCFfTE7U0mMd+OQGC8F2JgtIqmt2eW90q4mhg==
X-Google-Smtp-Source: ABdhPJwRTGcM39a1h4gUfTFT37DfgLVGXP4Rfrr+6E+0QeEcQgcx8xgDHPI3U0VHYnqvRv6eufaWVg==
X-Received: by 2002:a05:6402:17dc:b0:418:efa5:f445 with SMTP id s28-20020a05640217dc00b00418efa5f445mr3223853edy.125.1647507380134;
        Thu, 17 Mar 2022 01:56:20 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm2066032ejk.41.2022.03.17.01.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 01:56:19 -0700 (PDT)
Message-ID: <b515e6de-fd84-8ed2-70f1-7c4eae851d94@blackwall.org>
Date:   Thu, 17 Mar 2022 10:56:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 net-next 04/15] net: bridge: mst: Notify switchdev
 drivers of MST mode changes
Content-Language: en-US
To:     Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Cooper Lees <me@cooperlees.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-5-tobias@waldekranz.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220316150857.2442916-5-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 17:08, Tobias Waldekranz wrote:
> Trigger a switchdev event whenever the bridge's MST mode is
> enabled/disabled. This allows constituent ports to either perform any
> required hardware config, or refuse the change if it not supported.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/net/switchdev.h |  2 ++
>  net/bridge/br_mst.c     | 11 +++++++++++
>  2 files changed, 13 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

