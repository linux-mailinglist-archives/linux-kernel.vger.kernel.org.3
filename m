Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E555422F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356867AbiFVFQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356471AbiFVFQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:16:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5073615B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:16:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id cw10so8010883ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b4dosciSu8bAt8+kFeOOHNaC1wBkKYaxBY54lYEpn64=;
        b=GLt+S+BZl+1x3G0rdEK7SlcAFTpY9Jw23Qwlw2P8w10Ov3r8iJ39+asfwIwCvq4oVD
         6qAbqxiDPrvR3iIIlouIvQMWYxUukerihzVUmKgKJ+xMMmWyeA3ECRy7H7f4KbueFjoW
         WnRLQ+W2UJeXxWimv4H7i2XnSG656/fho+gt9vm2ynHCUjRzlGQv3qZ1TLpGXDbBRITt
         8xVTyb+UNNW5Ekx0rAbyZ8xEEmZQJLhT/T7RKHETIEVw82j8u+uy+aUGJkHlhwAwNm/u
         7GlxsemU1jmZBtZVQy1R7+s0CxmKIS7Jqn6dHEW+JW2J2DQcZnmR9LKT1fvvPuv3lNzA
         JfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b4dosciSu8bAt8+kFeOOHNaC1wBkKYaxBY54lYEpn64=;
        b=mc89jqIgujsUknMX4uzVVotRpM0cIsD9jCR5hxzT444eBIQUHsi3Ga/sw5C1u4M7oi
         mB1fvPWbXm2WcZGrLFPzaceccZiMXdw9w2vvv4qlrFfq42DBkEV+sxfknAj3eGDzJ2+8
         R8/VrGO/CmlwjaBpT7SU8ZOc+QcLTEg+6zOTa37W/0umhDydFgHgxFlmbtn1ck0JeKvR
         DxVji0UftkTChtHTTrN2k5xhllj6fhMnDTVKDVyL+4zpG+PUYMCi0elO6DbxA8PuKYC6
         mzcOtj0L8/rQ84ERYJpFJmrX5oVHJodRg9fm6N0ZwAjKSnZ29IpESDyQboDlclFmSNZ4
         NEgg==
X-Gm-Message-State: AJIora8vy2gCyEviJJLFROK7mByOnUU+7FZHwZld2KXyuaGbkfclr+2c
        3Bhv9fNm2NdIgHebV2g0/c44NPu59kU=
X-Google-Smtp-Source: AGRyM1tjtPe6DO5tbCQAaZsTIeOqHxvFhL+KnY/lNKE7q8CVWvpBfk6QaFP+oHd4pKHCAeWZ9ku8tQ==
X-Received: by 2002:a17:907:6e0a:b0:718:effb:58b7 with SMTP id sd10-20020a1709076e0a00b00718effb58b7mr1392011ejc.363.1655874988693;
        Tue, 21 Jun 2022 22:16:28 -0700 (PDT)
Received: from [192.168.1.101] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id f23-20020a056402329700b004357cec7e48sm7475824eda.13.2022.06.21.22.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 22:16:28 -0700 (PDT)
Message-ID: <e16221e9-c739-ea68-b5a7-7b48b7766113@gmail.com>
Date:   Wed, 22 Jun 2022 07:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/5] staging: r8188eu: Fixed some coding style issues
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1655872968.git.marcus.yu.56@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1655872968.git.marcus.yu.56@gmail.com>
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

On 6/22/22 06:52, Chang Yu wrote:
> Fixed a few coding style issues as per checkpatch.pl and kernel coding
> style guidelines.
> 
> Chang Yu (5):
>    staging: r8188eu: Fixed a function declaration coding style issue
>    staging: r8188eu: Fixed two brace coding style issues
>    staging: r8188eu: Fixed two whitespace coding style issues
>    staging: r8188eu: Fixed comment style
>    staging: r8188eu: Fixed some blank line coding style issues
> 
>   drivers/staging/r8188eu/core/rtw_recv.c | 38 +++++++++++++++----------
>   1 file changed, 23 insertions(+), 15 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150 
Adapter

