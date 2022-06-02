Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2131153B3BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiFBGld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiFBGl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:41:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F52A1412
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:41:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m20so8025201ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xh40FdUZDHp56lt1mcZYv6mF79rHnUUf6QlRZkakiWo=;
        b=jjIbor3W9EkaLy33DYrUnVBgkcSocnbd9VJYFqQSnTlQS2pqJbn+n+0Y4LjdKoOac4
         uTi5swn54aSkW0DcJ3ZD7xRk2qOVay7degnIXit1xEj5VqiLl1216O+qXRGQzwNIrB+i
         53kRUkaYHKYw8RINS7+qDDTlPtjuaaYVb4OLgB1eIgxo6Vg8hKv8XpdL1x7kavw2YKBS
         SiJtxUALKQYE2ln82KD3kVQAf0utgcOugzRyHd+o90fs91RlpEgWi1hwgJwpABh+koKd
         2cQJ5gnPwhoZWZf0pZRuDoZQmO+TP9kVvskZszM831f+sENnkvzDpVqp9Y6yBSb19mUS
         7Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xh40FdUZDHp56lt1mcZYv6mF79rHnUUf6QlRZkakiWo=;
        b=QNUin2GiEDT1JzHfB65s731h5oyJzhcRxdm280cS9wN2aT26/QfutjMZPf3xmbGnPb
         1z9hN6zmQGD0QsfbVf/yBvF3XSGXHBZRB2DOBfvJZW8uRAUQo+93+JBEljrJ+U0KwzEN
         OXNNu2lYT69xD+VVNBwJ+JpePO46tEjzN5b4AqT/HR1dIQgiCidX7w6X7oAv3PmQmHGb
         qKvGPfqOV5IrBac0UYs5HXd3BWk6QS200WZMTNnmirAfayQ7niawUsrhqgoCWhPdaydK
         5n5hkAtFIm516qGIq80aNBKLuQQxUGlLn/GIwQlMVgatVaTrQkeJ0aDLBHomShFZxqS/
         RxjQ==
X-Gm-Message-State: AOAM530Oy8XVqFJ3ICu2JCimOMzEdKt0gh0LsSnmsCAK6AzqEjtelDPm
        ZU3pbemeoq92J5Szk4KAtS1bwA==
X-Google-Smtp-Source: ABdhPJyaEB7WoRZ4YQcuTAOTfh31tzpYBulRNx0UClyWBZu0z/z0FJib+4lc9BcDTyXlnWjdhsfqNQ==
X-Received: by 2002:a17:907:6e08:b0:6fe:d99b:8fc with SMTP id sd8-20020a1709076e0800b006fed99b08fcmr2913931ejc.230.1654152083647;
        Wed, 01 Jun 2022 23:41:23 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p19-20020a056402155300b0042617ba638esm2016394edx.24.2022.06.01.23.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 23:41:23 -0700 (PDT)
Message-ID: <2cc7effd-7956-1b09-9faf-585cf3b75734@linaro.org>
Date:   Thu, 2 Jun 2022 08:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/5] ARM: dts: socfpga: Add Google Chameleon v3
 devicetree
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        amstan@chromium.org, upstream@semihalf.com
References: <20220601154647.80071-1-pan@semihalf.com>
 <20220601154647.80071-5-pan@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601154647.80071-5-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 17:46, Paweł Anikiel wrote:
> Add devicetree for the Google Chameleon v3 board.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
