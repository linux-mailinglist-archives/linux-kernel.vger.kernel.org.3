Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5C575B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiGOGDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiGOGC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:02:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40087A53E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:02:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r6so5006872edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=144ZJWV5RjQz+UzM2njFcIrCkknpd4SwL00831ygP1Y=;
        b=jbvS9DWUzl1FDvZKC+P0KSY2NMQGLYCtYB6QXnl/IGcvmIr04gst0FLgaP07bbBKst
         Xeul6Csml8dc4wTt+rKiSUvv7BzQIHfQxe4LQQpE7+JH1+e771MKL0xwuIFnpioDhmQx
         xn04XCNaApDd7s97UV1gPwR5/7bPavLHPIDsHU2ZZPgBIFvqL8mVwFUGBpdPgghVglRs
         7+lvpuvvyaqvQ7rjq3tqAHd2vqOHJikWUxePgsuZWXHB1rgQ7MLt6MvP3b8OnF/D+fRJ
         qmXoULasfIrxQsYKFpYCWzRYW1xe8ijyocL5CxNKu7utSj7TnkZidSx3X/vYNX3mEiv2
         1BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=144ZJWV5RjQz+UzM2njFcIrCkknpd4SwL00831ygP1Y=;
        b=m2lGxbk61OuO7xrFNLzxML9aIxqhjzzfemeIHYFGZlbTF9H+H1yU9DJhCKBUI8M8rh
         o5+a+6Pt/DYGnWuiOj5AvmgBpRtfFpwPNHs84fD6xJw5arURfXPPY0FRT/Z9PA1Ibzwu
         TvbnEOfvELr/Txz+YJO6IkXPHSY9o14Acnk3myN6hh8ZGvw2sQP+B3qERXCpcH971smo
         QoAbaUJUc9F3nVrofGt3Hk84/1s/TOXTj20QDEFhpIegvpLvBIIJlRhN76skMKGZFZnt
         JMay5xP+4g3wLmp9Mo/+9OXoWVWfooFK+iqaRQNtmRAGmZ1LWJFrYq7a1dzaKrdK5m8Y
         4IvA==
X-Gm-Message-State: AJIora9Hkenir3EQTCSVayh6rfJaxSumeF8goSNRzOzM9OOqqzatMtww
        jAbK67eU8Tp4tig+GvodK3Q=
X-Google-Smtp-Source: AGRyM1uI36Bk+qA7TtylAqmcBXv0W6J3C1zu3YCCZg7kwhWrN0NbqGzWhM7t4fJpcyOhCm2q+25BTw==
X-Received: by 2002:a05:6402:d0a:b0:437:66ca:c211 with SMTP id eb10-20020a0564020d0a00b0043766cac211mr16876254edb.29.1657864977402;
        Thu, 14 Jul 2022 23:02:57 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb91.dynamic.kabel-deutschland.de. [95.90.187.145])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b00726298147b1sm1594112ejg.161.2022.07.14.23.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 23:02:56 -0700 (PDT)
Message-ID: <be6d3fd0-566f-00ef-1404-830176d56e98@gmail.com>
Date:   Fri, 15 Jul 2022 08:02:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r888eu: use dynamic allocation for efuse buffer
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220713075804.140986-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220713075804.140986-1-martin@kaiser.cx>
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

Hi Martin,

just a typo in the subject line: r888eu

regards,
Michael
