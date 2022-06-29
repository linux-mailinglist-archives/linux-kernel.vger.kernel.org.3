Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26B55F58A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiF2FIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiF2FIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:08:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4012182B;
        Tue, 28 Jun 2022 22:08:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e63so14232813pgc.5;
        Tue, 28 Jun 2022 22:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RJPu25qYMkcfWmJzF5hlRjQjBLKAplrFIqmD8ypBKYk=;
        b=nrPQDn4oaK+yi3l0ie5aE8dS1n3y+l6Da413qey6DKWIEQsY2kZfT56hFfzTCRPT+i
         2IBRdUyHzxpqkaRIpHwWZGAxHP0aavjt4UdQyWaVxkEWxz5AVpcTfWkH3/oiubziI1JZ
         6VStdbe65p3k7KXNmqwrOCawgRgRO0mqwPAcbvdP2TEoQkyq18UL8hL9NYo/4YTWxb03
         2nNstbLiRi0UBJ7Oek2jg3nYu6uVK8LwJxfFXdH/B3vA5v7WvN9dQRqlFAR5EC1gGA8E
         3ofO8FxABcsxMelXEeP7rLsZ6TVJK5RjsPXquayy23SAj1QTh1AcMxlex5gy2Y084QEs
         Tjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RJPu25qYMkcfWmJzF5hlRjQjBLKAplrFIqmD8ypBKYk=;
        b=snqYU/jUpbA/+0jMAr4aRs7yXcj0ofhDxTY1Ur+q4PBltNUtNK0S1wsPQWOXR71MrB
         iSd7SmXwD9rNBRk6nALQT9KzrMUScVrBzOFXQYKwqhtL5XRMuz68RPEeyjVVqzSSvrwA
         HDb8q4dMMSoa7dhTZaemtJYSr7bD5F/TLiypjORRQlHu5jpNhPnZii74omcPUsp8j5ua
         wv17MEwdVhVp5ahfKyLrIRMy3T2Z877g24aWexiWoLRhrHPrHDmboqmJmTx71X7gAA06
         sYQXPABDJx/dZ+L+w7eoaoUZNbDeL5RrjxCkg4cr1rOmDMUi0pKyjrFDA97tRzdfC4ri
         eFCg==
X-Gm-Message-State: AJIora+WiDnsPtWa/vp5cjKjTsW5Jx46ghz2UC9fLHoghQLmZRnyaQe9
        izujCF4ydfrvDmRgmmPByYk=
X-Google-Smtp-Source: AGRyM1uwmevm8za8qrS4GFWD01zWK/vyIsl5V2me/AWE+EAy4r8xvE0T+BvyjY1rfeQzn/j1jWs2GQ==
X-Received: by 2002:a63:7d49:0:b0:408:c70a:9496 with SMTP id m9-20020a637d49000000b00408c70a9496mr1501140pgn.616.1656479317812;
        Tue, 28 Jun 2022 22:08:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ff79:92cc:7905:3272])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b0015e8d4eb285sm620803plg.207.2022.06.28.22.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:08:37 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:08:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cyapa_gen6 - aligned "*" each line
Message-ID: <YrveUwBDMBSXgo5r@google.com>
References: <20220621070032.30072-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621070032.30072-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:00:32PM +0800, Jiang Jian wrote:
> Consider * alignment in comments
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Applied, thank you.

-- 
Dmitry
