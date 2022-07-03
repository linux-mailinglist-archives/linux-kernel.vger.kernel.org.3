Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4AE5643B8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 05:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiGCD3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCD3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:29:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB12A1B9;
        Sat,  2 Jul 2022 20:29:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so6413558pjz.1;
        Sat, 02 Jul 2022 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JDtkO9zw1Zx+tY4BtE0J2KyTUxXaqJ0oPl9MLgFkq+E=;
        b=Eq1ADNhfb2FRqxTjGfGQmclelnyDY+7FGuPzGTviITHQz7upMudZjj83qLUFdbgPS2
         vxDD1rQNyenkFtbCD1ptplnYsrc6T107iA8vS2Avdy+u7PvXpjkUR0RObt8w6ReiKyGq
         qKS+YSOOVtplrdib+bVj2855u7AuvVyhObVIAB6F13f78RheLq2oyojugenLfwE9v1K6
         Q27EnBCPAEhLp9uHO/xGBAqFWB0FSN++pfeFhhoFtWNeNNTB5EeQ0+qp+GtIsVanCZjA
         m7o3QI/H08Cm6Tyi7K1cCKjzB98kzPIS4Lv7kMC1U10OSdxhPdbFK6WzqHn2KSRMghuO
         Jo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JDtkO9zw1Zx+tY4BtE0J2KyTUxXaqJ0oPl9MLgFkq+E=;
        b=L6yDITgxiFd3vNI8FWbpVbepdgXq1L4UcFtiu9ge5cp1pLiKBadzFSPQMGD8NJ2U1j
         w5ir3oModZzczxdbLQfeGQVgguTGFoHKO4olZGOP660fEhdfHYQuRrnH0MEeC9qKvnIl
         IEEE1r+L+7fl8GbHRVBtu4g9ZsW3JzyTSvrVLyAOrOVwYJNTv/pu/xuO2tMjMiDL7eX4
         Mr3zry8UXQ3PbXj7mINPANgTwn413qOpInpOmygNnDe2Ta94Ikb0GrkaGilhAIDQbITb
         1SEc+eFFxERPqDZ0OwPWn4Znsg7odrITkLMf3LeO3+yXYQ9joLBmZ2QUOIgT0naw+/pK
         XTjw==
X-Gm-Message-State: AJIora/7pWt1CpAqsF+2qOeao+01hx62qcORvV/oCkxOfyyANN//6LUW
        34mCH2n5WH7KOYywGXVZuno=
X-Google-Smtp-Source: AGRyM1up5Iwzg4aceNQt4guzfIfTGCd1EhMBiXhnu+w1OEi4T/blfz5n8rUjcoErQXCxSsxhjq4iSg==
X-Received: by 2002:a17:902:a502:b0:151:8289:b19 with SMTP id s2-20020a170902a50200b0015182890b19mr27689822plq.149.1656818989365;
        Sat, 02 Jul 2022 20:29:49 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-33.three.co.id. [116.206.28.33])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090a2e8500b001eee7950428sm9089660pjd.44.2022.07.02.20.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 20:29:48 -0700 (PDT)
Message-ID: <85c5fe48-90fd-6ad6-72d8-a3e7929f23e4@gmail.com>
Date:   Sun, 3 Jul 2022 10:29:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: htmldocs: Documentation/ABI/testing/sysfs-bus-iio-sx9324:2:
 WARNING: Unexpected indentation.
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <202207021703.lEW6FLT1-lkp@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <202207021703.lEW6FLT1-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/22 16:23, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   089866061428ec9bf67221247c936792078c41a4
> commit: 4c18a890dff8d95ca234d184773910383a978d45 iio:proximity:sx9324: Add SX9324 support
> date:   5 months ago
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.
> 
> vim +2 Documentation/ABI/testing/sysfs-bus-iio-sx9324
> 
>    > 2	Date:		November 2021
> 

I'm not sure how to fix above, since the Date: field looks OK to me.

CC'ing Akira and Mauro.

-- 
An old man doll... just what I always wanted! - Clara
