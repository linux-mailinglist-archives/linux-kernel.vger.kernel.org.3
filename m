Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5EF5091B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382302AbiDTU7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382333AbiDTU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:59:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDFB4738F;
        Wed, 20 Apr 2022 13:56:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q1so1733026plx.13;
        Wed, 20 Apr 2022 13:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iyNh/cgw372mgMuoCpBOD5OLepcke4CvqRSVyft8dEI=;
        b=Pjvu+5wlOm0zbvm9BXVkOQIBJbIIx1+BuScH7ve1SvNr3jK3hzMmJq7Oy6+e5bMQx3
         EUWq5pSdndTu7VFL13N3pccgmPcI6DSNQa1igjEak09RnccAL7iyPL3UZFYVyDhvdYXX
         thpHo5hbJuGT3B1Wyrjy7n0zqsry2KJ30ai8fjsebOryZb/msh3EI8pl7zhwQ0ky+AHC
         QjN7256MqxCw0Ze85jqAdYBZdIgZ9iAQ28pd9KMDpcdWF4tvmEY19EgJr/RvpdQFi6zq
         S7zsic7PNs7BtciZFpPKTU/Oi1ewDdI4LgXVZRlaN4o24hOKPL7/BTBY+jafVEMpZcAS
         PsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iyNh/cgw372mgMuoCpBOD5OLepcke4CvqRSVyft8dEI=;
        b=nh5dmKTp8EIMLEreqn+pByQfoTK9qO5KMcU1LP+2Uw0vdlKCtJxq6WpvZb5wN18IK+
         L5hr6ZFguIJ37xqdVNFXcg5jgm1swEUHYQRtOwdfT/3aDLoH8OLsPxDB4oIheF/SLSvu
         KMfa9dKisquV7H9Xb2AhPvjNoFNiYfwKqY7d+RLoG9b/k00D3mtiNyzFtK+IAR6QxUD8
         ql83Q/e8x724WDCVWSpMQ2aRMqek0/FTo2sXGYdI5xquki0yE5MKuTTfg7xlNOUEryFz
         +oQ9+kg7XEi1dmmEY3AZAK0YngcRWlVvbNVkI1D7wHYxaKvVIV4ZgWdOCtszjagIZgxh
         Bacw==
X-Gm-Message-State: AOAM530lQWtx7Ed9nJ2XpIQZ2mmiX6TAm0oop37gYOjr44KQa6gBpuwU
        IMFOFVusv042ml8c3L5s9ZI=
X-Google-Smtp-Source: ABdhPJzWNfD4QdoKGiy4HD3wAKCNVrRtgJ9RHg39Ydkly85OJOUKE6GjmttoYlAImRh6F0mGhCs0NQ==
X-Received: by 2002:a17:90b:1bc5:b0:1d2:699a:54e3 with SMTP id oa5-20020a17090b1bc500b001d2699a54e3mr6471988pjb.136.1650488165771;
        Wed, 20 Apr 2022 13:56:05 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fe4b:9301:599b:d734])
        by smtp.gmail.com with ESMTPSA id m18-20020a639412000000b003820bd9f2f2sm20737577pge.53.2022.04.20.13.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:56:04 -0700 (PDT)
Date:   Wed, 20 Apr 2022 13:56:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     cgel.zte@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] Input: Remove unneeded variable
Message-ID: <YmBzYpGW+9rn+SaJ@google.com>
References: <20220419064255.2563333-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419064255.2563333-1-deng.changcheng@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ov> HID-over-I2C devices might reset on their own. Any device configuration
> applied before the reset might be brought back to defaults so we need to
> reconfigure to make sure the driver state is consistent.
> 
> Add a reset callback to the hid driver structure.
> Issue it if the driver implements it and the device reset gets observed.
> 
> Signed-off-by: Angela Czubak <acz@semihalf.com>

Applied, thank you.

-- 
Dmitry
