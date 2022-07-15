Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAD575B30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiGOGGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiGOGGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:06:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA6481F6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:06:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so5004598edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=NrPyiJ6zYcV53GOx13yfEhBQnfJ0RCuGsOxgnDEHyUw=;
        b=HKtmmWvzYPan8/QiQi8tWTPbhSZjo7IEdS3mKD+irpEt3Edpn8phLNHMh6Kx+ONqts
         14jMlVsyLiQR5Afc6yLEpeCO2IsW9Rp9KUj+yVkW8GrGt+pTWl0ltF8XH8mfIuNTKK5z
         44BoAmCGgdcCbxIG6UFG5Z1lhTEPUUBvgYLx9MWf+AN3+/4N10kEix6Mw4Sfy5m81LCz
         aDWfY0IHxpttxEaukmLy6Xx/Ohs+mRpOZRbOaeqQO93GsVisncLcdDFvz+UwfzWMH52L
         cdHxYkt/9RxCb6KhAkPrE4GDxNkBk63mw88w9V27tIQ4nN2/NncqhjCC9sXcXvOWNd8O
         GeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=NrPyiJ6zYcV53GOx13yfEhBQnfJ0RCuGsOxgnDEHyUw=;
        b=jAvi5V8c8WL+nKTvYhHHVDEA9yXu9/NjCEO9uVugXXNSslBETMDsYTZY1nyzgYTiCa
         ospldAWhmNqrx0XdulmDLtGHLhPu5PIwMhD5gL1WeGmZ+YnfVrEp+gCqrnr3r5oQKGRq
         N9d654iDVa/Y9gMz2x7SqQ83BkohVeW7g4SNDwSTewTvQgkgbuZE8Q02buCJW1r+ZkSm
         +Txu/sBQbazZYSfraNMT8RmUEgBFjAR1jg/ZXuVV6RcjVVnINPXYS6U+MpMfGAgt6try
         2PIufkKb5ZtPX7eti+T+Um4+GoPpr4X7dHklydBmUl1mCZgduprBd504hyrNkLbWrhYd
         jIAw==
X-Gm-Message-State: AJIora/C9WZO9HIq07QSsVpHn2n6iU0AtC/I31UqQHMBq398smYbC2UH
        rydhywh7HcgUY0EKAx8bkTUbu4nBm7I=
X-Google-Smtp-Source: AGRyM1vAhXgE641OJlsXfz1E9GgQa/F4HihZk1Y8cyKbou2Kaw1nI4ekXG3WcmeV3M+bu4az0uljcA==
X-Received: by 2002:a05:6402:3689:b0:43a:7c1c:8960 with SMTP id ej9-20020a056402368900b0043a7c1c8960mr16507423edb.79.1657865194052;
        Thu, 14 Jul 2022 23:06:34 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb91.dynamic.kabel-deutschland.de. [95.90.187.145])
        by smtp.gmail.com with ESMTPSA id o1-20020aa7dd41000000b00436f3107bdasm2220934edw.38.2022.07.14.23.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 23:06:33 -0700 (PDT)
Message-ID: <772c4b9f-484b-3b05-b130-7069ec39b72c@gmail.com>
Date:   Fri, 15 Jul 2022 08:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r888eu: use dynamic allocation for efuse buffer
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220713075804.140986-1-martin@kaiser.cx>
 <be6d3fd0-566f-00ef-1404-830176d56e98@gmail.com>
In-Reply-To: <be6d3fd0-566f-00ef-1404-830176d56e98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 7/15/22 08:02, Michael Straube wrote:
> Hi Martin,
> 
> just a typo in the subject line: r888eu
> 

Sorry, I did not notice that this patch is already applied.
So nevermind ...

Michael
