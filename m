Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578DE4EE59E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbiDABQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiDABQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:16:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB3652CF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:14:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so1134494pjm.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UHcsDNSAqcoVLPy9AJklaxy3ML0l8I82/+kzq8V+/S8=;
        b=RoGeouT6mfzFpbeFAbZkQTIBg6B1h4Rr4yI4b7WprYZhrMuQ8F42pyb7bYrTrE0epI
         GmBrmGyC5zOBxLxriztXewBzO/spXAwRXAoXm08pA9r+PgIVy0iX0JqoZSSN1Qw16k9h
         INv2edEWYZIYbEHLWWQ2nd4gBRYIxlvq5h2NPupS2FAVaTysqtvRaWJrETbrxf/TAjAZ
         Dyto7kjvrB96ZgM11mOqMMyTBHG8IcCyszeUjMDJZJn4fFwpNMQ7l1fwyV9MqUk6t6Wb
         dyTGVcqtNt+UMu7fOALnhwzU1jcy5HosFQBMCY+IR2mQ5hNSImmCGahhX6XUyTx7Zooj
         1heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UHcsDNSAqcoVLPy9AJklaxy3ML0l8I82/+kzq8V+/S8=;
        b=tPdBQdJezgXU+CSyQMH2UPJy3f6eOJBrr44WZ5aCfTVzg7qVlTz1nEUDPQJFJpRjzl
         NBq7gJaYC3Wz/8RRrJMGZQ2MZTkaYD/c/v5/rQHAOlmivRJ8PxWr6pWBaXdfY2cKKTBG
         Ern3IxbPzo6Iw/jQu52le4JHS2ShJxqRSABCc08kV9/J3XSLNMv4HCTTaR0UqOBs+/sM
         2YrbpcexIrelVSDVCqLeymHtorvYtzpd7MRDwDg71uWUVe5Sbl4kMi8iR8NtadHok1au
         KNWG01C4QyBnaN7Z1/bpHO7mPftMvThecIHAqG463tCB+rygfeZ0d3a0qZnaHZLs7OH2
         MzEg==
X-Gm-Message-State: AOAM5322LuXCMDX+XyAzaY8K0wTv6wElbwXsQ0gtubyaHmJYJN94FZvF
        lmCvj7IKQvc0yrtWTFDnTjk6Iw3BQv0pYkiL
X-Google-Smtp-Source: ABdhPJx8I/9l9oKfm4L703TA0Sozoi0hqwiq6npCgqIQd5LYEJPBBnerHggJsEcYzdGLGFUMZfZnTg==
X-Received: by 2002:a17:90b:3697:b0:1c9:a980:3af2 with SMTP id mj23-20020a17090b369700b001c9a9803af2mr8836055pjb.217.1648775657910;
        Thu, 31 Mar 2022 18:14:17 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a394e00b001c670d67b8esm529868pjf.32.2022.03.31.18.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 18:14:17 -0700 (PDT)
Message-ID: <e1344987-6b60-c090-4a44-98ebd564f4f1@kernel.dk>
Date:   Thu, 31 Mar 2022 19:14:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] net: fix err_cast.cocci warnings
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
References: <202204010757.kWpiiHMi-lkp@intel.com>
 <YkY6L0HKkmfYONdl@71276691420c>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YkY6L0HKkmfYONdl@71276691420c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 5:33 PM, kernel test robot wrote:
> From: kernel test robot <lkp@intel.com>
> 
> net/socket.c:1571:9-16: WARNING: ERR_CAST can be used with sock
> 
> 
>  Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...))

Thanks - since I haven't even posted this yet, I'm just going to
fold in the patch.

-- 
Jens Axboe

