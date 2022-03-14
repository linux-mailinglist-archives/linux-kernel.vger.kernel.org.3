Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9054D802A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiCNKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbiCNKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:46:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EAA1EAE6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:45:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w4so19175117edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r3SbgvMuwSpWyo+T3+2fkvrANVSSGA2KeBMI0vAa/Mc=;
        b=2j+iM3bcJEKwZ9uQ0GbufP5c4a0aJdPJFZH7++cftGYb4uc9hqczdgnotS2iTFwHJb
         40s1RKE4GJ0yvZDGQ1F8skW+18wz1+Ddjs60vDfIK0lMQjWjzeIfz+aW7mMPT12CsZVK
         dImyN46Ms8XYA2nqjzP5RRzJLNLGlPTPBHfDTKEjTQVzaj/euYTuaHuMJTxKZascYJVr
         fcjEE3Q4QdmpnV+2dEbexMR7hOLp5FC55xHDwRr566gUc5ZNZCGIFJTvnUOyUDLn1SSv
         PmRMThfNlvodXhLEHQVmRQzaEH798W6+DZ2QYQbzp6CuWoagDEwehLxAUvFa/x8TLK2r
         RMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r3SbgvMuwSpWyo+T3+2fkvrANVSSGA2KeBMI0vAa/Mc=;
        b=JvwTkMwHHXinmlho5vnQl2BNad5GZInkzrd51HKg/KyhRyUQ1q0snwjOs/NmTHKXNW
         R+p3QgYLrjqMEOZ29w7cTf5lG4FUcjsYGPITlHgxVgihWclig3+hUPXBwZqi9qVwVXbe
         NhiQwdr5EJkzcdQvb6/r8TISvChDeaCbaJiS4QimQnJQldbs8Oz6YWvY0yhTLmgZeHaM
         WTaKC7jtugGY7/IxWK/PwQCI7X0EKaKyIB9l3xvh+bTp0Q5yPt14bT26WO+MsV3wMOhk
         cCWWzTXbqy0yAbrADnzK2vO5erTiNp6NNRCSSnleaJz0dmyRCWsPw/FHqO5A2h4CJT0s
         Qsmw==
X-Gm-Message-State: AOAM530FoXvURo18BQ58KzJ2hd0LlbRE7LjPOtFinymu5OsNc1WAg9Jl
        J8FS14Gszhjcrx9fHG/CP+culw==
X-Google-Smtp-Source: ABdhPJz1/064iHnYpmcme3MSo1mVUD0kSoK7ZiYzfHLy3RJgmGRGbmYrNcxMVl3sBsmOxT+hFFCXwg==
X-Received: by 2002:a05:6402:5256:b0:416:97d1:a6a2 with SMTP id t22-20020a056402525600b0041697d1a6a2mr19796660edd.280.1647254704879;
        Mon, 14 Mar 2022 03:45:04 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090681c800b006d9f7b69649sm6563655ejx.32.2022.03.14.03.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 03:45:04 -0700 (PDT)
Message-ID: <0a95bd84-9f1a-da44-0e70-a53e3b7402db@blackwall.org>
Date:   Mon, 14 Mar 2022 12:45:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 net-next 02/14] net: bridge: mst: Allow changing a
 VLAN's MSTI
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
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Cooper Lees <me@cooperlees.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-3-tobias@waldekranz.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220314095231.3486931-3-tobias@waldekranz.com>
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

On 14/03/2022 11:52, Tobias Waldekranz wrote:
> Allow a VLAN to move out of the CST (MSTI 0), to an independent tree.
> 
> The user manages the VID to MSTI mappings via a global VLAN
> setting. The proposed iproute2 interface would be:
> 
>     bridge vlan global set dev br0 vid <VID> msti <MSTI>
> 
> Changing the state in non-zero MSTIs is still not supported, but will
> be addressed in upcoming changes.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/uapi/linux/if_bridge.h |  1 +
>  net/bridge/br_mst.c            | 42 ++++++++++++++++++++++++++++++++++
>  net/bridge/br_private.h        |  1 +
>  net/bridge/br_vlan_options.c   | 15 ++++++++++++
>  4 files changed, 59 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

