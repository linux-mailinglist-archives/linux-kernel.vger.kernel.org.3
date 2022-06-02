Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF853B22D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiFBD3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiFBD3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:29:24 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE52B267CEE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:29:22 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a64so6161033ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 20:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=dNPJWuthskVWT0ufEpXee8XRkWLAHfMmaIAQ/DRtum9IaDT7pYID7fK7hZujWGqcuK
         InQXq8wiFsetyJlTizS3ot2sBTnD4omUAzVAnO4wHqIR6p38d0pTl/EgdTBbEmoOuHhV
         Jrv5M39u3+SP7b1GVtwmNCe0xcU+3/bEAQbRIydNVGZEWBhiKNUkEnDfFVy1Y0C7KjYG
         X9BDxDjBWp9JmzJ3mYUiCyYRxg8UsdM4Wco9VKAY0nBImIAvcaslxRhTSGlmdVcC2nVb
         HQufkdvlldBEi/CJtH9DFemhn+mfEUfhGJUjK12Y8iM/yWlGlgnCsowVylJnuQ21Xe6y
         5n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=7im7/qHtTQ4VuzWyDt9SD2blh14UdOXGBBqb2bvYiMxAH1Jes/YMzQwwzEtRsRVyyS
         iHbsNjji5njX4N2AW8OFUSzyqVY/hWA4RvXOWGn/SCxPGphtSKkEuAgQiM0feKbxDq4t
         ATz8JaXx023gMvozZsrVCrbpWyeS/LMxEmZEY6SRYM9K7Pj2Vzh9dLoomG/v+gpK6gjI
         ioj1Z9+dMIXjLBVZoJrcRPi/yazP9FcflIDaekE2WGQyNGnop74FfOlPiW/k+OL1Yyx6
         Z+JBqkH4Suf0Pb2JVBYriKffmStBZktrejH+Y5mp3SiYj6Se1LoberEk91lsiZbGrtSd
         WPpA==
X-Gm-Message-State: AOAM532kvQR6RxGwvb0dBQmrCV7/xZiYd2aC0P7bH+TBxDheAJDftH92
        B7sgk2Y8MR9KwlDaTj9QrQWKnIzEXzcRD4/eOEw=
X-Google-Smtp-Source: ABdhPJx4I/aVYDJM6ZFkqx+ARDUfR+FJjHRTOe+WvLYecywbPmAnR6aEzG4qFHSz6X9wb1O/s9MFbg+HFhVay7bLtOs=
X-Received: by 2002:a5b:6c1:0:b0:633:b5c7:b9b7 with SMTP id
 r1-20020a5b06c1000000b00633b5c7b9b7mr3254397ybq.67.1654140561574; Wed, 01 Jun
 2022 20:29:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:56a5:b0:17b:8967:118b with HTTP; Wed, 1 Jun 2022
 20:29:20 -0700 (PDT)
Reply-To: dravasmith894@gmail.com
From:   Dr Ava Smith <ava741650@gmail.com>
Date:   Thu, 2 Jun 2022 04:29:20 +0100
Message-ID: <CAMn9dLCtBkOu+9BcNwrup_OViCi77QA0rYW+WCYaVcp4monsbQ@mail.gmail.com>
Subject: HI DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
