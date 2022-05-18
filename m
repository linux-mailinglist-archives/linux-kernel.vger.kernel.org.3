Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4B652B308
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiERGux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiERGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:50:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08882314E;
        Tue, 17 May 2022 23:50:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso1166626pjg.0;
        Tue, 17 May 2022 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dJi7DyL08jLb0JerJmEdQTHN+3oTFu1F6uZ7CfAP2l8=;
        b=QoWjQpN4B1ybyGss5uqphvodb+BZPe7VNEv34NpKZEOkctrmfA7J/H+MPSjRNAigod
         jQB14L5lTX9KRToUQEi5L9UsCtPf3xyp4GOoV5vdEAeoyqfiq7+ZFVhFia1ExbBTi1FB
         Cjs8dDBhqoB6HeB+B7mTUBTfdBg29YYKDu/WDjRSIJYob9fOxiD1xKWw1sSsu4317HSv
         tDYtU0W73ehiMsPR1k05QaMPrxEi3OcUc0gSRUGEHB1MmAPcT5CsTFDRETFGAmCrxrUc
         7L6Z3u1GwltF9nBr7MSB9a37E5tOtvWeElzsBWeV63MQtl0P4D13Q5Ymnbk+wxDaZnfq
         pBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dJi7DyL08jLb0JerJmEdQTHN+3oTFu1F6uZ7CfAP2l8=;
        b=3YpTeux8Q2YxrFWfhnE77gl5Em3lxNFM/1PLce8i7CCcXqHfQ4c/QqRV32zv/mqEQ9
         aLG3g8exBEUHPD04f7iaOwgp0QHWH3cW/DoTtO3d+WSusV+g+UGEQXGH+BYujryOCPia
         Hx0fSAqFlKNr2U6/Oh3Fteqa9bqpVcZyJXYPI+WsAczB1sVpZUOoohsNpjPza88H1knR
         aK96D4wp9PHNJhwVq++xd67nAkQA89WCPi0ikASeAXT01/HagEz6oN4R6fPLAEvOeVrs
         HmoKBy5G4A54cMpn7GO06Ttxv+fYc2PszNveU2J3rvgzA1DRtWo0+B39omPEhJ58PgG8
         5D8w==
X-Gm-Message-State: AOAM533jVz8Tk+FinGvKkwr/TvENfxFNmQwrHjMumQuaPG2BNBRpyDzN
        jKLEzopQLwL6+SnOYNrhZEo=
X-Google-Smtp-Source: ABdhPJweIjKiVSRSYmEAghlVfkmU36X6uzXxS/q8JyZMABQpv9hL8DzRYEz3YmZnwUQMuLfEN7PmKA==
X-Received: by 2002:a17:902:82c7:b0:161:4936:f068 with SMTP id u7-20020a17090282c700b001614936f068mr19888302plz.145.1652856632366;
        Tue, 17 May 2022 23:50:32 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902a3c900b00161b50c3db4sm786019plb.94.2022.05.17.23.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 23:50:31 -0700 (PDT)
Message-ID: <2816e961-08f9-407b-e8f8-b63f844d864c@gmail.com>
Date:   Wed, 18 May 2022 13:50:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] platform/chrome: Use tables for values lists of
 ChromeOS ACPI sysfs ABI
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220518031750.21923-1-bagasdotme@gmail.com>
 <20220518031750.21923-2-bagasdotme@gmail.com> <YoRp/49OA9tqMd9N@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YoRp/49OA9tqMd9N@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 10:37, Tzung-Bi Shih wrote:
> On Wed, May 18, 2022 at 10:17:50AM +0700, Bagas Sanjaya wrote:
>>  What:		/sys/bus/platform/devices/GGL0001:*/CHSW
>>  Date:		May 2022
>>  KernelVersion:	5.19
>>  Description:
>>  		This file shows the switch position for the Chrome OS specific
>> -		hardware switches.
>> -		  * 0   - No changes.
>> -		  * 2   - Recovery button was pressed when firmware booted.
>> -		  * 4   - Recovery button was pressed when EC firmware booted.
>> -		  * 32  - Developer switch was enabled when firmware booted.
>> -		  * 512 - Firmware write protection was disabled when firmware
>> -			  booted.
>> +		hardware switches when the firmare is booted.
> 
> s/firmare/firmware/.
> 
> Could you fix it in v2 and also Cc to <chrome-platform@lists.linux.dev>?

OK, but regarding the schedule, we are on -rc7 (official mainline release
will be imminent). Maybe I can send the v2 immediately, or should I wait
for a day?

-- 
An old man doll... just what I always wanted! - Clara
