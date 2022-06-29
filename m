Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E955F5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiF2Fvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiF2Fvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:51:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332E2A433;
        Tue, 28 Jun 2022 22:51:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso18242622pjn.2;
        Tue, 28 Jun 2022 22:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V9Y/umYkD3UGfS/WkXLEx4z2MIoA1K/dDJuHu2YPMt0=;
        b=CYAoAinQRZbgqLSd9/S6MzlktIbb7TmsDJAgUVRzuYUYW9bd3M+oE+8FKDP4z5fmP1
         st88GbztzMGGgGb8p5Oho/13ZyoTByysR05lX0JUVnp/wgYn77Qny28c+nEoux8QDauX
         G+7zwRCwIXGNqg8OTfqPjrtG/WL9ULn2s0VV8RYraWDiJSPDH5uSlS+nyTDjPYW0aUAu
         TWmQ3W1iA1SfIeiOq25Q+B0SVTbIyttMZcVU82+vl5JUXhtF1luZlKS+aLsRWZ8IVJ4q
         OHNLgZhfWn3mqcm7UQXStHcjinkEUHqO8zwL1JKKRVsUvJVMyqIZ3mwSjA9FEc3EEiBL
         QjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9Y/umYkD3UGfS/WkXLEx4z2MIoA1K/dDJuHu2YPMt0=;
        b=rM3d+8JVZYNNNq/mdfzs6hkBwQr3aPfQ9S63bM86Gme4w7+9KCMDHV6jfHRwo0C7AD
         SQX2sBLirtCzBu74KWCfM54nygmSXs0YlKMCktIoBj7UWT32gbe8LUIR1IQad9C6YVpi
         +B9kXUzwK7q8g+h1fSzRuS+k6vRbRJTmNHmbAAd1osWOWrcIyOyQiw+yww1l+Gt9s17R
         wxk2f0FcbAdyT2Ik7Bg67EZs9xbE5vMtXRYOqQcT8T4VInw5v7TCqT//XOrYLe5P8GVE
         oqwZXFyziBa4mKO+BLt96RqaQVWYx/lGWQofDrx1S6I8aIqbC4LVjgDKY9QEh5LwA8UP
         bFbA==
X-Gm-Message-State: AJIora/9IfAjsLpBjtkxTZdAc+1fdYCfNImQ2rvkUSBfKhNGyFXF/CDo
        OYtQvKCAeScYj7M8FJj3zn6ET+fhM/Y=
X-Google-Smtp-Source: AGRyM1tm/d0/zsAQO8NFy4uBzapSRk1eQGVFXZd7E6GbVnAmbWnwe6RlMq0uz2/GDuWJz0+Mh4s+WQ==
X-Received: by 2002:a17:902:e80e:b0:16a:4a57:a24a with SMTP id u14-20020a170902e80e00b0016a4a57a24amr7548275plg.26.1656481905406;
        Tue, 28 Jun 2022 22:51:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ff79:92cc:7905:3272])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b001eae86cf683sm977877pjc.42.2022.06.28.22.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:51:44 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:51:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] Input: Remove unnecessary print function dev_err()
Message-ID: <Yrvoblw6WXQOlUEV@google.com>
References: <20220427004906.129893-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427004906.129893-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:49:06AM +0800, Yang Li wrote:
> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
> 
> Eliminate the follow coccicheck warning:
> ./drivers/input/joystick/sensehat-joystick.c:102:2-9: line 102 is
> redundant because platform_get_irq() already prints an error
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied, thank you.

-- 
Dmitry
