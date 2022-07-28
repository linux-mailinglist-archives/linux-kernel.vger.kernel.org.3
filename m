Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02F58470F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiG1Ub3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiG1Ub0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:31:26 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7BE67140;
        Thu, 28 Jul 2022 13:31:25 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id b133so2883032pfb.6;
        Thu, 28 Jul 2022 13:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FRXwMIdC+/YkK8DnY+72GnS7xkbj5rAR4P8NgtM8akw=;
        b=7/hvvNP9bECxpad4Y+zogHyWzMvOxVosByS/1PQ8c90kRY/W/6OuS/H3FRLT5hGIjW
         EMinYA7DEmt+yl6KcW1RxyyBNAZ9ozj4OxAHUgNfYDt4niwnuv/wN3LF8tUM8Q4JfLoJ
         Jq0a/IwEDje/2MJTdwW8GhyCziWaW5hnJSzscMjsqbld2PsJRpiRMwmDXS8nAYLbJ1Ii
         h3C7aTLcTisXTmKK3+7Bt+OAm/4R2LEa0D7JwJewTa2u7OJHzTRRud+PwnFFnWoIex79
         klNovz3sVr0XSRbdydlWMAdYHShYR1keEqDHc8kNb+AtDp//Me1583pgFCq2RxbwLO3T
         YxTw==
X-Gm-Message-State: ACgBeo04uW/JgVQMziRPaAYcYIEfprIYXluYisNI3hfzmnzIqy56+Giz
        6VhBP2c2jOepIEvoWiwBI9E=
X-Google-Smtp-Source: AGRyM1szscR1gODiaS0CNlgyX7FY7pL/4IvPGK0y8+HL3/F0VSYIxuSkccL4lu38wsnbUYRca5sKUg==
X-Received: by 2002:a62:15cd:0:b0:528:bf80:37c1 with SMTP id 196-20020a6215cd000000b00528bf8037c1mr615894pfv.22.1659040284623;
        Thu, 28 Jul 2022 13:31:24 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9520:2952:8318:8e3e? ([2620:15c:211:201:9520:2952:8318:8e3e])
        by smtp.gmail.com with ESMTPSA id k4-20020aa79984000000b00528c22038f5sm1262636pfh.14.2022.07.28.13.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 13:31:23 -0700 (PDT)
Message-ID: <77330f3a-5f73-e10f-7e85-f3df304aa4d7@acm.org>
Date:   Thu, 28 Jul 2022 13:31:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3] scsi: ufs: Get boot device storage type from command
 line
Content-Language: en-US
To:     Chetan C R <quic_cchinnad@quicinc.com>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <1659034814-3473-1-git-send-email-quic_cchinnad@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1659034814-3473-1-git-send-email-quic_cchinnad@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 12:00, Chetan C R wrote:
> v2->v3
> - Made ufs-cmdline to build as core driver obj-y

This is not sufficient to integrate the ufs-cmdline code in vmlinux so 
this patch has the same problem as the previous two versions.

Bart.
