Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968904E81B4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiCZOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiCZOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:53:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76F2467D3;
        Sat, 26 Mar 2022 07:51:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c62so12204361edf.5;
        Sat, 26 Mar 2022 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QC7lpceM/y6F2YdxeUftCt81nuxEH4oJpSeNcs9ScEE=;
        b=dRJ9I0aonPR3CSesQY6EcQrKEahhdKcTcz0dA+Ahj52EFLkftPkKIq+UGdVWHvcqqe
         Q9+8LnRB0b/lLTEmQEmh6kvdaDv+k7R3COWOs0jzfHNIqFip2f75KFTzudBnOKVnqnxe
         w2Wq92Pxncdsr4SbOTfpx3WbKzDk38sRVwb947CsET3q6TLFhVIM5RmE4NfKJiVC2zZB
         59weh67YjT/wDRUTMQJpOz79e5JOrq/RvLw0hQgSgEvSQGsuGeFiuTSEva7nnfTqf6Tj
         EmPu/9DkJ0GJF4Ku1R9nv8FQ3Ray5xFi7zyEMYjs+f+1TWU/2qE2QfZn2JxJ5oDnu4mT
         yg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QC7lpceM/y6F2YdxeUftCt81nuxEH4oJpSeNcs9ScEE=;
        b=AgwHUzJrVY31DLwMJDFkUAuiqKG+DyAxnfJrIHugH0IdpsLgD8gG6hS05E36E5o2Pa
         xjBijQdP/2MBn4L90EejZTV51hGKyJJqxMzq84k9OgdnNJZl/gD6/DxFDvcCzbZSbb+g
         JhSYaRSD7ZzYumvRYZChc2fKunk84IIWLesKBf7BGKHAANqJXItOcdLKdYeyBDDXDQhL
         Etw8KM7Wxkw6HffW65tkUdbuJTBUMeP5rj6OSVN7ZAsBEtoeIR16qMQIWGPUkwGIEqsA
         N6CrtX1yxT3DvjbJ+ZcLa7JnyhDQB5t2vKJqXT6LMVVIaH0HqHqK4H/kUZfY+I0PfXG4
         Zx7A==
X-Gm-Message-State: AOAM531/7xuQGB73xnW14Dp48WzJOOyL8AIkXH68ttt6g4BZEkBGANiQ
        Ba8ecn64ysw3eYrtT4oGvUc=
X-Google-Smtp-Source: ABdhPJzIit+M7R8fykG/wzhFP7QOkIxuiqF5kA3aCKQAOYv0dyZBDF4ejeEnImnTjNRW1lhDz8TbrQ==
X-Received: by 2002:a05:6402:3495:b0:419:1ff6:95d9 with SMTP id v21-20020a056402349500b004191ff695d9mr4914039edc.249.1648306318032;
        Sat, 26 Mar 2022 07:51:58 -0700 (PDT)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm4248148edw.72.2022.03.26.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:51:57 -0700 (PDT)
Date:   Sat, 26 Mar 2022 15:51:55 +0100
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Octo
Message-ID: <Yj8oi/2gvMb0nsgQ@fedora>
References: <20220326101250.8076-1-savicaleksa83@gmail.com>
 <083c2e34-dd56-07b1-543f-1627bd77acf2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083c2e34-dd56-07b1-543f-1627bd77acf2@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks the for the review. The missing break; statements are my
oversight, I'd never omit them otherwise. Will fix in v3.

Yes, those should be centi-percent if I'm not mistaken... For
example, 47.52% is read as 4752 from the device, so that's
divided by 100 and scaled to PWM.

Aleksa
