Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BEE5546B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356874AbiFVMCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353714AbiFVMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:02:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924413D1F6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:02:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j24so2370979wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=jikqAgrTKGCy5dRTm7F3fsFSAeYjtFUW+0PrPU7/AeE=;
        b=oykcgBsypOxAlNfvNXZ27J9f/fdlbHDlWl1zqUVGgfmLp1kxkG3PjFRCQ0jw+gKkcP
         ls83cdvE8ZBcgj2SkYZJ34ylN5TTSDstpB3fWMupP5Pjia2GKibYtCev9pInS/kVZs+v
         ZN8Q1zZgehhkQijdGjELyI13H8ygq2smQdBLXRpZallfaJ/Fas7L/olp7enC+eoAYNFe
         YqXDW6wF7iXhOx0upzIuI59zH8YDVDUdo0ZF7ZSqtkKMls9PR3uV1766Wm7Zxi8vIjPx
         ZaDH4j7RAjPEltbBJVC9TJ2LtN8+OjrsL2a+VhoSPq8AsxJeahm3DVttTXpMumt9Ahln
         fP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=jikqAgrTKGCy5dRTm7F3fsFSAeYjtFUW+0PrPU7/AeE=;
        b=d3Lckd8E2HaerVy/S0Y7ObONSiGIJs72l6qEhEV65TEImq1+L0732ePqysxDVsmnMt
         WFqanYjl20QSFu3G3unpd08xluEgkebpGi/IqdvYQTL40/LOzv6wzL8lTWjL1RkRAVxH
         iV2l2a6F2gZTz3nZgtcMfBqhmxqiNBpPFJj9eAdlNOe74rqO2qRl9AxZOZbX2f/AOOSG
         DtiogMLJRa/9eHPLPFHScI0zYW6Od2Q7njoKcIaKE74VXCy8iLGu9qbyKguSYXHWqtgQ
         GtwT9nrgUpufq530d3gDlBVbcRalWuWBbQYJys0Y112KRmwd5iEuN04uP1KGUWarvcme
         w37Q==
X-Gm-Message-State: AJIora+Ch2dKtMrF3++b7QxYOrsQBzLy1pkAKuJCBg99jHfrVGXx98CR
        6HN+zUpf4JCkod49fXpv/4ap6Wr/GBI9pryl
X-Google-Smtp-Source: AGRyM1udUcwWt6XlrmAstnSA31kbcD4j0/cpe6Dkq6FuI1ZtOZ/ret8i0/SWFXouYerHqFvvT5UmWQ==
X-Received: by 2002:a5d:59af:0:b0:219:b556:7050 with SMTP id p15-20020a5d59af000000b00219b5567050mr2967139wrr.364.1655899345179;
        Wed, 22 Jun 2022 05:02:25 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id bn19-20020a056000061300b002103a7c5c91sm17117184wrb.43.2022.06.22.05.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 05:02:24 -0700 (PDT)
Message-ID: <7f995d57-c40b-6c32-e776-677ae1496769@gmail.com>
Date:   Wed, 22 Jun 2022 13:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: soc: mediatek: SVS: introduce MTK SVS engine
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

static analysis on linux-next with clang scan-build has detected a null 
pointer dereference in the following commit:

commit 681a02e9500073cd8b9c25a04f06166254b5a879
Author: Roger Lu <roger.lu@mediatek.com>
Date:   Mon May 16 08:43:07 2022 +0800

     soc: mediatek: SVS: introduce MTK SVS engine


The issue is as follows:

static irqreturn_t svs_isr(int irq, void *data)
{
         struct svs_platform *svsp = data;
         struct svs_bank *svsb = NULL;
         unsigned long flags;
         u32 idx, int_sts, svs_en;

         for (idx = 0; idx < svsp->bank_max; idx++) {
                 svsb = &svsp->banks[idx];
                 WARN(!svsb, "%s: svsb(%s) is null", __func__, svsb->name);
                 spin_lock_irqsave(&svs_lock, flags);
                 svsp->pbank = svsb;


If svsb is null, then the WARN message will dereference it when printing 
svsb->name.  Also, subsequent dereferences to sbsv will cause a null 
pointer dereference, for example the svsp->pbank assignment.

Colin
