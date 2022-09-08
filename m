Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A625B130B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIHDr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIHDr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:47:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B0B5168;
        Wed,  7 Sep 2022 20:47:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t3so11495503ply.2;
        Wed, 07 Sep 2022 20:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rHs4Gl+LZ4SKG7rp6Hq8oD1WQIrgZrfFe0OMr3ZxLeI=;
        b=Dl3nTnVHvvWqhIGA6bXc562DrIpQhDrBnUOrGeb1z8IcmOUeyV4XZ7JAq9vngw5du8
         YUR6ruWyZXWoG4YR+PV9ZHcInEihxhNdLcuNRsUstX1iz51w3cpK0rYoXS7a16q2hzjG
         wa67mWZ3LF1vMJ7FMkjvDcF8Eha8DxcLjPEK6tWCmsDeSzOyYBKapsXdg8gJ+Pr55rt1
         6eYVwrAXlnGu4Pg2eQXJQkHx77guvO4X7n2a0jhQcIxXv2u6cocsnsEtbz6SBYX/Iyv9
         c9e5AVucHSmTqQAHWN0CFo3qebFHLOyTYpcAwOu7c8i+P4HkpQ13FnNIm3nD0qMv+B7H
         eKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rHs4Gl+LZ4SKG7rp6Hq8oD1WQIrgZrfFe0OMr3ZxLeI=;
        b=w8dGdlo3bpWC1N83mhgdMumQ5Sh7h4D+CTd8yH60afHn5xk+CqNAa2wr0S0/mLRiw7
         l3N7ctXIw7abpkFd7GjXvfUCSrjUSZ1Mw69cRZuqrd3zcqxGdNzzGwTBq0+uoS/Ulzw8
         md8UTDsFWVtH7Kr9Wc541KZhMOg5wqTVTehyYL4LQ7V5q8c1GecegdTNAUqwxW2+Pb0j
         6xSOblGjTBMmApnBYKRcxf0HxBH6lDjHQ7MmpCqd/iyyDqy6bPZeW6AeEeGU3UepbJoX
         9z1NcoBcv2fOqLhuNlSWLOFaJw2hpe4Sf9OsiSe0RNtopnIdVEzVyfvdyAFyyMUnQMqr
         n3xg==
X-Gm-Message-State: ACgBeo3CuUrnT1HUI8ynADtvsRJ3H4zzajhqyPFhC5wpzTUyhN0hP79E
        0UdLymBNbNt/VlztPa+MAVGd9/TdjJY=
X-Google-Smtp-Source: AA6agR4WAonSmTYWvLoRLPLxdUxb+JfmCpFfXDyMX+UQMP9B3SMuG1Zq+nRyno1WTPr/CHUCinTtjw==
X-Received: by 2002:a17:902:eec2:b0:177:f1f0:88ea with SMTP id h2-20020a170902eec200b00177f1f088eamr1678125plb.145.1662608874991;
        Wed, 07 Sep 2022 20:47:54 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-94.three.co.id. [180.214.232.94])
        by smtp.gmail.com with ESMTPSA id b130-20020a621b88000000b0052dbad1ea2esm13521925pfb.6.2022.09.07.20.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 20:47:54 -0700 (PDT)
Message-ID: <1b30d814-3570-1cb7-573b-9bca90d5d3fd@gmail.com>
Date:   Thu, 8 Sep 2022 10:47:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [v7 00/14] Add support for Bosch BNO055 IMU
Content-Language: en-US
To:     andrea.merello@iit.it, jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, andrea.merello@gmail.com
References: <20220907132205.28021-1-andrea.merello@iit.it>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220907132205.28021-1-andrea.merello@iit.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 20:21, andrea.merello@iit.it wrote:
> Differences wrt v6:
> 
> - fix some typos.
> - fix some style issues.
> - get rid of ifdefs for CONFIG_DEBUG_FS.
> - avoid pushing data to the IIO layer if we actually failed reading it.
> - rework debugfs file creating failure path.
> - fix errors and warning found by kernel test robot <lkp@intel.com>
> - rebase

Rebased on what tree (and what commit)? I can't cleanly apply patch
[05/14].

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
