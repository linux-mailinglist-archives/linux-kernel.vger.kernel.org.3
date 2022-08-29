Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A697F5A4583
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiH2Ix6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiH2Ixz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:53:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859E05A165
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:53:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q3so4095966pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sQndcbd/4ZYZe6Nc6MH5lVEISrMVYZdfCyCWIbSeX1Q=;
        b=IhDVnYT4ZAF5L+N1nyfslPMCUlyBgmIPIwxsA1mxHly1boJSkIDRAQz4yNvmdp3cki
         vlK6sOljnAEi9KVsac5CaNSZoMcb2tqKz8Ky6zPwa6I00iAZkrWbkLIn3rmu/fYgqguo
         GRAhK0x2Zkr8Zjb3QinLM75UjCRhvkPei5xrscLVvEz3WODT6m3hyjsXN2q5okuwUGbv
         1NQocxfblQ86+8i68V4G6Cer+YPMklpLu67COzVGKimwIf6IK6CoLyzKXSY4edgg15jF
         /ESF5v2Kb+awn4L1GpsHrZ4e5pYcO1u+lQKy2t/Mbd/4azEflTuWIagAF7GQeSmHisM4
         DVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sQndcbd/4ZYZe6Nc6MH5lVEISrMVYZdfCyCWIbSeX1Q=;
        b=uyfnhPNn63XLnLoyIvrjs/A3VZ5vgzc1AoZeRj90JZmDy3KCQwe4bJoCtKYbEv2/7V
         277F2FyNSaVinDh82adhfEOhj88x9OpZLnUR0a1SCII1EWV/eDqpzS1sZG0Lj9S6OIMD
         EQDUTN41G2722FCBkgPvijv1vGsLOA1ysGKJolh0G4Fxjz/nwM2ijYtVfhbJ3YIev+wi
         /gQ5cylBrZoWgHDvWqggHm9bMHdAGbKCy3HcfSK9mc684WRjOPiPQa4RcJ7XOhuJP0AQ
         JkqoRfDQYx0PGOJpmmobDeMPm6KubB3O0XOWq6zq1mgHtKJRoV4TWwBQIcCu72hEW863
         phuA==
X-Gm-Message-State: ACgBeo1qv0Pt4SCA0/C2PbqF1vZxJX0rqvB6M25mqRDT0xGRweJqUnfx
        KX7lkoUXugSJwNSPvwObGSM=
X-Google-Smtp-Source: AA6agR4ZQpBcinBoxMBDp+mBq2ssCJ+m5Kni0tbvDpvnToLjLBNVJ4NIfsAELN1luUpYNnlakxiP7w==
X-Received: by 2002:a17:90b:4c08:b0:1fb:66d3:79c with SMTP id na8-20020a17090b4c0800b001fb66d3079cmr17210223pjb.121.1661763233010;
        Mon, 29 Aug 2022 01:53:53 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-33.three.co.id. [116.206.12.33])
        by smtp.gmail.com with ESMTPSA id b67-20020a62cf46000000b005364e0ec330sm6686498pfg.59.2022.08.29.01.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 01:53:52 -0700 (PDT)
Message-ID: <abb075b7-ae5b-f4e7-7a77-cbfd7788406a@gmail.com>
Date:   Mon, 29 Aug 2022 15:53:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: One of reviewers and maintainers for checkpatch is inactive
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM and miscellaneous subsystems list 
        <linux-mm@kvack.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <YwwiP7Erud6Ns9mu@debian.me>
 <2a870057af3d5c3b0fa6256fbc67c32e1055df06.camel@perches.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2a870057af3d5c3b0fa6256fbc67c32e1055df06.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 13:01, Joe Perches wrote:
> On Mon, 2022-08-29 at 09:19 +0700, Bagas Sanjaya wrote:
>> Hi,
> 	> 
>> It seems like one of reviewers for checkpatch subsystem, Dwaipayan Ray
>> <dwaipayanray1@gmail.com>, is apparently inactive with his last post
>> about a year ago ([1]). Maybe remove him from MAINTAINERS?
>>
>> [1]: https://lore.kernel.org/lkml/CABJPP5Bpc_0c=b8kymo0fgXZARNZJ8EM5F=Gpx1=y+vOfPWM8Q@mail.gmail.com/
> 
> Too early.
> 

Maybe we can try pinging him (off-list) to see if he's still have interest
on patch reviewing.

-- 
An old man doll... just what I always wanted! - Clara
