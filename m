Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDABA5A3883
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiH0PwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiH0PwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:52:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BAD2F653
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 08:52:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gb36so8097315ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 08:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3YczR2Egl4ZFRyscdYYWi5wk2fHwMzSOUnVWfHdBreM=;
        b=XzCjQYL7pcKNpZS+XZ/jvaKcz044RvIp2Kqny5OT1idIVch+NIlfnHsadgKWYFDb0E
         LrNd0hKaoyAkJgnlUbgT753luKRo2WarLndU46VH401AIJex/4AHi+GjE2AERqIw4E67
         KcTGvWm0Cb47y9tZiiVeDXe5aGt3zgsJdX1yvhdGB9sF/Z6qTtvJ64moVxFbEZ3rr5yl
         pikp+Km8ABi40dgWtLH8Rsk1foqkvANAJBLYdZG/VUu8A9htUuS+ZXPGuaLcw/QxhNIa
         TflL902OKXy2G0jqaGBSpTTwIag6f4IKoc6DsHiVXpu3AccPpZkYXLscSaqqcDhfEPOK
         8xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3YczR2Egl4ZFRyscdYYWi5wk2fHwMzSOUnVWfHdBreM=;
        b=oFfNkcId1hmCiDqLRladv9Ru5Pp9Z968bEWfjA8yI0lf++jVYc97o+MtWTY1FCzXU3
         7b8i0LBBVuRjpoG7lg9ds0TPye9ynyNe3vaj7dAn/xVEyo9zwJqhOKR2AP0DNVrHz72R
         Jt1MEqT9PKl6cJ8MYMvQHbSgMiy23KqcgWqOx4l+4ngkEZNUrn4bNs6HCLnkIwoFBr0o
         SIY7c/g9UFKqKwkQwicf/uClw/FQtC6MxjknuVUU1zf/2S+lGyvwtVsvepOmiDc6MLMt
         GkF0LMICPZ6l1yZMsrKnqQfW+Os6yQKpoLDeuLER2UPTufD6Uax1ISvGDr0DR/+lJdLd
         eVWQ==
X-Gm-Message-State: ACgBeo2hrhkmMy2GmFDpunGzLzpSE0li9D3u0QpSiOLP4yZs40kWfyyJ
        /vXUEyXFEbu910FmDthhELnmgA==
X-Google-Smtp-Source: AA6agR4UGFSDEBI+Zywo6Rd/RBwcZqB0s8dtcq4AUgPmhKGokDX6cNXLGrVlY+XIvgUPkPzXaFkbVA==
X-Received: by 2002:a17:907:724e:b0:740:e3e5:c01d with SMTP id ds14-20020a170907724e00b00740e3e5c01dmr4496051ejc.38.1661615530225;
        Sat, 27 Aug 2022 08:52:10 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a05640235cd00b0044847e0e8ccsm257324edc.28.2022.08.27.08.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 08:52:09 -0700 (PDT)
Message-ID: <80c8a02f-95b9-8e96-b05c-016b43876c15@blackwall.org>
Date:   Sat, 27 Aug 2022 18:52:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 net-next 2/6] net: switchdev: add support for
 offloading of fdb locked flag
Content-Language: en-US
To:     Ido Schimmel <idosch@nvidia.com>,
        Hans Schultz <netdev@kapio-technology.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yuwei Wang <wangyuweihx@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-3-netdev@kapio-technology.com>
 <Ywo8PONgDW/lUj+X@shredder>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Ywo8PONgDW/lUj+X@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2022 18:46, Ido Schimmel wrote:
> On Fri, Aug 26, 2022 at 01:45:34PM +0200, Hans Schultz wrote:
>> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>> index 7dcdc97c0bc3..437945179373 100644
>> --- a/include/net/switchdev.h
>> +++ b/include/net/switchdev.h
>> @@ -247,7 +247,10 @@ struct switchdev_notifier_fdb_info {
>>  	const unsigned char *addr;
>>  	u16 vid;
>>  	u8 added_by_user:1,
>> +	   sticky:1,
> 
> If mv88e6xxx reports entries with 'is_local=1, locked=1, blackhole=1',
> then the 'sticky' bit can be removed for now (we will need it some day
> to support sticky entries notified from the bridge). This takes care of
> the discrepancy Nik mentioned here:
> 
> https://lore.kernel.org/netdev/d1de0337-ae16-7dca-b212-1a4e85129c31@blackwall.org/
> 

+1

>>  	   is_local:1,
>> +	   locked:1,
>> +	   blackhole:1,
>>  	   offloaded:1;
>>  };

