Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3355429E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiFHIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiFHIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:51:57 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B026EEB5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:09:29 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-f2e0a41009so26290096fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+MMD21NPgOfS4IM7Z40OZnUQr5CdKWtzJx16Y8c5lj4=;
        b=nLkPwpCsFWCdSyyriJWdU7K9NnAY9DMXz2vxLPoilFBQnN5Vf7Jr17b5AI4FryypkC
         CBEPZ+OYSWkAm3gTy3Wi4TfmB+mWRclLHrwGywod8DusEz2uz3E0TSdxBPNDSILCc2Yq
         Ujqutye6DLuW1jMagA4OzYN7furJcYnH4HB9vuVouxIIy6kXuOAZZz3sYkpNV112rGXe
         bfoZfllXWX9/yiEXlDsShmfFd+zStw64GNtZKta+boKiIRvuH+UioiOT0E3ypS4ZRwKK
         T8D47ikdDZG00SmnFtJpCw63/kge7mHD9fyy16mJXoTF9NISSDTId2RWuurS1zKs1P3t
         Tn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+MMD21NPgOfS4IM7Z40OZnUQr5CdKWtzJx16Y8c5lj4=;
        b=EZreYyxpT7cyZqgKjxkn+IBd2Qg0IxvK1knUyRuCs33Pz7KydI/+TaQHZrcdyv/gvZ
         FHkIwofXv7wTC936YtxLCt6WtsBssC0FaD6kffOq3R+5wk8SPX14suvR9AAgCD6RWIbq
         62w86PAcIFONEljVENoyMUYlyMMppPYu9AgSlJJowF6fLUBxOO2epvmLw1RdX6M/5r1z
         dylewE/QQnFGIqTSmyDcN6ha7u6bSvrNx9eEY8wBiYrubiOqtX76dBdwIKSkwybSeUib
         2ccD4WQii+yw64eBf9N0yhXzaHFWwmCJ5jE/yFZJiJSAIcYszfJ0u26jDXQeJWfFJ4VG
         rptg==
X-Gm-Message-State: AOAM531fsIns5avjJFh2AIklAvPb1cA5LdBXojEZWUJqbvxzO4CuY3fC
        SukjMoZBXByLCcm67mcGl/PBUYGSG7Ck2X73
X-Google-Smtp-Source: ABdhPJx9i9bRAxE/hgST/uEDns41HlY0VQPP2LJmKUBRajjCi+cPxt/fmt3SUADALQO7okgUyrAkyQ==
X-Received: by 2002:a17:90b:304:b0:1e3:4285:ce1e with SMTP id ay4-20020a17090b030400b001e34285ce1emr37276571pjb.71.1654675344879;
        Wed, 08 Jun 2022 01:02:24 -0700 (PDT)
Received: from [192.168.0.24] ([88.126.57.132])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b0015e8d4eb1c6sm14166232plx.16.2022.06.08.01.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:02:24 -0700 (PDT)
Message-ID: <7c6cd8c3-dc1f-5130-19d5-00443ee56bdd@gmail.com>
Date:   Wed, 8 Jun 2022 10:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MAINTAINERS: Update BCM2711/BCM2835 maintainer
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>, f.fainelli@gmail.com
Cc:     stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220603073012.30979-1-nsaenz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220603073012.30979-1-nsaenz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/2022 9:30 AM, Nicolas Saenz Julienne wrote:
> I haven't been able to find time to maintain BCM2711/BCM2835 these last
> months, so it's only fair to pass the baton to Florian who's been doing
> the work.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> ---

Applied to maintainers/fixes, thanks Nicolas for your time as a maintainer!
-- 
Florian
