Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3850CD2A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiDWTUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDWTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:20:05 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94611D92F7;
        Sat, 23 Apr 2022 12:17:06 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e5c42b6e31so12049557fac.12;
        Sat, 23 Apr 2022 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4KKD44aDbTYnErXQIAdZB1trxRmXyTSu+nMBzwIudCY=;
        b=IV/5iQpQe05/ci0Bh0/qYL+Qkay9ECCjZ3gZzF1PcUEpHWhRytD63iz2WyGVN7GLW2
         4kjxM+YEyRr48dj4gmzrRLcUqiyV97S2i0chw3TDPcvn3NMny1mKaa0nSP1/eQSGnByP
         U4JlqpextZX2hxgnXPhwkpiAPNwWYXpbmVyyukrvjeftftDnRzuNnV6XFAIbTnWii9aq
         c+qBiP+InFkem1YJxtOGzERE+o9HQ1a7DyVBKh/1qSYKmVpaWtgko01uOShWFNQZ8A5h
         rMM4YkJ1WCHmhWybEmVZbfZiWD5a78VTmMIeuGLmcXILKLUp9IvxtDIz8PzyEZ4aWWFH
         KEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4KKD44aDbTYnErXQIAdZB1trxRmXyTSu+nMBzwIudCY=;
        b=YzDBPZOQBsWYRftJCscOyJGkFuJH16hFwAzkxWWAwTV9CfwlVzKw3gVVu1dmwFf4ep
         ACoVggk8QESCPcDNNa3ZYgvSk9y9zaD5mn9WPvetvfGeCkuOkLRlS8huptrrmTfEMw1G
         PMNp4vwgSNUn2Sm2yxo5d21+11F9z0LlPuxQHNrENYLnPsHYyjGOMHSwiPwzvUJKBLJh
         9ETNEJGsRtqk11JA95xLOlOycE/x2eThGXBfN2QUZ99P4eta219NmvK95z1Vvw5I2dj1
         AipiUAr2+LgYFXhtybp4mKGBtoWa9u6MGd4yI+S/74csShPdbYn1DQY1HpWEcHRP5JER
         cXVg==
X-Gm-Message-State: AOAM530zeRs35vC6oj5TlgmQX98yt5B6HC991QGptJvLRgvmr1pZf+KS
        XvUhe3+nycsJgsBGBz47xlY=
X-Google-Smtp-Source: ABdhPJwtqAxGRodl4NNQOlWfRGaxk6b4ezEVaz399ot2DLg3L1Qu21f9VHFMP62jDgO4Fx+OTrWgBA==
X-Received: by 2002:a05:6870:41c9:b0:db:f23:f5e with SMTP id z9-20020a05687041c900b000db0f230f5emr8701653oac.118.1650741425294;
        Sat, 23 Apr 2022 12:17:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j25-20020a9d1919000000b0060549a9ca91sm2023212ota.79.2022.04.23.12.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 12:17:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Apr 2022 12:17:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ProArt X570 Creator WIFI
 board
Message-ID: <20220423191701.GA3971291@roeck-us.net>
References: <20220422111737.1352610-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422111737.1352610-1-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:17:37PM +0200, Eugene Shalygin wrote:
> Basing on information and testing provided by users [1] add support for
> another board, ASUS ProArt X570 Creator WiFi.
> 
> [1] https://github.com/zeule/asus-ec-sensors/issues/17
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter
