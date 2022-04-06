Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09704F6C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiDFVEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiDFVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:03:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383DC1D0FB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:35:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g24so4627307lja.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=lAU1fEYcKmDZuj2KcYo6lIuNo57KwPZ3JsWtPZCFJOg=;
        b=BZbkkMBGGodlgIxxcQ0eDJ+TfnSE15njQ2t96aKK2m1TT3lG8UFkiPCfpcQzRUSzFZ
         yrRf82q1+NQ85s5kJRgjIjEawfvcNPpsWX6P+nbPhDFIFxUBCvOEcPBBGmX1p0b+Ne5z
         7KfcKtX2nSTDRpkR0E1CfYRa1qqJNT0qlfnRRkY9p/hDX6opHw5nieK+IdoL7nrlezUZ
         xZCxUaB3B3E/LyH6CzpYNGlfulCSlJyD4FrIacKWIE4wLFqAWuEC+zsK3/X2FPwoq8hn
         pYG+8tnoq+jGFWmMe56Zu6/+39df4y/TckRk5yk6Ak+QiEo8ExTlgAmfc+Nln9nrwnc8
         Ya6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lAU1fEYcKmDZuj2KcYo6lIuNo57KwPZ3JsWtPZCFJOg=;
        b=oq8GNC9MPzjGfkcQtxCqB15e3ZLbNY0eyYX8utU+Lvo2+eGh4FjTq2KRNMHv4KqRKG
         sTPApGiV8FZGmmzTTtKVnWnhUmOJGeHx/CqFpIi4EttUtIKe7fwrzvfoXBiQmn8P7686
         Vc713QHMC7JX98vjwRa3SVGOMie8Xt7zGktH3KUqXhuqBDEVG2DIQFFU33D/XrfuBeYj
         2BbtXvEgI+mKcRmuqrrzEQhqOBguuqyEtkp0bnux0+Yp9YdUHfg6DggbWURxv9VIcOY+
         igO2xYSALTyYg/9nFqYWcz8lrzUaKrLf7GMF8ZY5hYaY0b4EyRgjKlRVDEKLGfz7hJW7
         qOAg==
X-Gm-Message-State: AOAM531ici9Z+7OzAA2o//pZ2Of0OLnNUAV7074lPLlPe2KcEMAIXKsX
        B3jwFt3yFoqM4AKoAxxS8VPmr90Nn7leT08uZy0=
X-Google-Smtp-Source: ABdhPJyxS/y//lijcsOmg2IATzjbtmupncD644WD5goVdOoUY3DOfLO/kHTOTO4JAxY4qoXLgqxV+4g5QxBVhXGgnno=
X-Received: by 2002:a2e:7f13:0:b0:247:ef72:9e8b with SMTP id
 a19-20020a2e7f13000000b00247ef729e8bmr6297682ljd.205.1649273732545; Wed, 06
 Apr 2022 12:35:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9a:1183:0:b0:1aa:e80e:9e85 with HTTP; Wed, 6 Apr 2022
 12:35:32 -0700 (PDT)
From:   Amadeo Giannini <joygreenldtm@gmail.com>
Date:   Wed, 6 Apr 2022 12:35:32 -0700
Message-ID: <CAEnpgaVvFp1xK_oLBNmsYUXXwBe3CxpTHc53XfyEaHxV_h7tWA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Are you in need of a loan (Money)? How much do you need & the time you
can pay back? Apply now at 2% interest rate.
