Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E3958CA01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbiHHN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243455AbiHHN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:59:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF7DED6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:59:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h13so11009413wrf.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LMUrhQrfiazbp1+WduUu1OPzJNVOemyvbYl+U+OIrQA=;
        b=jBu62PF/tUWL/YrWEvjA4mYpyhYXEV1CmXTK/t1SNkbBFG6KqWZ0AXFfyg4/OaqDQ4
         biIcke3LxQCWc8HndILqQYbQxbnXwDrOe0+HAe7Z+YoTWPZXrDjoMyxRO6Q+tO26sUek
         3iuLM0zPF7wgJzFL6RZ3z+y7j/HEJ5IJjdR9oGJURC8gOXMvGxrSsnUnJYZUUwAhYtqP
         CmjsMZpP1NnVJWW4rLtrNq6JPBeP38pSLHMWeLedHbb26aBDkc1R8kw9BsXXstPa3Tjn
         QnbJH5VJwxAZ53/6/p3c45wlO6IYuuxwA0nv5n2umveNBpfuDLvw+NGe32UE+6pVnsNR
         xWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LMUrhQrfiazbp1+WduUu1OPzJNVOemyvbYl+U+OIrQA=;
        b=f9w6fqMCtGxvcpNzAzyIt4z55Z6rfvui48eI09NfnsiEleRWkMCVUtpDgi7n/I7LaR
         eOd3A0GEKCmufR9hn1wptJEKznnYu2OMWEORwUqBkpqaB2RJ632mb0rfIGriUwmJLWcO
         BGc3qAZ5wI4XSnlsfsW6bL0QKIkw2kSiFFmWJyS2PYANoBMIE1Kt0IlcKifNd1Fhkcae
         pzej94yW/jOj+g1fkFcfR+fp+yFmETfrJrpxK4cua3toFBtzNi+xMPy7JWpF/ssU7xLS
         8HeuSX4YlHdxMzIsUYnKc/JHA5DFG2JGiwbZnZEJo3jlroGzETwEyACpvtgXzfFpcaik
         /Zeg==
X-Gm-Message-State: ACgBeo0j+1hEACbySYspN1m+10sE2nmxwBsEm09GWo5Hah4Q0LBSTxHS
        VtPwdKKh0bTpwA6yobTFYHAnqHKnJ9/vNw==
X-Google-Smtp-Source: AA6agR7tXMx4qgGGuiLfei7yeLsSXhcWm5ubfmdNUGRSoERWmfV0d+nBCXQlUvGEOS4E4fjlC68BKA==
X-Received: by 2002:a5d:47a1:0:b0:221:7e3b:b3b4 with SMTP id 1-20020a5d47a1000000b002217e3bb3b4mr7328479wrb.694.1659967149834;
        Mon, 08 Aug 2022 06:59:09 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d44cb000000b00220688d445esm13505210wrr.117.2022.08.08.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:59:09 -0700 (PDT)
Date:   Mon, 8 Aug 2022 14:59:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Provide an SSP type to the SPI
 driver
Message-ID: <YvEWq4zYC5xNPcGy@google.com>
References: <20220702211903.9093-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702211903.9093-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jul 2022, Andy Shevchenko wrote:

> The SPI driver wants to know the exact type of the controller.
> Provide this information to it. This is a complementary part to
> the previously updated intel-lpss-acpi.c.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Note that this patch depends on earlier sent [1].
> [1]: https://lore.kernel.org/lkml/20220628223047.34301-1-andriy.shevchenko@linux.intel.com/
> 
>  drivers/mfd/intel-lpss-pci.c | 141 +++++++++++++++++++++++------------
>  1 file changed, 95 insertions(+), 46 deletions(-)

Applied, thanks.

--
DEPRECATED: Please use lee@kernel.org
