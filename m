Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4759EBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiHWS6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiHWS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:58:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0B118DFB;
        Tue, 23 Aug 2022 10:26:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p9so13009123pfq.13;
        Tue, 23 Aug 2022 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=eppd5oLs74ARmQ255ETS4TgVSJrmaIgYacFvA/Nd1P0=;
        b=dGrFlNHInYhl5EvkSJQNL1rz8YYQ/qdbjBxrluE+il09ehcC50nt2bn82xcgNtipgz
         mAjEtv+IQ0LrXzHs4zCGmZp1ERzL2VHYJFh86jy4I8iLJC1tN1Ts7pOsotNw2fCzujtl
         iUvNPGTfJMnXn0wuordMDsIOqD5I2AJ3hPn18UFTWCdfJMZoYjYYJ7jyyItNH38MZtwP
         pSTYmOmZ8nBD9ONohfU1R7QhPWPzSgP65vlvfJXh9HD9PWzXpll/gLdv/8wvW/lJJoGl
         qcMX1aakGORKPn2z7KFNtQ913GdS3intc+zoe9JV77gUEfTkKX04Zp+z9B3uQan5fp3/
         5v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eppd5oLs74ARmQ255ETS4TgVSJrmaIgYacFvA/Nd1P0=;
        b=WdhuH5R/4m/taicMD+8O0NJQkCUFPZ7ubhyM4FfU2XN+S9+Q+L8SaIGfFbR9qXQNFZ
         FKMkCOZoEyP+LYSV+ddccbGPm2mtcnDxD7oyPuTITp5hmbBuos/x0LCa1UavpEKu1pt1
         lv2cnP70FVN9YneM4t6cx8hqbENc1mxym18KS0z4DmnLdFFVxx8dtLjEC2FwAwP9BuDE
         7yyUeYQxtY4t1DyiUy0a1mYUz1guVEz2pFAuvVpWiwScrinNJK/hfg+TafTMmsb2RJmu
         AjKRZ9CIBqnUkUnGwN/6xzbL5qgDkR2e/v5vtufKL/jR2QumX/qgSOZJiA5oM63dh7S7
         v44A==
X-Gm-Message-State: ACgBeo2nMJ79AIshxMLbsadMMh24V8UuA6Qq4awPxqc3ftg18rl9stq0
        C3EAh/UdWF7GNhcwQza4JLM=
X-Google-Smtp-Source: AA6agR7V4hXDTdFp8hlcPTP2dUfCsuMJHVETczrIUk1HwUihLlF5cNV+sWfPHeBKqyuYFowLrCeZSg==
X-Received: by 2002:a63:2051:0:b0:42a:4611:a207 with SMTP id r17-20020a632051000000b0042a4611a207mr16251302pgm.62.1661275464612;
        Tue, 23 Aug 2022 10:24:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ebe5:ba37:26e1:8072])
        by smtp.gmail.com with ESMTPSA id f16-20020a635550000000b004299489dd2bsm9571678pgm.8.2022.08.23.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 10:24:24 -0700 (PDT)
Date:   Tue, 23 Aug 2022 10:24:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     kernel@undef.tools
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Ondrej Jirman <megi@xff.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH] Input: goodix: Add compatible string for GT1158
Message-ID: <YwUNRU9udCYGTPeP@google.com>
References: <20220813043821.9981-1-kernel@undef.tools>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220813043821.9981-1-kernel@undef.tools>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 04:38:21AM +0000, kernel@undef.tools wrote:
> From: Jarrah Gosbell <kernel@undef.tools>
> 
> Add compatible string for GT1158 missing from the previous patch.
> 
> Fixes:	425fe4709c76 ("Input: goodix - add support for GT1158")
> Signed-off-by: Jarrah Gosbell <kernel@undef.tools>

Applied, thank you.

-- 
Dmitry
