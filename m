Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5853D4A2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349004AbiFDBbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiFDBbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:31:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF03233;
        Fri,  3 Jun 2022 18:31:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e24so8582088pjt.0;
        Fri, 03 Jun 2022 18:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6X7znir8QcJzmKE7N3CYLdjwhqcOiRXOJqEg+HuGWpM=;
        b=MkclXkvo9eQbXpy739HtCfdLk8xYndL4fWUi5dBTTN1bT6z1qgHdaycl4XT06Nm9En
         /nJoQQHj4/zvauKtmi5ovvd/B781QS39a+DtBAqn6GWx/osKxv5ZCJmlZOI5ga6lxIA7
         MaYv/kbMc7QXizZTOnGQdGv5e/dq9s0byyMJ760XFX8menCLL+z02QtLr97Pls9idJxV
         OL2v+DH77hVOMA69Gzn3npilNzmgX87qtWIVdtqKmkqK7mzN5lFMjY+T0YvZ6UNwZta4
         cKeiRf6/Ek1tIh01zrEaPL9WVL1s4uYczRoqOkmO6mMOIMIa7zF67o4ZYuE00fijnkIS
         Xo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6X7znir8QcJzmKE7N3CYLdjwhqcOiRXOJqEg+HuGWpM=;
        b=psel1re6MgNtlEB1NOpGWib7mcv6N089OKjrMGR7fifPhaXcsxvwbGllqCHopRh/77
         rWtQwl5DHTGs0EQ3xzD99bpj9VWdNTTg/VObBjmOc0iFMeApwyIM+5Q8BS+oLLYGn+C3
         yVfQXBwu4itCrrEM1QohLt7PRZei42OU/45z2jix/+Q66Ync4D6vRG605AwqoBjE1kLh
         Oqo8MWzE/CEzMkJthBKxnoBSO1+KnVzdEcBSHU6zskJhwLuSnZb2DeEaZZmEA2NVq+tA
         +M5PyEb26io2s3yw1Jnj+MDv0QXZDJ2jVuOWCAu4ySa52qr91zzjZaEU+6MMIA0/SKG9
         yLLg==
X-Gm-Message-State: AOAM532bPk6jr1QJRXkFxYsU+8SKblI1bSsdK72NQrOzpT66Vftj0v8d
        MjU1BtpWmIimstcnKmgOLzzaIWj2Eq8=
X-Google-Smtp-Source: ABdhPJzsaAzV7sGTS30rLm6gz4JJLaQGseKHra6TXlnrroYEzM8qUlRRdEgK6fQ9RNGub4U7rDFCdA==
X-Received: by 2002:a17:903:2d0:b0:14d:8a8d:cb1 with SMTP id s16-20020a17090302d000b0014d8a8d0cb1mr12679506plk.50.1654306275527;
        Fri, 03 Jun 2022 18:31:15 -0700 (PDT)
Received: from localhost (subs03-180-214-233-80.three.co.id. [180.214.233.80])
        by smtp.gmail.com with ESMTPSA id y31-20020a056a001c9f00b0051be585ab1dsm1848709pfw.200.2022.06.03.18.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 18:31:14 -0700 (PDT)
Date:   Sat, 4 Jun 2022 08:31:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Add leds-qcom-lpg entry to documentation table of
 contents
Message-ID: <Ypq13qTDWZSRW0aH@debian.me>
References: <20220603025735.17953-1-bagasdotme@gmail.com>
 <87bkv9x3qu.fsf@meer.lwn.net>
 <20220603135326.GA14636@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220603135326.GA14636@duo.ucw.cz>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 03:53:26PM +0200, Pavel Machek wrote:
> Not sure if that is important, we don't need this in stable, do we?
> 
> Anyway
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ... and I assume it goes through your tree?

Looking at timeline, the -rc1 is imminent (probably tomorrow), so this
patch misses 5.19. If it lands through jc_docs tree, it will be aimed
for 5.20. But if the htmldocs warning also appears on mainline after
-rc1, I guess it can land through leds tree as stabilization (bug fixes)
patch.

-- 
An old man doll... just what I always wanted! - Clara
