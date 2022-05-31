Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B40538A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 05:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiEaDoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 23:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiEaDoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 23:44:06 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C206B2FE63;
        Mon, 30 May 2022 20:44:05 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id e66so11657158pgc.8;
        Mon, 30 May 2022 20:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GAS4if3QmSgkBQk84oxb36i3hcj+BJ5KC+SnP5v10YI=;
        b=oxVUc2YeIKj55OK3bSrYZyu+jQu96K9bdywykN4HY6vFIMGd4c/V4H3EgVcLovpKDo
         3xcyN++XcrKzcfcmFyeh21s/GjAzjgdEOTNIbOVlOSvodjFJa2+wl2HnNMTdG0g90KJ6
         HCoFVxJojSVmA1tPAuvEhC3ARd+nOPTFIFHB9+MssDwVZNP9QjruQNmO3PxPmB8qm9rG
         RSlIboOP/MOd3UhTj0K5VxjIlV6kHqgp3sNzyTtYJOjA70cYseUXMS24CGNzbsCeCYhz
         WDoENiqX6L8fRxtTETQIWRcf+8vObjA78aWWfwfM1gAjLhcazsHw6x7rrDHiBp8IntZC
         bX0Q==
X-Gm-Message-State: AOAM532WTKWEBTM47iKMwQGSl6MAiHB954pHmFa7okipdxlIV5zG7OLl
        ZJJeKIF3JrjAz8bhLI44MTY=
X-Google-Smtp-Source: ABdhPJy3R+SEKpYof3apU+H/Lqu9cLFpPv2T1M1iRnABqADktJfJvoRXA+aytj78uxglaVYgQTUAQQ==
X-Received: by 2002:a63:234d:0:b0:3fc:20f0:ec42 with SMTP id u13-20020a63234d000000b003fc20f0ec42mr6335327pgm.239.1653968645183;
        Mon, 30 May 2022 20:44:05 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0015e8d4eb25bsm10067380plg.165.2022.05.30.20.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 20:44:04 -0700 (PDT)
Message-ID: <8be31be0-8766-061c-2544-25e296048528@acm.org>
Date:   Mon, 30 May 2022 20:44:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/6] dt-bindings: phy: Add FSD UFS PHY bindings
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, martin.petersen@oracle.com,
        chanho61.park@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Bharat Uppal <bharat.uppal@samsung.com>
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
 <CGME20220531012336epcas5p2fcafe14c90ad3e3a0901fccd62d15437@epcas5p2.samsung.com>
 <20220531012220.80563-2-alim.akhtar@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220531012220.80563-2-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 18:22, Alim Akhtar wrote:
> Adds tesla,fsd-ufs-phy compatible for Tesla FSD SoC

What does FSD stand for? Please clarify this in the patch description.

Thanks,

Bart.
