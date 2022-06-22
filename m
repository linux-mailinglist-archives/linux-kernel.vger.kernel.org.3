Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A305550F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359542AbiFVQLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359301AbiFVQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:11:35 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9123F88A;
        Wed, 22 Jun 2022 09:11:31 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id jb13so2202405plb.9;
        Wed, 22 Jun 2022 09:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7IURSGRwyKWJDHrM6K4VNsvV53mSmBXAkgF9XnuDav8=;
        b=A8vKLxd/j+FMEPHd97Yp2esOev4ooBCgP0Qo81bFWpoO2wKJ8x+e/HmNRBX2a8f6dK
         yaMOx/YCGoYDO5eeruTAiHD+WWXSPma54+xzcoER0ECYyEt8lzJzdtttk3UxJuLzQyXv
         jPVzi1OvHlcHIjIUWqRtjkHKqvCmXO2IZjZISV8x1Uk5g14WmYGkGMavkE2OZXVVuS6i
         wADK6sOWrsKsbd5hyyAhEnxTY2tjlOola5JY6olIAUHlIz77etqq/b0E2KDZoYtvMHDr
         RzQkjDlSTlXgss3dAESzEaHAA4iQg1pF3gV/Z+ZMJaQ/pL2PBiABtUn25SjryYLrl1qd
         OZUQ==
X-Gm-Message-State: AJIora8xgbLXB911PIorUXaidgaJWv69YO1BU8eEDzUWpJag1jFdlbJ7
        osq7QWS/hf1Js20221Xc1yI=
X-Google-Smtp-Source: AGRyM1tHwHpLdzo3ytqIXM7LfqPIQbMDTYusb8KYlmEI8GeMb5aJAPu029jEQbOI7q1XHwb7bFv/0g==
X-Received: by 2002:a17:90b:3504:b0:1ec:d246:f02d with SMTP id ls4-20020a17090b350400b001ecd246f02dmr8252005pjb.46.1655914290856;
        Wed, 22 Jun 2022 09:11:30 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9497:eb13:222f:4e4d? ([2620:15c:211:201:9497:eb13:222f:4e4d])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a694600b001ec839fff50sm8966697pjm.34.2022.06.22.09.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 09:11:30 -0700 (PDT)
Message-ID: <bd23bd5f-2b13-2703-62a7-97dba8e1e4b8@acm.org>
Date:   Wed, 22 Jun 2022 09:11:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/3] scsi: ufs: ufshcd-pltfrm: constify pointed data
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20220613100655.105301-1-krzysztof.kozlowski@linaro.org>
 <20220613100655.105301-3-krzysztof.kozlowski@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220613100655.105301-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 03:06, Krzysztof Kozlowski wrote:
> Constify pointers to data which is not modified for code safety.

Thank you for having removed a type cast.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
