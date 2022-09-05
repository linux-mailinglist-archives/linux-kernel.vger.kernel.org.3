Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FB5ADA52
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiIEUj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEUjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:39:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC323B;
        Mon,  5 Sep 2022 13:39:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fc24so10085380ejc.3;
        Mon, 05 Sep 2022 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MFYTMpDTuOqljCy0e6WVr1YZFoccpOOvT2y1YFxKyWs=;
        b=JxF4UW1wBmnNM38jvepvINNoQ0rpkMfc37OYHDYY08tZwLXpEHflBXL/jzJVXKvbBK
         Polw+B/6gXe4npk4AC9ZFbR7jozqhAw+fDCnGwX6oaZJwLmkh/OYes7QvBr2FEo07qML
         vnljmWVF+OEx/RZC1Z+X5Uv05fmX2MEoBknBMXsKPMcaiZJncoguLUSZP+71wcEREbov
         wnQXiABhwaJCNJvJrKmV+nn8X7oitFmS/WAnYLx/nZwihJJJXPrufTBZjOsyHj6fcbFq
         iBrwA2SYoMNLlVBKNQR2+rRzs0mUachfgbSbsrMDxMogdLs5kb2hCrXQEhYEIR+yzDqv
         qaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MFYTMpDTuOqljCy0e6WVr1YZFoccpOOvT2y1YFxKyWs=;
        b=zhDamXIdshF1zmy2lkyz+6XskWH3tukSDTYbX5L088H86rrR7e34Ov1J6Igolhtv/1
         wGdIoiTHQNP4vgURH/4x0haeQHCptfk8NlgYU4fGXd3B+padjyjXstlF588YXjRJmluf
         WaLUnlV+r8vH4eZWAJwwNRJGamZ3fxI2YCeecxIFH00/bd0wCOrSh+xPocpvwryI3ZkF
         ghAobwf1P8mY1Ct13faP0GoSaItF8gaianQACAshNEE7L/quR58w7w79UVcBzA2ck7wB
         NYv4AlUFhegzfVA6rsKPLWgXsVtf1OJjVY4yrG+56eYhtm1VoYHut0z61u7Gub6Itbow
         E2vA==
X-Gm-Message-State: ACgBeo3PnqiGjthxn6EpO1BxKaoIpwPvRWP2P6zhSyy+JDDb00jotlNs
        WU02UmWVEeq1/Yi7lnEpp3U=
X-Google-Smtp-Source: AA6agR75LNkUBRDmOxtSpbt8wQ54+ZxQFFnPOF+GJVV1o9koQZl6v+6mFXEdX7w9E6y9koLEJDaVUA==
X-Received: by 2002:a17:906:fe49:b0:73d:70c5:1a52 with SMTP id wz9-20020a170906fe4900b0073d70c51a52mr38477701ejb.469.1662410359724;
        Mon, 05 Sep 2022 13:39:19 -0700 (PDT)
Received: from fedora ([87.116.166.59])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b0073ce4abf093sm5468099ejh.214.2022.09.05.13.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:39:19 -0700 (PDT)
Date:   Mon, 5 Sep 2022 22:39:17 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-hwmon@vger.kernel.org, kbuild-all@lists.01.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer High Flow Next
Message-ID: <YxZedWsvE82mzIXB@fedora>
References: <20220905142521.6674-1-savicaleksa83@gmail.com>
 <202209060417.oElADHt3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209060417.oElADHt3-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woops, looks like I sent a botched patch. Sorry for the noise,
will send a v2.

Thanks,
Aleksa
