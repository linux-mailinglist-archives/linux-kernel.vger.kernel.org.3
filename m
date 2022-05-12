Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508C95258BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359631AbiELXuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352431AbiELXuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:50:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45A0281378
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:50:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso6036788wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=jr4/0/MGUlo8S2OYojHgJI0gKhk83jVk4irn9DDwDo0=;
        b=kEqGmm988Py1bNsl8XrWH0xMhXxRuUDL6s2HD4vrGoy2YcxLoJo+0eNjOUG7fG61Qr
         /o1kddHGCcV1RSGzpffj3WYjrlaPXwJvjUhoVhnk5q/kFVUetPJ/4nnPgXK/Uu75lelf
         e46QqsHuE4eYfsOazjVqKv8lC4LowcWdCEsLFc5KOBlkZgiXQ2l+rehfLWB4ykm/k92E
         VXV6YrI7ODM/3DMurxzBgc8kB2UEOFW2wxknI/CbEcWw/Mh+m2CkzWh0PxMrTbVG0ujt
         0q6FwkG13BFORSdLUDc4RINP05N42Cz4cTh4cE6pYyHOOU06cIoR+0PFEDhRhGuV2dqu
         kRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=jr4/0/MGUlo8S2OYojHgJI0gKhk83jVk4irn9DDwDo0=;
        b=m8v+i+Yq92KQ3L/72RBFK3t5Hi6Uv+sKUgy60CaEt9ts0vKcLXhyV83ok96OgnqQm+
         oOXIfyAqz1bnrEbf2hq1Dff/2XvIB6Fn3u4aCAlxbWkZgFTTs9TKQsrrxu0BT1T5cE/R
         5X2IWhfNCo3SKav8hpDPsKOpa18cEZbXGX1cGG5lPEKZbY80tNjRJVBJqH+2pRn473ho
         VyD46opVShOW5DTYEpkr9tBZSbZEUhBO5C6hpK6czMRgTvTzUeLL6aI71tp0rd6CMVAz
         0GhmZ+CZefn8SNocoga0UP++T5IQEicYr/Dm/CWRo3GMtMLYXtLauU0ceS6U3Tfup9vL
         fR1g==
X-Gm-Message-State: AOAM533wiXS0Sn1s4lx08Rs70XgOogcqGVTuErUvvnQi2XK/+BiR9/RR
        gkyHDVoeAN1zCGuRtLO9qOsUE7zutjY=
X-Google-Smtp-Source: ABdhPJzMBidQIk2PCAIs1x38aG9cEJtu9UEKtWgGnxw3UbBvMOKaMDS4k//PlKyFMOwtO4OguZDbRQ==
X-Received: by 2002:a7b:c7c2:0:b0:394:18b:4220 with SMTP id z2-20020a7bc7c2000000b00394018b4220mr12423831wmk.118.1652399402389;
        Thu, 12 May 2022 16:50:02 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd? ([2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c42ca00b003942a244ec9sm960671wme.14.2022.05.12.16.50.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:50:02 -0700 (PDT)
Message-ID: <64f88438-2cf5-0920-972f-ccf1eb320d07@gmail.com>
Date:   Fri, 13 May 2022 00:50:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Andr=c3=a9_Coelho?= <andrealbergaria@gmail.com>
Subject: compress
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hey,


since all numbers are bits, for example a int is 32 bits, can't we use a 
math function to convert from bigger numbers to small numbers?

for example

     int a= 0xaabbccdd


f(a) = 0xff


we could only store 0xff

and for obtaining the a again, just use the inverse function...the 
function has to be bijective though

f-a(0xff) = 0xaabbccdd


thanks


later


andre coelho



