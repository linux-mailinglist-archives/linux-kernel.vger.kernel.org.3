Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE90859057C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiHKRNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiHKRNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:13:30 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2EA98CB0;
        Thu, 11 Aug 2022 09:54:20 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id x10so17419868plb.3;
        Thu, 11 Aug 2022 09:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ghMwt9G6INoMEmlW5dhmg6qUUpa6pnUlc2kP5MleMy0=;
        b=OWYAs9lFto6IuRZgIWur8ciQXZ2QuosNSSqNnw+BpmbFAXDWopVrFLS4wP4kHqQ6Mm
         ovRek8Ykcv6aZmSmjBiBUxf2eAcqIOqWtLXHv45CxhqUjSgxwTw7G984HARXsTepag9Y
         eLTr5X30KFrBlTvMwPF1esnPUC6C2RirFzsyg09Lnv5fYMVffFCC8DyMN7hNzuO+WB4O
         KRg5p1YtBIfu6HGzy8K/ybDHkpht20EWmz45jibSSU4MAxxcmC+DCUCK2/XZEu5DDFiG
         BxXqZMyM3lGAukY78HI+Us5DMoM9rZUIilyPeJoKlS3DWnnoP2t3iyxiSIJ4QNso2ciI
         KekQ==
X-Gm-Message-State: ACgBeo0ugceQvK+fqluWVIMPnagHeUjhb96zuoIxGoFftqe2ZwDuaMDJ
        911ka4Nc0iWs9OLFToSDU4A=
X-Google-Smtp-Source: AA6agR5ieWdQuWvudLAEWQMsFxgSeC/cycIV50x4a22kEvb+9VbqhyvFZei0LgdosP4xscNrEyZ9tg==
X-Received: by 2002:a17:902:8302:b0:16d:d74f:e5cc with SMTP id bd2-20020a170902830200b0016dd74fe5ccmr128985plb.6.1660236859831;
        Thu, 11 Aug 2022 09:54:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fa57:1951:439d:3051? ([2620:15c:211:201:fa57:1951:439d:3051])
        by smtp.gmail.com with ESMTPSA id u12-20020a170903124c00b0016d2d2c7df1sm15447418plh.188.2022.08.11.09.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 09:54:19 -0700 (PDT)
Message-ID: <3e736bbf-9094-f2c9-18b3-1113a9d3a806@acm.org>
Date:   Thu, 11 Aug 2022 09:54:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] scsi: ufs: host: ufs-exynos: staticize fsd_ufs_drvs
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, avri.altman@wdc.com,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        linux-samsung-soc@vger.kernel.org
References: <CGME20220811162118epcas5p2f452b3b425953d47e60e4b29868c03c9@epcas5p2.samsung.com>
 <20220811161053.54081-1-alim.akhtar@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220811161053.54081-1-alim.akhtar@samsung.com>
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

On 8/11/22 09:10, Alim Akhtar wrote:
> struct fsd_ufs_drvs is not used outside this file, so made it static.
> This fixes sparse warning:
> 
> drivers/ufs/host/ufs-exynos.c:1721:28: sparse: sparse:
> symbol 'fsd_ufs_drvs' was not declared. Should it be static?

`staticize' is not a verb. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
