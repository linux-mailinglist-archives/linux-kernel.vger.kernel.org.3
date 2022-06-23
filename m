Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0207557D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiFWNsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiFWNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:48:43 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ED533EAB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:48:39 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h5so11654260ili.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=U5uzYO42zgEAa5x/oOTFHCFdB/yzoMeNEiKgA4Rtuq4=;
        b=XuIKdTGYK9m/mJiWjd4MkQIP7GdQ0bFJCTYt8XVgX1qaHmQqu0UbXpA+ug/Ez7x8/R
         L5vjKmSbMFEIKNAz60ufQ93m5/DFQlRbY+syp+DomLcg8iJvu3LT8RcjNQNJZyHxzb+t
         N8tF+W+C+Rv9x/c0pn5BJG3DqNwTfnS6D4KVv8Mhcy72UVxE8pMioxffGlnZBxT7AU+E
         PB1xwiDBMloHz/2QuLMRWXN4B8Ik7sYABMBcTYwF7iDdWTM2RkzJ/rGtL45BuECrJYj5
         2e8MbpFVQ4wfoFGZS3tsDLjc7UhRqiFC+/6+JEnFDzj5uNsIMrjguB/MPX9MVWJ6FFOG
         RWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=U5uzYO42zgEAa5x/oOTFHCFdB/yzoMeNEiKgA4Rtuq4=;
        b=0eqIWxGuhT+y9JCp41CXE0yBWUkGcM7X4Om0VG2KW5vOjzi197OBApT99/gO7JaJ3k
         NS9iJEvIxrZOjm+40FkcGeew1OMhU9nf7GhzTOO21UBVYv+JSoAJVklgluO1jjgL3TpV
         7d8YHyXd4PJjOLFra32NAadcbom7LBvWJdKW2Y/b2oP86OIPYb3/fdn97XrVA9Ldm5YT
         LJSLOVxif+sSFBTZ20DkVRCUZml7M+zie+ukjFnwB/bX/+YmEC/AIMZ4nCxl5bTB/HBy
         rSHgE7T0pJ+tBIQXRK1/JKr29dU95KHJxq7WrVoLD1WXQh8cmP2F08Juq4Hkt6pTGHDK
         CFLQ==
X-Gm-Message-State: AJIora/paR5RcwiYx5tKG2+SrkeeDMIeAbgkgyyKWC4dZoPKUE7lqWA3
        f6k6KHQ9mBO4p/Mi6+MQh3C5IWUWjT0ntw==
X-Google-Smtp-Source: AGRyM1t2IBngoiEAJ89YETCAQEa4v12MPYr7A7M0z01cJ5xdUXPROVt3w5nj8dLr6XJMASF1SBcKPw==
X-Received: by 2002:a05:6e02:20e5:b0:2d3:81f1:4d75 with SMTP id q5-20020a056e0220e500b002d381f14d75mr5089228ilv.81.1655992118615;
        Thu, 23 Jun 2022 06:48:38 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l13-20020a02a88d000000b0032e22496addsm9819509jam.139.2022.06.23.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 06:48:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linan122@huawei.com
Cc:     yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, linux-block@vger.kernel.org
In-Reply-To: <20220623074100.2251301-1-linan122@huawei.com>
References: <20220623074100.2251301-1-linan122@huawei.com>
Subject: Re: [PATCH -next v4] block: remove WARN_ON() from bd_link_disk_holder
Message-Id: <165599211795.468215.13968503617097802145.b4-ty@kernel.dk>
Date:   Thu, 23 Jun 2022 07:48:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 15:41:00 +0800, Li Nan wrote:
> Since commit 83cbce957446("block: add error handling for device_add_disk /
> add_disk"), bdev->bd_holder_dir can not be empty now, so remove WARN_ON()
> from bd_link_disk_holder.
> 
> 

Applied, thanks!

[1/1] block: remove WARN_ON() from bd_link_disk_holder
      commit: ca2a3343d69741dae4df2dbb954fb806d9a835de

Best regards,
-- 
Jens Axboe


