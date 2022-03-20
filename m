Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1F4E1BBB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbiCTMq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbiCTMq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:46:57 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2CE52B0E;
        Sun, 20 Mar 2022 05:45:34 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id r10so17477215wrp.3;
        Sun, 20 Mar 2022 05:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=zCD2jKNZSkLw87QBh2HYa/dm2eAhqhWIVlmBsRRy138YHm2MxE0EJMQL11pcRZfVBO
         w8L3nFuLh2epWZaiBh7eixuDXnv0M1nF5bbinMemzL7fqsIBJ6/dLuABlBLmXLwYXlS7
         qeH6U2DBtlK6fgSSkS//qTyJaOlJJxZPlTFeMg6CZXO4E4Xilcak4qChfPISA+/qXzl7
         wPt6G0PR7YdndiDPcLq6dyomrTYkSp+WJwLzfXAIzAXdaMHY8AOD1CeZc3u+/HjwNbp8
         qJnJ1BIW1GWpR7OTpOaNxzxiuhvhVCEPlcKv85gyGwbxX019pAqlbwxIvexbQFDjopFG
         kgFg==
X-Gm-Message-State: AOAM5333w4YOCaE8YApuc9VBl8sVwWAAY38b7ryRZkDSDkO3EdZPDkIM
        Iwuje1L8dtwzNw5ycMf2c90=
X-Google-Smtp-Source: ABdhPJwUhVv8N3+HVdjB9bZ7jwZ3LbfVvveY4iMeQ2qaYFGGp2rir5abMkeDckl1WwU3ljob2dY6iQ==
X-Received: by 2002:adf:f442:0:b0:203:e0ef:32c9 with SMTP id f2-20020adff442000000b00203e0ef32c9mr14947152wrp.53.1647780332577;
        Sun, 20 Mar 2022 05:45:32 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il. [46.117.116.119])
        by smtp.gmail.com with ESMTPSA id l13-20020adfbd8d000000b002040daf5dffsm1896488wrh.18.2022.03.20.05.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 05:45:31 -0700 (PDT)
Message-ID: <77d616bf-96a0-ce01-7139-1253c414da0f@grimberg.me>
Date:   Sun, 20 Mar 2022 14:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmet: remove redundant assignment after left shift
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220318013014.90698-1-colin.i.king@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220318013014.90698-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
