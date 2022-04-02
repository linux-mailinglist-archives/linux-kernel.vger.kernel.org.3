Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D74F0648
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiDBUtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354329AbiDBUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:49:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA02D8E1AF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 13:47:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u9so1624061edd.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=g31uGSPwPMWewxfQR13fcVJH7Aw4CAneBT6TuPz0pyw=;
        b=GkFVdk4CcIgbip16DYwzTk93slGlP4VxK4SjUKxFM+RSwqm+odkuGpwemzBxpL5e/d
         +k5bNxJU3h1RkY19XdzPABWBUop9L120f2EqmM8zbHC99RMheR2usvUpQght/mgURWga
         OcX+XsBuWOBBZTrCkmWk6xjRqb0cv5vhNkRLHZesnMwKTIE5lYC0dDKcMBZRVzBSWvEk
         ALLZ5RXpVEgU3VYoJmt5BaOON7BXqpM0H85FplGN3UjGvYxC4ygHc7CTx9TVsJh9Kvl4
         uqfZRntJ+HDuNLzDxOT5luEaGd2AXjv46zUTAsdgU1Ka/c1UzonGHQKt8lz+KFPj1Rnz
         14fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=g31uGSPwPMWewxfQR13fcVJH7Aw4CAneBT6TuPz0pyw=;
        b=qxUwGBm/uh6yCZRwfXMJhp5tjHDkA3E51p4AmSmmzAkrQyw9yulCFizYJ35jaLOS3q
         u6dZaCnGdw76pmDHZzk5HwklKzglYxGBYilH0FbLRrDRbUKcjJllsWwuVs0OAYUt1P+A
         zEFZkUm0HRncmicytPBL8RCW8P+Absz7FOiWmDHDFFIpQSq6yRaZ6GcTZxc8ndtCpzCb
         CIKqFFB3UTmeEH8LjV0COQYm597AeeONJ82kdJui2XBsT07kLMI/asUZfhAHOOpjBv3O
         y65sCN+e1tICNH+xPXy+VboQiIaXgcTRxbBSPsRB6nDAnSDOLVvMkFXw/fJxhkZlZ0wy
         V1GQ==
X-Gm-Message-State: AOAM530ZceLXkbqmE0LecGOciecbwvHAw7vLow6oWv4bxN4D2cn/T+w2
        Wi4yKQ5ZNX1CK7SizQatCoQ=
X-Google-Smtp-Source: ABdhPJx65AtVjYJPqt7EjkR34GR2H20ET2zuI1GusFwr0yE3N8N0vgIomKhPw6h20J2TnplqfTB00g==
X-Received: by 2002:a05:6402:1753:b0:41c:c12d:c1e2 with SMTP id v19-20020a056402175300b0041cc12dc1e2mr331748edx.227.1648932449322;
        Sat, 02 Apr 2022 13:47:29 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm2505910ejc.25.2022.04.02.13.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 13:47:28 -0700 (PDT)
Message-ID: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
Date:   Sat, 2 Apr 2022 22:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        straube.linux@gmail.com
From:   Michael Straube <straube.linux@gmail.com>
Subject: staging: r8188eu: how to handle nested mutex under spinlock
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

smatch reported a sleeping in atomic context.

rtw_set_802_11_disassociate() <- disables preempt
-> _rtw_pwr_wakeup()
    -> ips_leave()

rtw_set_802_11_disassociate() takes a spinlock and ips_leave() uses a
mutex.

I'm fairly new to the locking stuff, but as far as I know this is not a
false positive since mutex can sleep, but that's not allowed under a
spinlock.

What is the best way to handle this?
I'm not sure if converting the mutex to a spinlock (including all the
other places where the mutex is used) is the right thing to do?

thanks,
Michael
