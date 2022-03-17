Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1143C4DC1FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiCQI5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiCQI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:57:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928BF1CAF16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:56:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w4so5671692edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PuxphhtSyojHBQ+/3yS9PotueY01xJQMUnQnfyRU8xE=;
        b=e0ChA5vHBfySfK2dyMjln2cPS59EYlQLojTArVGCStxvXk2T9CLcJ4nqzFp5g7uJ9o
         2OjHeIOgvN3GxF/2AeDiy9a9I+VkoIAW8aefLLgqedaYsCx86FG0v3pE4r+01dEysYWA
         8O6kcme2AkqMtYb2Kq7O2fZPPBQjGW874EC28OKCX6DY4U5mpsknygnAZJbArYy4Bscv
         4oT9kUeLmGQis/UdflkN74IJU9mJGxfF9R2D4CGELJd+XegKCFiw7t8CmlskHRmDQqpC
         VHZ1l2Z08drqUZqNKSKQ8KNGGOcGWPjIjMbQemoWboiLE215K73qlONfGbOYqfaq8dcR
         4gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PuxphhtSyojHBQ+/3yS9PotueY01xJQMUnQnfyRU8xE=;
        b=uie2N/EhjgHc8dTvFyxdQ1f6bonGz8BwAK0f8IubcJY6G/nOGYQNsdxEu32SNqlnlv
         6VPdmHfOUhEcNSIYCbk8+LJrNeCVtMItH4A70jx1GoS2frqWuItO/304lJs7f6Pf1KIO
         Xuu1xgxg9DW0s//FGynNEqmq1JyZgUKRZp6RB0JP7WCVKDpQHZtp17RK6AMaZfOAFQ4l
         MlTUmVDGIud0jd+UYhBxxAc3ED66FTqc83HFL6txJ5dctuMMqdMsOVuZl8M/ZcCgTrTi
         nG/6SeY8ftb5XprKH8Cj3WoV1SzCjURy4Nl4G/bh7VFSYwKUaDm35yUSUIIz6gsFtcwR
         MmFA==
X-Gm-Message-State: AOAM531Qwuv08ZsroioU53rB7uUS7Qw8ds97oBmzZhhBnX5pYem2Z86U
        koey5d6wKEKi18hGfPyu6hNjFw==
X-Google-Smtp-Source: ABdhPJxx+3rbfd+yUOiVEOKjGCs7l/0IlgBmtPN16acGL+h8oBvpej4iEAVuQ6tFEsBGdjbE+9cNEQ==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr3282373eds.100.1647507358926;
        Thu, 17 Mar 2022 01:55:58 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm2035490ejy.165.2022.03.17.01.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 01:55:58 -0700 (PDT)
Message-ID: <181d6379-aef0-e606-a1f1-b9f986d8c14d@blackwall.org>
Date:   Thu, 17 Mar 2022 10:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 net-next 03/15] net: bridge: mst: Support setting and
 reporting MST port states
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
 <20220316150857.2442916-4-tobias@waldekranz.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220316150857.2442916-4-tobias@waldekranz.com>
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
> Make it possible to change the port state in a given MSTI by extending
> the bridge port netlink interface (RTM_SETLINK on PF_BRIDGE).The
> proposed iproute2 interface would be:
> 
>     bridge mst set dev <PORT> msti <MSTI> state <STATE>
> 
> Current states in all applicable MSTIs can also be dumped via a
> corresponding RTM_GETLINK. The proposed iproute interface looks like
> this:
> 
> $ bridge mst
> port              msti
> vb1               0
> 		    state forwarding
> 		  100
> 		    state disabled
> vb2               0
> 		    state forwarding
> 		  100
> 		    state forwarding
> 
> The preexisting per-VLAN states are still valid in the MST
> mode (although they are read-only), and can be queried as usual if one
> is interested in knowing a particular VLAN's state without having to
> care about the VID to MSTI mapping (in this example VLAN 20 and 30 are
> bound to MSTI 100):
> 
> $ bridge -d vlan
> port              vlan-id
> vb1               10
> 		    state forwarding mcast_router 1
> 		  20
> 		    state disabled mcast_router 1
> 		  30
> 		    state disabled mcast_router 1
> 		  40
> 		    state forwarding mcast_router 1
> vb2               10
> 		    state forwarding mcast_router 1
> 		  20
> 		    state forwarding mcast_router 1
> 		  30
> 		    state forwarding mcast_router 1
> 		  40
> 		    state forwarding mcast_router 1
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/uapi/linux/if_bridge.h |  16 +++++
>  include/uapi/linux/rtnetlink.h |   1 +
>  net/bridge/br_mst.c            | 126 +++++++++++++++++++++++++++++++++
>  net/bridge/br_netlink.c        |  44 +++++++++++-
>  net/bridge/br_private.h        |  23 ++++++
>  5 files changed, 209 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


