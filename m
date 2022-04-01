Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A4D4EEA70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbiDAJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiDAJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:31:41 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5B1D59FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:29:48 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id gh15so1577207qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbn8b1Y80pAlAHrT4xLFWR4kpzjIAzXFAHvkgLMTl5k=;
        b=FKp67qcp7ziPvP93i2jFmH8Z8tyYaMtb3DTskFWFsbILCFFdFIeI+kqOBDcp0IqXhq
         Uu1n4VQhxH1Cxo1nLzqGsdcjweQLy1xuwIjj0OVXUAwByWfdIGZFvfKgX24SWiwhRGYF
         /0WuSSis5I/w1lxF0zFOMr9bc3eR4hWOQoOByFMh7qGhD1AujWnPPVHuSqcsCokKa1G5
         RU53gP1iKeW5HIAF8XdLSNzSnKqb8ZJ6d51IVvNbpG1R2FTZT5ahzx1JNBz4yBuIRfBq
         5MJXKz05BfgcNjzyxuYWNCQB8GeXyzxOrGQZ4mp3YqBdXlq4/KEGRf8BnbhxappT/cfX
         VqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbn8b1Y80pAlAHrT4xLFWR4kpzjIAzXFAHvkgLMTl5k=;
        b=OBW4t0Y4PsMUrrMjAVbaMtIIv0tBUuvovPY3UOW0CcDoeceLLynm8KIu/PB8DXEXyW
         C25RXR2RzMPDZ+lLfHOcCUtnbTi4HMh+2bYG9HXxULggYlWYWJE79ZHFitU3Qp0FjLQL
         DdlUFJcMI6gEceABXcXg5G+DhYfWAoa0VRJ1xjCzsX34GUMI0LLV1P3/ggNMHlrGc1Jy
         EooNX2dIWzpmSyltnzsNzVLl4hmhbI3OYLFClcrLMy3E6uEh1lS25Lc6znvhyrBnBlei
         pSg1Mg569Hpiw2ww+Lon5T5k9mQ3sysGMTrRltMUMwsPLtkk/IKV+Rnc8+hQA6SsSw9N
         FEIA==
X-Gm-Message-State: AOAM533nmGQCVvkpthOjmqBH6UYCihaZlO9LdL83hIapAudKdQrNqJ1T
        PynwmQU3tHady64IMueA8lXZP1Qhue7nffL2Br1KYw==
X-Google-Smtp-Source: ABdhPJyX0SuUj89u/sz5RsjvJfjF14dXw4PXUljF/o1zjASCFOWMvq4ztJN6DGCU+uI8uCxbH9PsJWQuMBWNtSqCL4s=
X-Received: by 2002:ad4:4eaf:0:b0:441:7ff6:f639 with SMTP id
 ed15-20020ad44eaf000000b004417ff6f639mr7092394qvb.73.1648805388087; Fri, 01
 Apr 2022 02:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220330190846.13997-1-wens@kernel.org> <20220330190846.13997-2-wens@kernel.org>
In-Reply-To: <20220330190846.13997-2-wens@kernel.org>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Fri, 1 Apr 2022 11:29:37 +0200
Message-ID: <CABxcv==6imu7Vc3p9ji=_+RFQZm2O65JCY7LLERsbAsgaRaUag@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add prefix for SINO
 WEALTH Eletronics Ltd.
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

On Wed, Mar 30, 2022 at 9:09 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Add a vendor prefix entry for SINO WEALTH Eletronics Ltd.
> (http://www.sinowealth.com).
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
