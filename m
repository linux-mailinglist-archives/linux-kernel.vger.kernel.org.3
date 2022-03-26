Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4654E80F6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiCZM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 08:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiCZM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 08:58:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35034D256;
        Sat, 26 Mar 2022 05:57:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r23so12035637edb.0;
        Sat, 26 Mar 2022 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+IqwQrreaIW02AJS03/xoNmlaUlmZ/vkoMhCtmeGgTY=;
        b=d0L1mFtnsWjkMbp1xeTZO4YLbtRG3luGFyq51W2lvdnCjC90b6HlUw4oDmRuFvyc7+
         +A622rpmAHOWESqkmAWdkdku6NAY3rBo51vzQSC4MTVZf9SnvDMflXXR8cU5H5mlyjKn
         E7FDjggoKQtZkCz9r2UOuDgfuxS8EHOPTIh+/DiLFNKdH4oCVaQ+qFdOTwRx/2qa/D+v
         2LjpknmG3SuOnKQrAQ//g48ottG98DxLBAJmUR7GL5xvdQdBjn56WpYuomFsoB8yes/d
         owzQU/zU7Xr1vUI2e6FzpQ7b4AcXh3iMhaX/1a0ZD/r9s1ujHtbLHlLeLJF2DYKXDmw8
         dhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+IqwQrreaIW02AJS03/xoNmlaUlmZ/vkoMhCtmeGgTY=;
        b=PMkqUMZBWAXXhsiul84YjZ+A5QGuhyHsa+CFgshh3eBIVZvOqhc1XzBE7t85aeZLqQ
         3I1kyB+4KNZo691loM/o4kJal/zXq6d3AcMqfxAaen9R0Xjqy0TAdiZ6EqMeBuhPELKR
         qvbbFPVnYFvF+TUzCEiVo8xAq6M550z0+JHhkr/ZtX1rFUq3n72d9gEu1qqOFm59AW5C
         D9RmFTHA3VUkK4V3f+9byz3cT6X4kJfQmpm/sl/h8ryy38jRL1M7P1AGOsCsTo+cyYD4
         IPkVQ/oVeKeAUDV4J8eYuhlx+8/u0A35xY+G/SiS2DIZCCnrQqbYqwsU/I7v8IWFzQkq
         d27Q==
X-Gm-Message-State: AOAM532CYf+ItG0kKTux8gzlrX6Bnw9pRLOIWhIlwP3REZ762NAU4cuo
        ygCtUJndmy9Ka+o+2Ms7OkY=
X-Google-Smtp-Source: ABdhPJxr0dkQZIrXSHuQZKoprFCK5SlvrCOgT6kBLhnZZAJezIzj7jUgr6MBFobFAhnoto6sj+vKgg==
X-Received: by 2002:a05:6402:1385:b0:413:2bc6:4400 with SMTP id b5-20020a056402138500b004132bc64400mr4520809edv.94.1648299421216;
        Sat, 26 Mar 2022 05:57:01 -0700 (PDT)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906780400b006ce69ff6050sm3504795ejm.69.2022.03.26.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 05:57:00 -0700 (PDT)
Date:   Sat, 26 Mar 2022 13:56:58 +0100
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-hwmon@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Octo
Message-ID: <Yj8Nmhw7gITs+I6U@fedora>
References: <20220326101250.8076-1-savicaleksa83@gmail.com>
 <202203262032.UaIhk6RY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203262032.UaIhk6RY-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for the mess, this one is on me. :(
Please ignore, I'll fix and resend a proper patch later.

Thanks,
Aleksa
