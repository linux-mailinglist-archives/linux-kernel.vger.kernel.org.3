Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8425C506327
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348203AbiDSEVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiDSEVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:21:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623FE2BB20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:19:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k29so22646798pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uMLCd1jUQmqd+kJmG30f48mw7LnIWfBX+V3Zn86PmXM=;
        b=ApI55McaYqWh8Bk8YPuzmhrlx3JF8GuYaCqr1JzFraTOnY7Oqpyq+djrXZmHPoD6cp
         YQZTi8GwjFlp9cukp7VIMiQf6RStcUcrBv/gDjCL/ChcqYwONw8wxqhd76EBTG/fMbs+
         yiv6AckYO+kW04b3zy+Dp6WMbYVlU2qkSlNI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uMLCd1jUQmqd+kJmG30f48mw7LnIWfBX+V3Zn86PmXM=;
        b=JY4yTtE7CeV1nuJEAoNjb60AEtONqOfK9ZAN+OYwAR7Fss1Mf1cGJzv6EHa+z5VNbW
         V3yR3FHJBbPEb419Wn4109Jhogd/IPeY5WWsURMmqlDtvDL+MJFINuaGJYEa96komqSn
         8Rg02L34UPwRLiWyiW/ueOTDrdL1uaZMNW5nSokKnfS/xef8tVHAEYyjdT9JdVtfIWB8
         HX4nC4FFsvHxknxBg/PVZkulHSdxTT/UpTNlGnEMj4n5lVynlxWikZsG6OCc7c3ij1NI
         mcA3NREWuBO3Qt5d4PfgywSdameSt7XanZGc0aIhhml9ubDFsuUuyh0Nvs/yPo7gW2In
         efIA==
X-Gm-Message-State: AOAM530OSl50U5+4Nlxiw3kVjwxZAkXeUZj31fsmUu1Pu6p/bjObHHVJ
        3YjOpnOq+DaBewkGeUmA7dzExw==
X-Google-Smtp-Source: ABdhPJyb9p96E3RKLUof+L5VGikkhWjJ0FIhHbLLM4ktrmhCQvG0dS2+GCiXjFFAV+/fQjSjErkYzg==
X-Received: by 2002:a05:6a00:c8f:b0:50a:77a3:e7b with SMTP id a15-20020a056a000c8f00b0050a77a30e7bmr7825616pfv.41.1650341950925;
        Mon, 18 Apr 2022 21:19:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a468d00b001c7db8e6ac7sm14621432pjf.40.2022.04.18.21.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 21:19:10 -0700 (PDT)
Date:   Mon, 18 Apr 2022 21:19:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: include/linux/fortify-string.h:267:25: warning: call to
 '__write_overflow_field' declared with attribute warning: detected write
 beyond size of field (1st parameter); maybe use struct_group()?
Message-ID: <202204182118.5EB742C6@keescook>
References: <202204142318.vDqjjSFn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204142318.vDqjjSFn-lkp@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:54:03PM +0800, kernel test robot wrote:
>    In function 'fortify_memcpy_chk',
>        inlined from 'firm_send_command' at drivers/usb/serial/whiteheat.c:587:4:
> >> include/linux/fortify-string.h:267:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>      267 |                         __write_overflow_field(p_size_field, size);
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks! Proposed patch:
https://lore.kernel.org/linux-hardening/20220419041742.4117026-1-keescook@chromium.org/

-- 
Kees Cook
