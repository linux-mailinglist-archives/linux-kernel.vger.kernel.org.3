Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129485B062E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIGOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIGOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:12:48 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4EE175BB;
        Wed,  7 Sep 2022 07:12:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j17so10437417qtp.12;
        Wed, 07 Sep 2022 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Nxa+VNw3flyasK2pC4wEuT0GAzbIk8zvqt0eepx0SsY=;
        b=BLcasJWQ6j6tJRyVL0u0kPVb4wZakIHBpZRYneO1Sve0AF1jVZp3OK2r1sokbUJMOc
         eUD5SDJJbTIM0ZZT5nNtJ8CC75DNAa5qVLUpf/jeNFO8GjxtoxWYlPJkEBMTmVdSnbAo
         oUJvrW6b94tO3wyDq+1PgY55bfNW3SRypTtpU0f6jcobxAjdtZf+arBo1vPqnyql12nf
         UJ5bTzNOpSilUj0TZzNTShtq0Kr3ZCPMMPlNKgrJQuQ32UtcSxtv+FET9hLpANur1ZP1
         OY9ViY2tiKh0ePkq0S6EspdqDPefc0Bzuv+uYqZQy9v9PKof5HvJaoY9BG1sPh/g5CjT
         1MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Nxa+VNw3flyasK2pC4wEuT0GAzbIk8zvqt0eepx0SsY=;
        b=FJ32l3YHMHMZkebDWmPD7ehWJuwLUaj7g0Pz/oZrk4SwEMtOccrsCmbuhjXi5b04a4
         qQhCK7iRdyaHpmQnCTtVRhmoLidPRY1QG/4QO71+tS4dh60Mo9zAT6HO5wahUsDbMqp0
         ktj5K+il3W/OFHFpszDeTNEoBPjlxAk6O8aQ3ljJ9xNG7Z3VVVa4M7zMA73gYG4fEKNF
         eJSRwrvk+NyNKZjOH3eeYq7hVEinKnpXL8Ut/xEjF4FWblYYUxifVWSd4qfVofZZEPj4
         EXb9OWcdlMMdcbQ5kygPBGRPf3o52cnbtgmNoXgWn/FHv/3Wemj/NTK7KoYaJ39xacI8
         KyAw==
X-Gm-Message-State: ACgBeo2OpLPIv28s/efp47XiPSHBt+is78OPsPgKn9Mutw17XZRRLWR5
        L1d3ErgK04axAxhsR8KscLJvTG820kYdJnSe/MM=
X-Google-Smtp-Source: AA6agR7QXnlO6eddnh3zuWCYlRmj+jpEjQt0WJWuKyFvjCFaK/nCs9+C8McJuzclF5IozDnOf9RhzJ8Krc0uuP0gU6M=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr3431126qtx.61.1662559964952; Wed, 07
 Sep 2022 07:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220907132205.28021-1-andrea.merello@iit.it>
In-Reply-To: <20220907132205.28021-1-andrea.merello@iit.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Sep 2022 17:12:09 +0300
Message-ID: <CAHp75Vd6wGPd6MJjEqB=dyrFj36CJi-QRFzy7WsvYgHZDNgG=Q@mail.gmail.com>
Subject: Re: [v7 00/14] Add support for Bosch BNO055 IMU
To:     Andrea Merello <andrea.merello@iit.it>
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
        Andrea Merello <andrea.merello@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
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

On Wed, Sep 7, 2022 at 4:22 PM <andrea.merello@iit.it> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>
>
> This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
> subsystem. It is made up several patches:


These

>   iio: imu: add Bosch Sensortec BNO055 core driver

>   iio: imu: add BNO055 serdev driver

are huge and I will look at them later on.

--
With Best Regards,
Andy Shevchenko
