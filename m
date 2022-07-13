Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11323573B50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbiGMQdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiGMQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:33:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE6C2E68A;
        Wed, 13 Jul 2022 09:33:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso4281027pjz.0;
        Wed, 13 Jul 2022 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5SHUSXsqONgSGFWlMLIGNgVlfzO3WUzoSZ9tGmnf1gM=;
        b=UMX7GgiubFUfdB2GgsC6G7qmW5+linWqzt9GFgwiO63t21MLxiiyHE7ktOCygPAQoA
         kQr/RFT7/ToX66v7K+iamosjBVb0bHccmwhFRRYYmfgpsgrSaUE087wUaDf1EaPlTX5N
         yeQD8sFr3kOvciTG7xvLtCSIkNQn5V5AIKj3KJP1YE16LooAueC9ZfbebCIjxQwuZsRz
         P+gqBpkIxr/vI/0VTI3DdFZm+aE/IrFO6SeYMdVjOBehC8VYZKV+/Yqdjqwxvheo9aMI
         Kmc4NueUyZwOPJF2Qewp/928bTrlETRN7C1v3viblztCM6P8US6ezOIAVwMOGP+q153s
         kklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5SHUSXsqONgSGFWlMLIGNgVlfzO3WUzoSZ9tGmnf1gM=;
        b=UCr5VTEQHupwGn1Xlz/R8uQWirukbP+QFlzjdpmSsIFo5lduU+WU/svlGNlFcAQEiZ
         AM63tJpb/LTu8FO/Dfl/rQiZ6eq4PXU0JJHfj+LH1a7ixgvCKB52Zq3OK8QhJpI+iZXu
         1jcLza/pigDZ4uO9qxyWpf1zQvPcgEbpj+sSjioZwEOGI0jtngW9n2WMz81j8ywYnjA3
         YKxatRgL3Y7Oyl5TU3T3P2HxI4foy9zlNWyW71fkLUcuvQ+nuQ9y6w4hNYwEFQXdT7DW
         SlhZRY9QX13EdG8PQrCRpZwfUYi4i/5gShGmc3oO5zUxVtWCTd6/9UmSNffLaJdg+byA
         595A==
X-Gm-Message-State: AJIora/s51RJi6uIBV1UjrjMytcXOjX4Xx6urVViJpwNyHaHU+l6f+ew
        Gv6JMK+3ngrdDMOvekgyo6c0b4d+WBQ=
X-Google-Smtp-Source: AGRyM1uNEtM2WrZzw5jgWAmfRBGong/l1Yg0WCFLKxsTPrXPsLV6Ivv9EMR6UhL/nC1yKcFs9Nxavw==
X-Received: by 2002:a17:902:e552:b0:16c:571d:fc08 with SMTP id n18-20020a170902e55200b0016c571dfc08mr3824427plf.151.1657729983755;
        Wed, 13 Jul 2022 09:33:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b17-20020a17090ae39100b001efbc3ad105sm1795316pjz.54.2022.07.13.09.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:33:03 -0700 (PDT)
Message-ID: <b0d4e5ee-7862-e873-33da-2da2cbb33fbb@gmail.com>
Date:   Wed, 13 Jul 2022 09:33:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] clk: bcm: rpi: Show clock id limit in error case
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
 <20220713154953.3336-4-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220713154953.3336-4-stefan.wahren@i2se.com>
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

On 7/13/22 08:49, Stefan Wahren wrote:
> The clock id limit will be extended in the future, so it would be
> helpful to see the actual clock id limit in case the firmware
> response has been rejected.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
