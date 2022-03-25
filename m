Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BBF4E7C80
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiCYUW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiCYUWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:22:49 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F095B3DE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Ks98cvwk3fsVLo4fkfoxCdw/C/N2RK0nNmulcPDhSk=; b=ESQfBIRNaP+D4AOsk0dZ3DmLQ2
        1Vsj/Z/RQW97O9rNhZqqlJA+84tdyLojdX3GApC7hW0UPQFCoNnnfSY/gwHBiabJgtVxgbpNrn95N
        ALZ86h/k4SQtKfgk8fK2VzEU47fSFPW9c5k88tlGaZz8wAfnp153suLA6pshwAgPK+AY11mRyGUPP
        bj8xGyLK+WWRRnX3p5d0aW5SxyZ01R7upYGB9BJjEZ7LY782glVbDzvNBeAHdVuPHAMW9zHzImqI/
        BpsUQ17B1e7AUZQe2Q8jOj7DQqkoECH9IpSULJ9J0SQyF1tBFRryIImO9UmuVEB98XcsspDldX3Ad
        8zYZtdog==;
Received: from 236.51-175-223.customer.lyse.net ([51.175.223.236]:53212 helo=[192.168.1.162])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1nXqQo-0006m4-UZ; Fri, 25 Mar 2022 21:21:10 +0100
Message-ID: <ce4b3bd7-1374-921a-2344-d55049f1a158@skogtun.org>
Date:   Fri, 25 Mar 2022 21:21:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Bisected] Latest kernel won't boot
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <934ec507-a2cb-28cc-cb36-9b07519c4302@skogtun.org>
 <70c6bc0c-72a1-7d0c-5bc1-a1c5b92af032@suse.de>
From:   Harald Arnesen <harald@skogtun.org>
In-Reply-To: <70c6bc0c-72a1-7d0c-5bc1-a1c5b92af032@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann [25/03/2022 20.53]:

> Hi
> 
> Am 25.03.22 um 19:41 schrieb Harald Arnesen:
>> See attached picture.
>> 
>> Reverting commit 0d03011894d23241db1a1cad5c12aede60897d5 fixes the issue.
>> 
>> This is on a Thinkpad T520 with Intel graphics. Config is attached.
> 
> A fix is already on it's way into the kernel. See
> 
>   
> https://cgit.freedesktop.org/drm/drm/commit/?h=drm-next-2022-03-25&id=2a81dba4b577099717cea86d429f053e85e74d96
> 
> Best regards
> Thomas

Thanks!
-- 
Hilsen Harald
