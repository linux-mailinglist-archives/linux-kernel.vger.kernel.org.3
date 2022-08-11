Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0239959091B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiHKXUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiHKXTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:19:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A34A1A45;
        Thu, 11 Aug 2022 16:19:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r22so15976314pgm.5;
        Thu, 11 Aug 2022 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=09k7MpXaWg0dET65ARrjZg4ve64PjAM1wA5Jggpvun0=;
        b=DSp+wHHdDt2RkDvABG6ehP2xaSTUKWngy5qiQKNbJQFraUabbzKdo75b+XQqB5QKk2
         9jsEKHK9bTRCwSAbugijIS93sYInoZNtXRCD5EOXf9lpdMC0O5P7b2MtIxTxJc1tGU6k
         OokQXm5dV4JIYW0W1P2yKFaBdD9nwOzrKmsV85xTc/+pqRCOqYy8Cx/lMgODcK4WZbrN
         fda/1Lh2sutYHSYQa9tDW8ThVCPMfTopCAyYhr8Xc2kkE8N5dW+aW0NMpsGiBW6KnQlk
         psETqscG7qzPpvhj+5AW1+RDYA2EW3xSzbbgv4HkXF8C3vPllGNPolxvxDvRw8KenH2A
         wDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=09k7MpXaWg0dET65ARrjZg4ve64PjAM1wA5Jggpvun0=;
        b=ZY+Gk1M7L0XykGVpcxGz+leewJAP5fsBcScynthS82f/X4lJ2rLPuMNzZqTCe0Hi6s
         5tXlMUAlruWMk2Ul8Pz67kk3ZYZ5H9H+SEsggNv5NFf5DDqdcJgEp2WuHZ7lxXh0E09g
         HJK5rkICt7kyEmY77/FrUJaHRXfitJM/qJiBEkpIxhVZe1hNunsbDkuKozfJzL6geJuA
         EgT3/gPd1SAwfFlsmRMdVKnfQgKxXie8HwXohJ+wnLXnG3GU21hcPqLLqVFYVgPtLayk
         rokPOqL/n7NHvu4zrpNlxHNNoolAjHAnWLhs+OqpdSwMxM2gdi0Aja7zWWFVCp7VY/6s
         1niw==
X-Gm-Message-State: ACgBeo0LeDIL5GjUde6yK7dHqL4PlD/Lay9tSBCl3w0dwauPM6cQnGXU
        qzLBsu4WPH1qflnbY8gUzLE=
X-Google-Smtp-Source: AA6agR5LS4fQaBwYTLwlwo+tgCxs+aiGMjfRTNjX9dCYHiZhLsfRmqxtWKsgyv1294pyp0l7Hwjluw==
X-Received: by 2002:a05:6a00:1343:b0:52e:61b1:4a9f with SMTP id k3-20020a056a00134300b0052e61b14a9fmr1283490pfu.6.1660259941373;
        Thu, 11 Aug 2022 16:19:01 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c348:229d:7b9:f9dd])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090a1f4600b001f216407204sm287600pjy.36.2022.08.11.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:19:00 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:18:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     kernel@undef.tools
Cc:     hadess@hadess.net, hdegoede@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCH] dt-bindings: input: touchscreen: add compatible string
 for Goodix GT1158
Message-ID: <YvWOYnbU85i+MIXe@google.com>
References: <20220809101633.352315-1-kernel@undef.tools>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809101633.352315-1-kernel@undef.tools>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 10:16:34AM +0000, kernel@undef.tools wrote:
> From: Jarrah Gosbell <kernel@undef.tools>
> 
> Goodix GT1158 is a touchscreen chip from Goodix used in the PinePhone
> and PinePhone Pro. Patches to correct these devices dts files will be
> sent in a later patch series.
> 
> This driver was modified to support the GT1158 in the patch linked
> below. Add its compatible string to the device tree binding.
> 
> Suggested-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
> Link: https://lore.kernel.org/phone-devel/20220809091200.290492-1-kernel@undef.tools/

Applied, thank you.

-- 
Dmitry
