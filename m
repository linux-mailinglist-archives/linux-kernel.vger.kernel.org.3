Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022A950354A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiDPInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDPIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:43:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F409D0C0;
        Sat, 16 Apr 2022 01:41:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ks6so18957231ejb.1;
        Sat, 16 Apr 2022 01:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E99i9KfZnvDFyInCLoxSb8FAUQAIuI0Z0u1omhSERko=;
        b=Qy774tUpKair7a4f/6Rx1rQWcKlFZ+TZAscac0Pu8BLdi4T/olgDPPRqV1maGru7P9
         iEqKeAs4BayjYsDSfrSKYFDE2WHkJKw4YFhGbZiTFs1sWDZ88iRksXFPcq7PfD611YgM
         AOjkpmXoIj7TfiLBMoLUcBIzcez4+zRcS9QudcSxe8LfxVQ3ja4FCKhXnKAECk1fvfow
         2Su2YCZZ0yu6/xbopQndcPpFMcLaKrs+e/if+bFKbFh1Y9Md9a7w/9lRsCYIIauwIZ/L
         cWu5z7zWzs3JNyjJl8d8280SF6lR5LkeCeWwGLJgfJt++KQ1CqzRs00YZN7D2H6N0SgA
         XE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E99i9KfZnvDFyInCLoxSb8FAUQAIuI0Z0u1omhSERko=;
        b=Q+qYV6CUZa91h/Q168jOrZOKvlwlp7j8Z0oUdMVoEkHghYHjQ/a/Bb1tjrSMtoj1b5
         64DVAIeBwnVKqnOdx0gsxCRjD2D3Q1FmQO97VIjHUQ3k9B7C8IYy1WhL7YWXGK8mdEy3
         6mAlrG+tONCellHlDqsCSvAj/EsAz94A/B8O0wOydkOG4sWu1pzaKZw86fjIHmcZ0Bs8
         NWspGjqMv91wC9PK6/fhPq7f0GymobjL5wXoofcMNucMwQNHdT5NemQ105fXkI18+KIf
         kMm+0mmgWOAW1vTO1YfmImz2eqLH4TaAKCC+RPN4eWL+eX2XCG8EHB9JFObQqe2sAmJT
         VWiw==
X-Gm-Message-State: AOAM530ruV/C5p+QZ6BcEsWjKVetKYkp1hLGWz18MNI6JaqhTRe2oFJa
        StqwMf9tETLlVlDWUyBd174uFs+JLWf/tOGMlRE=
X-Google-Smtp-Source: ABdhPJx9bvIrfc/rPOMmJL6ENIXjQD1s6MME5iCACgZQ40zGyEKBznjW8WNpUQtwGQr41ovsEG6z/Nu2hqaxuoMVUis=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr2058302ejc.132.1650098471243; Sat, 16
 Apr 2022 01:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com>
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Apr 2022 11:40:35 +0300
Message-ID: <CAHp75VfmJV4ON7r+cp+CrKrOgU99v=q0ZmrCV4jCC=Aj0q=pDw@mail.gmail.com>
Subject: Re: [v4 00/14] Add support for Bosch BNO055 IMU
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 4:00 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>
>
> This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
> subsystem. It is made up several patches:
>
>   1/13 to 7/12: add some IIO modifiers, and their documentation, to the IIO
>                 core layer, in order to being able to expose the linear
>                 acceleration and Euler angles among standard attributes.
>                 Also update the IIO event monitor tool
>
>   7/13: fix binary attributes didn't work with IIO
>
>   8/13 to 11/13: add the core IIO BNO055 driver and documentation for sysfs
>                  attributes and DT bindings
>
>   12/13: adds serdev BNO055 driver to actually use the IMU via serial line
>
>   13/13: adds I2C BNO055 driver to actually use the IMU via I2C wiring
>
>   14/13: add a documentation file that describe the bno055 driver and
>          specifically the calibration

Thanks for a new version.
So far I have noticed the issues with more than one patch:
1) missed commit message;
2) non-imperative mode of speaking in the commit messages.

Please, take your time to refresh the Submitting Patches documentation
and fix your series accordingly.

-- 
With Best Regards,
Andy Shevchenko
