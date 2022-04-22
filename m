Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2050B153
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444753AbiDVH0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiDVH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:26:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C16B5006B;
        Fri, 22 Apr 2022 00:23:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ks6so14671411ejb.1;
        Fri, 22 Apr 2022 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ckmga5iewVe4NEqSvC8/k1bVhDBRyp3WcuyEXAk3hU=;
        b=PpNKAdIhwwej/a+iKEhoQa1qXge7ez608u/l5uwtwNfnysvKWBQ0cdjbPq5yEZUZ35
         X2JEdNLn1IR2N4ZiG/C5xbs4tXPiDiuvOr+ve3zLQTb2wEY2xFIPB7LtYLR9axlcE/qG
         fVfTxYYy9TIvQhyJ9a6bdJfv8oeATIYEI1hM/IJ8as/VUnLJyLXkPzbyFcSYg4GVDoO0
         vGVY+5hGF5cheJlLxZmIxzGE8NOfkvnEBTUURcHtHji/MkKKzzBlBDl1eulobKi4/WyY
         uwo2z+eoZbHKJj7GT1jcUF5Vfs99V2rN6bGFrtctRr+B3uwwOlJWVlnn/m5zAqdL3enB
         zw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ckmga5iewVe4NEqSvC8/k1bVhDBRyp3WcuyEXAk3hU=;
        b=TrF0x3+xualYfObJT1rkkBjGacZoi0VjPZ/p2E9uXxFU7ZLzOpljd/UgbTaPcNmNWd
         zatuhcPYYmbnkDhu3S19KVI+SR6xOv+ljsKrAMz5h9ifZEaEQk68MLJEyLCk8WQZ40YN
         ixurK/CBnAvHtdkErPqXlyqaTbLw6ITahY6ptIpAJjKRFzXEeEpB8+T2idI645aF2m5n
         LvgmbCyApXJHsKdHGuhrmiHHNyy041aTXLyF910epjkxwwdT6we2WttNJdZmr02sHxEC
         ET5ONUd6mOtmR5Q+JV39l9QTOw5UjEwE2te2fST/M9rgPGqJD/6ZE898EBxWuAJgSlDK
         pzUg==
X-Gm-Message-State: AOAM532gBC2qAH4ffjVRGfKv91PNmTIFGonnzq6bJmOhH2UACgM48QVM
        fm9m7NZK2Zry5ma8p/u9o4izzbHGsuWo1Q==
X-Google-Smtp-Source: ABdhPJxCLeGVVvH9tOb+su2mvPLIvuhRdpdzqU+hDcPh49P2pGyZuANbhEWfISlSKuhxVTeSeruyVQ==
X-Received: by 2002:a17:906:d14e:b0:6ef:b5ab:48e1 with SMTP id br14-20020a170906d14e00b006efb5ab48e1mr2988104ejb.11.1650612213358;
        Fri, 22 Apr 2022 00:23:33 -0700 (PDT)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm463569ejc.150.2022.04.22.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 00:23:32 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:23:30 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk
Message-ID: <YmJX8vNlpd6wQDkg@fedora>
References: <20220421072743.5058-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421072743.5058-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just noticed that this patch is missing the "select CRC16" addition
present in hwmon-next. I apologize for that, will fix in v2.

Thanks,
Aleksa
