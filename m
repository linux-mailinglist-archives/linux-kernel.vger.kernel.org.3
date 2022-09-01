Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0695A8D66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiIAFcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiIAFcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:32:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8584B4A1;
        Wed, 31 Aug 2022 22:32:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x23so16099562pll.7;
        Wed, 31 Aug 2022 22:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZEf1OKeDEA5V5Dw4/dVFv1v3HHH3zctUJHUkfHz+FDw=;
        b=H5WY6xYS9QdIcDtuikUyl0kkaW2Gr6ukBwxpISk66kmJtE1fRufGYNYMxCtC1d8ay/
         HJt0QRq2KDaboNrCxGPvMeypkYtRtJU3+Q7QnKWSI9aSM/bX7keMFBXIapevjexsZv5o
         3ozD8iaupvfV22rgdkTFtF+lh5uhCcxlMEYkTq7t4jwHMp2XZUjeeNqkBO4leFV/3BG5
         1I7YGGN4/d3TnAtzl1+lPz0tM/tkLMnnB2Da2l3lzbwciClyxNiqCBuqa0QH9Eb6tIR7
         CMcSqaxhs12qn46D5vd2UDA36URK/7aIopsDVF+XkMAbySYxHiF1tWHx7TSK9Sw2KxzE
         BPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZEf1OKeDEA5V5Dw4/dVFv1v3HHH3zctUJHUkfHz+FDw=;
        b=3NWOWgBid8INr55in9LGZ674HBE4jYnozWxebZdcg4EhVpDnmh5lPEP3b2aSj0i3R8
         poo+xF1I45L2EMxIoKGyF/DDTDIdQTDMl/Il/P7xzp024hRawd++4rn4rZ2UydPzfJy9
         mhM7qwlk261O+/ch6JW2EybaaiktrguyTkqDGdrbelLM9kDZnNGZN0X1OUlIDgauXsEf
         MbXRTuqoI5kWP7bAQjp6YT00APParo4i7Cy0vJLEz9Bv9/+lAV6v0RlD9hW54/GMXURd
         znU+A+unN8ykhHwUd7ykTBYIzgTzfVfRhY7VqdJGPWsrZgJA990Wc/MAWdAYOTDULq67
         pYvg==
X-Gm-Message-State: ACgBeo0/zoqzfcEN1FuiJ1My6hglTMlmDq/qtahd9IFcVVmfX5thxvxO
        98wH27o0ebsQdTSMayM0vnI=
X-Google-Smtp-Source: AA6agR4a4BJBASaUJhejO4S+45wUhdPSY3UUm2AJJGOMSWK30airlcBsnk068K0Xi77YQ2z3gfn/iw==
X-Received: by 2002:a17:90b:1b12:b0:1fe:b98:2c42 with SMTP id nu18-20020a17090b1b1200b001fe0b982c42mr6867260pjb.184.1662010355274;
        Wed, 31 Aug 2022 22:32:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 18-20020a631252000000b0042254fce5e7sm4358271pgs.50.2022.08.31.22.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 22:32:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     mathieu.poirier@linaro.org
Cc:     bjorn.andersson@linaro.org, cgel.zte@gmail.com,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        ye.xingchen@zte.com.cn, --cc=zealci@zte.com.cn
Subject: Re: [PATCH linux-next] rpmsg: char: Remove the unneeded result variable
Date:   Thu,  1 Sep 2022 05:32:31 +0000
Message-Id: <20220901053231.312211-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164632.GA217472@p14s>
References: <20220831164632.GA217472@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

In fact,‘cgel.zte@gmail.com’ is our company's public mail address, and ‘ye.xingchen@zte.com.cn’is my personal mail address in the company.‘ZTE’ is the name of company, and ‘CGEL’the name of our project team in company.

For some reason, the patchs needs to be reviewed by the company before it is sent out, and we have to use public mailboxes to send mails, because personal mailboxes are not allowed to send mails.

Because it is the patch I submitted, the mail about the patch will be sent to my personal mailbox through the public mailbox.

 
Thanks,
YE XINGCHEN
